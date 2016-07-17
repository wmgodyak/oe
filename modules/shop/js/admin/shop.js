/**
 * Created by wg on 29.02.16.
 */
engine.shop = {
    init: function()
    {
        //engine.require('content');
        //engine.require('bootstrap-tagsinput.min', '/themes/engine/assets/js/vendor/');

        $(document).on('click', '.b-product-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити товар?', function(){engine.content.delete(id, 'module/run/shop');});
        });

        $(document).on('click', '.b-product-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/shop/products');
        });

        $(document).on('click', '.b-product-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/shop/products');
        });

        $(document).on('click', '.b-products-delete', function(){
            var id = $(this).data('id');
            var pw = engine.confirm
            (
                'Товар буде переміщено в кошик. Продовжити?',
                function()
                {
                    engine.request.get('module/run/shop/products/delete/'+id, function(res){
                        pw.dialog('destroy').remove();
                        engine.refreshDataTable('content');
                    }, 'json');
                });
        });

        $(document).on('click', '.b-products_categories-delete', function(){
            var id = $(this).data('id');
            //engine.confirm('ДІйсно видалити категорію?', function(){engine.content.delete(id, 'module/run/shop');});
            engine.confirm
            (
                'Дійсно видалити Категорію?',
                function()
                {
                    engine.request.get('module/run/shop/categories/delete/'+id, function(res){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                        engine.refreshDataTable('content');
                    }, 'json');
                });
        });

        $(document).on('click', '.b-products_categories-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/shop/categories');
        });

        $(document).on('click', '.b-products_categories-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/shop/categories');
        });

        $(document).on('click', '.b-shop-categories-create', function(){
            engine.shop.categories.create(0);
        });

        $('#categories').select2();


        var $tree = new engine.tree('shopCategories');
        $tree
            .setUrl('module/run/shop/categories/tree')
            .setContextMenu('create', 'Швидко створити', 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.shop.categories.create(node_id);
                }
            )
            .setContextMenu('edit', 'Швиде редагування', 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                   engine.shop.categories.edit(node_id);
                }
            )
            .setContextMenu('children', 'Список підкатегорій', 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/shop/categories/index/'+node_id;
                }
            )
            .setContextMenu('children1', 'Список товарів', 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/shop/products/index/'+node_id;
                }
            )
            .setContextMenu('del', t.shopCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'Дійсно видалити категорію?',
                        function()
                        {
                            engine.request.get('module/run/shop/categories/delete/'+node_id, function(res){
                                self.location.href = 'module/run/shop';
                            }, 'json');
                        });
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.product({
                    url : 'module/run/shop/categories/move',
                    data: {
                        id: data.node.id,
                        'old_parent' : data.old_parent,
                        'parent' : data.parent,
                        'position' : data.position
                    }
                });
            })
            .init();

        engine.shop.categories.features.init();
        engine.shop.products.features.init();
        engine.shop.products.variants.init();
        engine.shop.import.init();
    },
    categories: {
        before: function()
        {
            var infoName = $("#shopCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#shopCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#shopCategoriesForm .info-title, #shopCategoriesForm .into-h1, #shopCategoriesForm .info-keywords, #shopCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#shopCategoriesForm .info-url:eq('+i+')'), title = $('#shopCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
                var te = title.val() == '';
                $(this).keyup(function(){
                    var text = this.value;

                    if(te) {
                        title.val(text);
                    }

                    var url = engine.content.translit(text, lang);
                    inp.val(url).trigger('change');
                });
            });

            $('#shopCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#shopCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#shopCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#shopCategories');
            engine.request.get('module/run/shop/categories/create/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#shopCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.shopCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#shopCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#shopCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#shopCategories');
            engine.request.get('module/run/shop/categories/edit/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#shopCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.shopCategories.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#shopCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#shopCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        // engine.shop.categories.features
        features : {
            init: function()
            {
                var $features = this;

                /*$(document).on('click', '.b-shop-categories-features-add', function(){
                    var parent_id = $(this).data('parent');
                    var content_id = $('#shopCategoriesFeatures').data('id');
                    $features.create(content_id, parent_id);
                });
                */
                $(document).on('click', '.b-shop-categories-features-select', function(){
                    var parent_id = $(this).data('parent');
                    var content_id = $('#shopCategoriesFeatures').data('id');
                    $features.select(content_id, parent_id);
                });

                $(document).on('click', '.scf-remove', function(){
                    var id = $(this).data('id');
                    $features.delete(id);
                });

                $(document).on('click', '.scf-drop', function(){
                    var id = $(this).data('id');
                    var fc_id = $(this).data('fcid');
                    $features.drop(id, fc_id);
                });

                $features.initSorting();
            },
            initSorting: function(){
                $('#categories_features')
                    .nestable()
                    .on('change', function(e)
                    {
                        var list   = e.length ? e : $(e.target),
                            output = list.data('output');
                            var a = list.nestable('serialize'),
                            sData = [];


                        $(a).each(function(i, o){
                           sData.push(o.id);
                        });

                        engine.request.post({
                            url: 'module/run/shop/categories/features/reorder',
                            data: {o: sData},
                            success: function(){
                                engine.notify('Відсортовано!', 'success');
                            }
                        });
                    });

            },
            select: function(content_id, parent_id){
                engine.request.get('module/run/shop/categories/features/select/'+ content_id, function(d){
                    var pw = engine.dialog({
                        content: d,
                        title: 'Вибір властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Створити нову": function(){
                                pw.dialog('close').remove();
                                engine.shop.categories.features.create(content_id, parent_id);
                            },
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            engine.shop.categories.features.getSelected(content_id);
                        }
                    });

                    $('.cf-features-select').select2();
                });
            },
            getSelected: function(content_id)
            {
                engine.request.get('module/run/shop/categories/features/getSelected/'+ content_id, function(d){
                    $("#content_features_0").html(d);
                    engine.shop.categories.features.initSorting();
                });
            },
            create: function(content_id, parent_id)
            {
                engine.request.post({
                    url: 'module/run/shop/categories/features/create',
                    data: {
                        content_id     : content_id,
                        parent_id      : parent_id
                    },
                    success: function(res){
                        var pw = engine.dialog({
                            content: res,
                            title: 'Створення властивості',
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: {
                                "Зберегти": function(){
                                    $('#formContentFeatures').submit();
                                }
                            }
                        });
                        engine.validateAjaxForm('#formContentFeatures', function(res){
                            if(res.s > 0){
                                pw.dialog('close').remove();
                                engine.shop.categories.features.getSelected(content_id);
                            }
                        });

                        $('.cf-feature-select').select2();

                        $('#data_folder')
                            .change(function(){
                                if($(this).is(':checked')){
                                    $('.fg-show-filter, .fg-multiple, .fg-required').removeAttr('checked').hide();
                                } else{
                                    $('.fg-show-filter, .fg-multiple, .fg-required').show();
                                }
                            });

                        var inp = $('.f-info-name:first'), lang = inp.data('lang'), code = $('#f_data_code');
                        var ce = code.val() == '';
                        inp.keyup(function(){
                            var text = this.value;
                            if(ce) {
                                text = engine.content.translit(text, lang);
                                text = text.replace(/-/g, '_');
                                code.val(text);
                            }
                        });
                    }
                });
            },
            delete: function(id)
            {
                engine.confirm
                (
                    'Видалити звязок властивості з цією категорією?',
                    function()
                    {
                        engine.request.get('module/run/shop/categories/features/delete/'+id, function(res){
                            $('#scf-'+id).remove();
                            engine.closeDialog();
                        });
                    });
            },
            drop: function(id, fc_id)
            {
                engine.confirm
                (
                    'Видалити властивість назавжди?',
                    function()
                    {
                        engine.request.get('module/run/shop/categories/features/drop/'+id, function(res){
                            $('#scf-'+fc_id).remove();
                            engine.closeDialog();
                        });
                    });
            }
        }
    },
    products:{
        // engine.shop.products.features
        features : {
            init: function()
            {
                var $features = this, products_id = $("#productsFeatures").data('id')
                $(document).on('change', '#main_categories_id', function(){
                    var id= this.value;
                    engine.shop.products.features.get(products_id, id);
                });

                $(document).on('click', '.spf-values-add', function(){
                    var features_id = $(this).data('id');
                    $features.values.add(features_id, products_id);
                });

                $(document).on('click', '.b-spf-select', function(){
                    var parent_id = $(this).data('parent'), categories_id = $('#main_categories_id').find('option:selected').val();
                    $features.select(categories_id, products_id, parent_id);
                });

/** ************************/
                /*$(document).on('click', '.b-shop-categories-features-add', function(){
                 var parent_id = $(this).data('parent');
                 var content_id = $('#shopCategoriesFeatures').data('id');
                 $features.create(content_id, parent_id);
                 });
                 */

                $(document).on('click', '.scf-remove', function(){
                    var id = $(this).data('id');
                    $features.delete(id);
                });

                $(document).on('click', '.scf-drop', function(){
                    var id = $(this).data('id');
                    var fc_id = $(this).data('fcid');
                    $features.drop(id, fc_id);
                });
            },
            get: function(products_id, categories_id){
                engine.request.post({
                    url: 'module/run/shop/products/features/index/',
                    data:{categories_id : categories_id, products_id: products_id},
                    success: function(d)
                    {
                        $('#content_features_0').html(d);
                    }
                });
            },
            values: {
                add: function(features_id, products_id)
                {
                    engine.request.get('module/run/shop/products/features/addValue/'+ features_id + '/'+ products_id, function(d){
                        var pw = engine.dialog({
                            content: d,
                            title: 'Додати значення',
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: {
                                "Зберегти": function(){
                                    $('#formProductsFeaturesValues').submit();
                                }
                            }
                        });
                        engine.validateAjaxForm('#formProductsFeaturesValues', function(res){
                            if(res.s > 0){
                                pw.dialog('close').remove();
                                if(res.v){
                                    var opt = '';
                                    $(res.v).each(function(i, e){
                                        opt += "<option selected value='"+ e.id +"'>"+ e.name +"</option>";
                                    });

                                    $('#products_features_' + features_id).html(opt).select2();
                                }
                            }
                        });
                    });
                }
            },
            /** ***************************************************/
            select: function(categories_id,products_id, parent_id){
                engine.request.get('module/run/shop/products/features/select/'+ categories_id, function(d){
                    var pw = engine.dialog({
                        content: d,
                        title: 'Вибір властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Створити нову": function(){
                                pw.dialog('close').remove();
                                engine.shop.products.features.create(categories_id, products_id, parent_id);
                            },
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            engine.shop.products.features.getSelected(categories_id, products_id);
                        }
                    });

                    $('.cf-features-select').select2();
                });
            },
            getSelected: function(categories_id, products_id)
            {
                engine.request.get('module/run/shop/products/features/getSelected/'+ categories_id + '/' + products_id, function(d){
                    $("#content_features_0").html(d);
                });
            },
            create: function(categories_id, products_id, parent_id)
            {
                engine.request.post({
                    url: 'module/run/shop/categories/features/create',
                    data: {
                        content_id     : categories_id,
                        parent_id      : parent_id
                    },
                    success: function(res){
                        var pw = engine.dialog({
                            content: res,
                            title: 'Створення властивості',
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: {
                                "Зберегти": function(){
                                    $('#formContentFeatures').submit();
                                }
                            }
                        });
                        engine.validateAjaxForm('#formContentFeatures', function(res){
                            if(res.s > 0){
                                pw.dialog('close').remove();
                                engine.shop.products.features.getSelected(categories_id, products_id);
                            }
                        });

                        $('.cf-feature-select').select2();

                        $('#data_folder')
                            .change(function(){
                                if($(this).is(':checked')){
                                    $('.fg-show-filter, .fg-multiple, .fg-required').removeAttr('checked').hide();
                                } else{
                                    $('.fg-show-filter, .fg-multiple, .fg-required').show();
                                }
                            });

                        var inp = $('.f-info-name:first'), lang = inp.data('lang'), code = $('#f_data_code');
                        var ce = code.val() == '';
                        inp.keyup(function(){
                            var text = this.value;
                            if(ce) {
                                text = engine.content.translit(text, lang);
                                text = text.replace(/-/g, '_');
                                code.val(text);
                            }
                        });
                    }
                });
            }
        },

        variants: {
            init: function()
            {
                //var content_id = $('#content_id').val();

                $(document).on('click', '.b-products-add-variant', function(){
                    var id = $(this).data('id');
                    engine.shop.products.variants.create(id);
                });
                
                $(document).on('click', '.b-products-rm-variant', function(){
                    var id = $(this).data('id');
                    engine.shop.products.variants.delete(id);
                });
                
                $(document).on('click', '.variant-picture', function(){
                    var id = $(this).data('id');
                    $("#variantsUploadId").val(id);
                    $("#variantsUploadFileInput").click();
                });
                
                var form = $('<form id="variantsUploadImage" action="module/run/shop/products/variants/uploadImage/" method="post" style="display: none" enctype="multipart/form-data">\
                <input type="file" name="image" id="variantsUploadFileInput">\
                <input type="hidden" name="variant_id" id="variantsUploadId">\
                <input type="hidden" name="token" value="'+TOKEN+'">\
                </form>');
                form.appendTo('body');
                engine.validateAjaxForm('#variantsUploadImage', function(d){
                    if(d.s){
                        var a = $('.variant-picture.variant-'+ d.variant_id);
                        a.html($('<img src="'+ d.img +'" style="max-width: 50px;">'));
                    } else{
                        engine.alert(d.m);
                    }
                });
                $(document).on('change', '#variantsUploadFileInput', function(){
                    $("#variantsUploadImage").submit();
                });
            },
            create: function(products_id)
            {
                engine.request.get
                (
                    'module/run/shop/products/variants/create/'+products_id
                    ,
                    function(d)
                    {
                        var pw = engine.dialog({
                            content: d,
                            title: 'Згенеруйте варіанти',
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: {
                                "Зберегти": function(){
                                    $('#productsVariantsForm').submit();
                                }
                            }
                        });

                        engine.validateAjaxForm('#productsVariantsForm', function(d){

                            if(d.s > 0){
                                engine.request.get('module/run/shop/products/variants/get/'+products_id, function(res)
                                {
                                    $("#products_variants_cnt").html(res);
                                    pw.dialog('close').dialog('destroy').remove();
                                });
                            }
                        });
                    }
                );
            },
            delete: function(id)
            {
                engine.confirm
                (
                    'Видалити варіант?',
                    function()
                    {
                        engine.request.get('module/run/shop/products/variants/delete/' + id, function(d){
                            if(d > 0){
                                $('#variant-'+id).remove();
                            }
                        });
                        $(this).dialog('close').dialog('destroy').remove();
                    }
                );
            },
            render: function(selected)
            {
                var cnt = $('#products_variants_cnt'), features = CFV;//, res = [],
                //var row = [];
                //
                //for(var i = 0; i < features.length; i++ ){
                //    if(selected.contains(parseInt(features[i].id))){
                //        row.push(features[i].name);
                //    }
                //}
                //
                //res.push(row);
                //
                //for(i = 0; i < features.length; i++ ){
                //    row[i] = [];
                //    if(selected.contains(parseInt(features[i].id))){
                //        for(var c=0;c<features[i].items.length; c++){
                //            row[i].push(features[i].items[c]);
                //        }
                //    }
                //
                //    res.push(row);
                //}


                //var tr = [];
                //for(var i = 0; i < features.length; i++ ){
                //    var row = [];
                //    for(var c=0;c<features[i].items.length; i++){
                //        row.push()
                //    }
                //}



                //res.th = []; res.tr = [];
                //for(var i = 0; i < features.length; i++ ){
                //    //console.log(features[i]);
                //    var row = [];
                //    res.th.push(features[i].name);
                //    for(var c=0;c< features[i].items.length; c++){
                //        //res.tr[features[i].id].push(features[i].items[c])
                //
                //    }
                //
                //    //row.name= features[i].name;
                //    //res.push(row);
                //}
                /*
                 * <% for(var i=0;i < features.length; i++) {  %>
                 <% if(selected.contains(parseInt(features[i].id)) != false) { %>
                 <th><%= features[i].name %></th>
                 <% } %>
                 <% } %>
                 * */
                var tmpl = _.template($('#variantsTbl').html());
                var d = tmpl({features: features, selected: selected});
                cnt.html(d);
            }
        }
    },
    import : {
        init: function ()
        {
            var bar = $('.bar');
            var percent = $('.percent');
            var status = $('#status');

            function log(m)
            {
                var status = $('#status');
                var str = status.html();
                str = m + '<br>' + str;
                status.html(str);
            }

            function beginImport(adapter, file)
            {
                engine.request.post({
                    url: 'module/run/shop/import/adapter/' + adapter,
                    data: {
                        file: file
                    },
                    success: function(res)
                    {
                        console.log(res);
                        if(res.s){
                            $(res.log).each(function(i, e){
                                log(e);
                            });
                            engine.request.post({
                                url :'module/run/shop/import/adapter/' + adapter + '/getTotalProducts',
                                data: {
                                    file: file
                                },
                                success: function(t)
                                {
                                    t = parseInt(t);
                                    if(t > 0){
                                        parseProducts(adapter, file, 0, t);
                                    }
                                }
                            });
                        }
                    },
                    dataType: 'json',
                    timeout: 3000000,
                    error: function(d){
                        log(d.responseText);
                    }
                });
            }

            function parseProducts(adapter, file, start, total)
            {
                percent.html("Завантаження товарів: (" + start +'/'+ total + ')');
                engine.request.post({
                    url: 'module/run/shop/import/adapter/' + adapter + '/parseProducts/' + start,
                    data: {
                        file: file
                    },
                    success: function(res)
                    {
                        $(res.log).each(function(i, e){
                            log(e);
                        });
                        if(start < total){
                            start++;
                            parseProducts(adapter, file, start, total);
                        }
                    },
                    dataType: 'json',
                    timeout: 3000000,
                    error: function(d){
                        log(d.responseText);
                    }
                });
            }
            $('#shopImport').ajaxForm({
                beforeSend: function() {
                    status.empty();
                    var percentVal = '0%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                },
                uploadProgress: function(event, position, total, percentComplete) {
                    var percentVal = percentComplete + '%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                },
                success: function() {
                    var percentVal = '100%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                },
                complete: function(xhr) {
                    var res = JSON.parse(xhr.responseText);
                    if(res.status == true){
                        beginImport(res.adapter, res.file);
                    }
                }
            });
        }
    }
};

$(document).ready(function(){
   engine.shop.init();
});
