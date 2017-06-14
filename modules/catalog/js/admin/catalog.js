/**
 * Created by wg on 29.02.16.
 */
engine.catalog = {
    init: function()
    {
        //engine.require('content');
        //engine.require('bootstrap-tagsinput.min', '/themes/engine/assets/js/vendor/');

        $(document).on('click', '.b-shop_product-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити товар?', function(){engine.content.delete(id, 'module/run/catalog');});
        });

        $(document).on('click', '.b-shop_product-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/catalog/products');
        });

        $(document).on('click', '.b-shop_product-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/catalog/products');
        });

        $(document).on('click', '.b-shop_products-delete', function(){
            var id = $(this).data('id');
            var pw = engine.confirm
            (
                'Товар буде переміщено в кошик. Продовжити?',
                function()
                {
                    engine.request.get('module/run/catalog/products/delete/'+id, function(res){
                        pw.dialog('destroy').remove();
                        engine.refreshDataTable('content');
                    }, 'json');
                });
        });

        $('#categories').select2();
        $.jstree.defaults.state.key = 'jstree_spmc_';
        var $tree = new engine.tree('catalogCategories');
        $tree
            .setUrl('module/run/catalog/categories/tree')
            .setContextMenu('create', 'Швидко створити', 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.catalog.categories.create(node_id);
                }
            )
            .setContextMenu('edit', 'Швиде редагування', 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                   engine.catalog.categories.edit(node_id);
                }
            )
            .setContextMenu('create1', 'Створити', 'fa-file', function(o){
                   var node_id= o.reference[0].id;
                   self.location.href="module/run/catalog/categories/create/"+node_id;
                }
            )
            .setContextMenu('edit1', 'Редагування', 'fa-pencil', function(o){
                   var node_id= o.reference[0].id;
                   self.location.href="module/run/catalog/categories/edit/"+node_id;
                }
            )
            .setContextMenu('children', 'Список підкатегорій', 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/catalog/categories/index/'+node_id;
                }
            )
            .setContextMenu('children1', 'Список товарів', 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/catalog/products/index/'+node_id;
                }
            )
            .setContextMenu('del', t.catalog.categories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'Дійсно видалити категорію?',
                        function()
                        {
                            engine.request.get('module/run/catalog/categories/delete/'+node_id, function(res){
                                self.location.href = 'module/run/catalog';
                            }, 'json');
                        });
                }
            )
            .move(function(e, data){
                engine.request.post({
                    url : 'module/run/catalog/categories/move',
                    data: {
                        id: data.node.id,
                        'old_parent' : data.old_parent,
                        'parent' : data.parent,
                        'position' : data.position
                    }
                });
            })
            .init();



        $(document).on('click', '.b-shop_category-delete', function(){
            var id = $(this).data('id');
            //engine.confirm('ДІйсно видалити категорію?', function(){engine.content.delete(id, 'module/run/catalog');});
            var dialog= engine.confirm
            (
                'Дійсно видалити Категорію?',
                function()
                {
                    engine.request.get('module/run/catalog/categories/delete/'+id, function(res){
                        dialog.dialog('close');
                        $('#catalogCategories').jstree('refresh');
                        engine.refreshDataTable('content');
                    }, 'json');
                });
        });

        $(document).on('click', '.b-shop_category-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/catalog/categories');
        });

        $(document).on('click', '.b-shop_category-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/catalog/categories');
        });

        $(document).on('click', '.b-shop_category-create', function(){
            engine.catalog.categories.create(0);
        });

        $(document).on
        (
            'click',
            '.catalog-product-change-main-category',
            function()
            {
                var product_id = $("#content_id").val();
                var id = $(this).data('id'), mainCatA = $('#a_main_cat_id');
                $.jstree.defaults.state.key = 'jstree_spmc_' ;//+ product_id;

                engine.request.post({
                    url: 'module/run/catalog/productsCategories/tree',
                    data: {
                        selected: [id],
                        products_id: product_id,
                        is_main: 1
                    },
                    success: function(res){
                        var bi = t.common.button_save;
                        var buttons = {};

                        buttons[bi] =  function(){
                            $('#sp_cat_form').submit();
                        };

                        var dialog = engine.dialog({
                            content: res,
                            title: "Вибір категорії",
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        var inp_selected_nodes = $("#selected_nodes");
                        var $catTree = new engine.tree('sp_cat_tree');
                        $catTree
                            .setUrl('module/run/catalog/productsCategories/get')
                            //.setPlugin('checkbox')
                            .init(function(event,data){
                                var n = data.selected;
                                event.preventDefault();

                                inp_selected_nodes.val(n.join(','))
                            });

                        engine.validateAjaxForm('#sp_cat_form', function(d){
                            if(d.s){
                                mainCatA.attr('href', d.cat.href).attr('data-id', d.cat.id).html(d.cat.name);
                                $('#catalog_product_main_category_id').val(d.cat.id).trigger('change');
                                dialog.dialog('destroy').remove();
                                engine.alert('Категорію збережено');
                            }
                        });
                    },
                    dataType: 'html'
                });

            }
        );

        $(document).on('click', '.catalog-product-delete-category', function(e){
            e.preventDefault();
            var categories_id = $(this).data('id'), product_id = $("#content_id").val();
            engine.request.post({
                url: 'module/run/catalog/productsCategories/remove',
                data: {
                    products_id: product_id,
                    categories_id: categories_id
                },
                success: function(d){
                    var out = '';
                    if(d.cat.length){
                        d.cat.forEach(function(a){
                            out +='<span class="badge badge-info">';
                            out += '<a href="module/run/catalog/categories/edit/'+ a.id+'" target="_blank">'+ a.name +'</a>';
                            out += '<a href="javascript:;" title="Змінити" class="catalog-product-delete-category" data-id="'+ a.id+'"><i class="fa fa-remove"></i></a>';
                            out += '</span>';
                        })
                    }
                    out += '<a href="javascript:;" title="Додати" class="catalog-product-add-category" data-id="{$cat.id}"><i class="fa fa-plus-circle"></i></a>';
                    $('#sp_selected_categories').html(out);
                }
            })
        });

        $(document).on
        (
            'click',
            '.catalog-product-add-category',
            function()
            {
                var product_id = $("#content_id").val();
                $.jstree.defaults.state.key = 'jstree_spc_' + product_id;
                engine.request.post({
                    url: 'module/run/catalog/productsCategories/tree',
                    data: {
                        products_id: product_id,
                        is_main: 0
                    },
                    success: function(res){
                        var bi = t.common.button_save;
                        var buttons = {};

                        buttons[bi] =  function(){
                            $('#sp_cat_form').submit();
                        };

                        var dialog = engine.dialog({
                            content: res,
                            title: "Вибір категорії",
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        var inp_selected_nodes = $("#selected_nodes");

                        var $catTree = new engine.tree('sp_cat_tree');
                        $catTree
                            .setUrl('module/run/catalog/productsCategories/get')
                            //.setPlugin('checkbox')
                            .init(function(event,data){
                                var n = data.selected;
                                event.preventDefault();
                                inp_selected_nodes.val(n.join(','))
                            });

                        engine.validateAjaxForm('#sp_cat_form', function(d){
                            if(d.s){
                                var out = '';
                                if(d.cat.length){
                                    d.cat.forEach(function(a){
                                        out +='<span class="badge badge-info">';
                                        out += '<a href="module/run/catalog/categories/edit/'+ a.id+'" target="_blank">'+ a.name +'</a>';
                                        out += '<a href="javascript:;" title="Змінити" class="catalog-product-delete-category" data-id="'+ a.id+'"><i class="fa fa-remove"></i></a>';
                                        out += '</span>';
                                    })
                                }
                                out += '<a href="javascript:;" title="Додати" class="catalog-product-add-category" data-id="{$cat.id}"><i class="fa fa-plus-circle"></i></a>';
                                $('#sp_selected_categories').html(out);
                                dialog.dialog('destroy').remove();
                                engine.alert('Категорії збережено');
                            }
                        });
                    },
                    dataType: 'html'
                });

            }
        );

        engine.catalog.categories.features.init();
        engine.catalog.products.features.init();
        engine.catalog.products.variants.init();
    },
    categories: {
        before: function()
        {
            var infoName = $("#catalogCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#catalogCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#catalogCategoriesForm .info-title, #catalogCategoriesForm .into-h1, #catalogCategoriesForm .info-keywords, #catalogCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#catalogCategoriesForm .info-url:eq('+i+')'), title = $('#catalogCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

            $('#catalogCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#catalogCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#catalogCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#catalogCategories');
            engine.request.get('module/run/catalog/categories/create/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#catalogCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.catalog.categories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#catalogCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#catalogCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#catalogCategories');
            engine.request.get('module/run/catalog/categories/edit/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#catalogCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.catalog.categories.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#catalogCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#catalogCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        // engine.catalog.categories.features
        features : {
            init: function()
            {
                var $features = this;

                $(document).on('click', '.b-catalog-categories-features-select', function(){
                    var parent_id = $(this).data('parent');
                    var content_id = $('#catalogCategoriesFeatures').data('id');
                    $features.select(content_id, parent_id);
                });

                $(document).on('click', '.scf-edit', function(){
                    var content_id = $('#catalogCategoriesFeatures').data('id');
                    var id = $(this).data('id');
                    $features.edit(id, content_id);
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
                            url: 'module/run/catalog/categoriesFeatures/reorder',
                            data: {o: sData},
                            success: function(){
                                engine.notify('Відсортовано!', 'success');
                            }
                        });
                    });

            },
            select: function(content_id, parent_id){
                engine.request.get('module/run/catalog/categoriesFeatures/select/'+ content_id, function(d){
                    var pw = engine.dialog({
                        content: d,
                        title: 'Вибір властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Створити нову": function(){
                                pw.dialog('close').remove();
                                engine.catalog.categories.features.create(content_id, parent_id);
                            },
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            engine.catalog.categories.features.getSelected(content_id);
                        }
                    });

                    $('.cf-features-select').select2();
                });
            },
            getSelected: function(content_id)
            {
                engine.request.get('module/run/catalog/categoriesFeatures/getSelected/'+ content_id, function(d){
                    $("#content_features_0").html(d);
                    engine.catalog.categories.features.initSorting();
                });
            },
            create: function(content_id, parent_id)
            {
                engine.request.post({
                    url: 'module/run/catalog/categoriesFeatures/create',
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
                                engine.catalog.categories.features.getSelected(content_id);
                            }
                        });

                        $('.cf-feature-select').select2();

                        //$('#data_folder')
                        //    .change(function(){
                        //        if($(this).is(':checked')){
                        //            $('.fg-show-filter, .fg-multiple, .fg-required').removeAttr('checked').hide();
                        //        } else{
                        //            $('.fg-show-filter, .fg-multiple, .fg-required').show();
                        //        }
                        //    });
                        $("#cf_data_type").change(function(){
                            var type = $(this).find('option:selected').val();
                            console.log(type);
                            if(type == 'select'){
                                $('.fg-show-filter, .fg-multiple, .fg-required').show();
                            } else{
                                $('.fg-show-filter, .fg-multiple, .fg-required').removeAttr('checked').hide();
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
            edit: function(id, content_id)
            {
                engine.request.post({
                    url: 'module/run/catalog/categoriesFeatures/edit',
                    data: {
                        id: id
                    },
                    success: function(res){
                        var pw = engine.dialog({
                            content: res,
                            title: 'Редагування властивості',
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
                                engine.catalog.categories.features.getSelected(content_id);
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
                        engine.request.get('module/run/catalog/categoriesFeatures/delete/'+id, function(res){
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
                        engine.request.get('module/run/catalog/categoriesFeatures/drop/'+id, function(res){
                            $('#scf-'+fc_id).remove();
                            engine.closeDialog();
                        });
                    });
            }
        }
    },
    products:{
        gaChangeCategory: function(d){
            console.log(d);
            $.jstree.defaults.state.key = 'jstree_spmcga_' ;//+ product_id;

            engine.request.post({
                url: 'module/run/catalog/products/groupActions/changeMainCategory',
                data: {
                    products: d,
                    is_main: 1
                },
                success: function(res){
                    var bi = t.common.button_save;
                    var buttons = {};

                    buttons[bi] =  function(){
                        $('#sp_cat_form').submit();
                    };

                    var dialog = engine.dialog({
                        content: res,
                        title: "Вибір категорії",
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    var inp_selected_nodes = $("#selected_nodes");
                    var $catTree = new engine.tree('sp_cat_tree');
                    $catTree
                        .setUrl('module/run/catalog/products/groupActions/changeMainCategory/tree')
                        .init(function(event,data){
                            var n = data.selected;
                            event.preventDefault();

                            inp_selected_nodes.val(n.join(','))
                        });

                    engine.validateAjaxForm('#sp_cat_form', function(d){
                        if(d.s){
                            engine.refreshDataTable('content');
                            dialog.dialog('destroy').remove();
                            engine.alert('Операція завершена успішно.');
                        }
                    });
                },
                dataType: 'html'
            });
        },
        features : {
            init: function()
            {
                var $features = this,
                    products_id = parseInt($("#productsFeatures").data('id')),
                    category_id = parseInt($("#catalog_product_main_category_id").val())
                ;

                $(document).on('change', '#catalog_product_main_category_id', function(){

                    category_id = this.value;

                    engine.catalog.products.features.get(products_id, category_id);
                });

                $(document).on('click', '.spf-values-add', function(){
                    var features_id = $(this).data('id');
                    $features.values.add(features_id, products_id);
                });

                $(document).on('click', '.b-spf-select', function(){
                    var parent_id = $(this).data('parent');

                    if(category_id == 0){
                        engine.alert("Please set main category");
                        return;
                    }

                    $features.select(category_id, products_id, parent_id);
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
            },
            get: function(products_id, categories_id){
                engine.request.post({
                    url: 'module/run/catalog/productsFeatures/index/',
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
                    engine.request.get('module/run/catalog/productsFeatures/addValue/'+ features_id + '/'+ products_id, function(d){
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
                engine.request.get('module/run/catalog/productsFeatures/select/'+ categories_id, function(d){
                    var pw = engine.dialog({
                        content: d,
                        title: 'Вибір властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Створити нову": function(){
                                pw.dialog('close').remove();
                                engine.catalog.products.features.create(categories_id, products_id, parent_id);
                            },
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            engine.catalog.products.features.getSelected(categories_id, products_id);
                        }
                    });

                    $('.cf-features-select').select2();
                });
            },
            getSelected: function(categories_id, products_id)
            {
                engine.request.get('module/run/catalog/productsFeatures/getSelected/'+ categories_id + '/' + products_id, function(d){
                    $("#content_features_0").html(d);
                });
            },
            create: function(categories_id, products_id, parent_id)
            {
                engine.request.post({
                    url: 'module/run/catalog/categoriesFeatures/create',
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
                                engine.catalog.products.features.getSelected(categories_id, products_id);
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

                $(document).on('click', '.b-shop_products-add-variant', function(){
                    var id = $(this).data('id');
                    engine.catalog.products.variants.create(id);
                });
                
                $(document).on('click', '.b-shop_products-rm-variant', function(){
                    var id = $(this).data('id');
                    engine.catalog.products.variants.delete(id);
                });
                
                $(document).on('click', '.variant-picture', function(){
                    var id = $(this).data('id');
                    $("#variantsUploadId").val(id);
                    $("#variantsUploadFileInput").click();
                });
                
                var form = $('<form id="variantsUploadImage" action="module/run/catalog/products/variants/uploadImage/" method="post" style="display: none" enctype="multipart/form-data">\
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
                    'module/run/catalog/products/variants/create/'+products_id
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
                                engine.request.get('module/run/catalog/products/variants/get/'+products_id, function(res)
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
                        engine.request.get('module/run/catalog/products/variants/delete/' + id, function(d){
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
                var tmpl = _.template($('#variantsTbl').html());
                var d = tmpl({features: features, selected: selected});
                cnt.html(d);
            }
        }
    }
};

$(document).ready(function(){
   engine.catalog.init();
});
