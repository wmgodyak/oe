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
            .setContextMenu('create', t.shopCategories.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.shop.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.shopCategories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.shop.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.shopCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'Дійсно видалити Категорію?',
                        function()
                        {
                            engine.request.get('module/run/shop/categories/delete/'+node_id, function(res){
                                self.location.href = 'module/run/shop';
                            }, 'json');
                        });
                }
            )
            .setContextMenu('children', t.shopCategories.tree_children, 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/shop/categories/index/'+node_id;
                }
            )
            .setContextMenu('children', t.shopCategories.tree_products, 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='module/run/shop/products/index/'+node_id;
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

                $features.initSorting();
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
        }
    }
};

$(document).ready(function(){
   engine.shop.init();
});
