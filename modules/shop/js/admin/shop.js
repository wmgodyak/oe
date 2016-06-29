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
            engine.content.pub(id, 'module/run/shop');
        });

        $(document).on('click', '.b-product-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/shop');
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
        }
    },
    tags : function()
    {
        //var tags =$(".tags-input"), id=tags.data('category'), lang_id = tags.data('lang');
//        tags.on('itemRemoved', function(event) {
////            console.log('item removed : '+event.item, id);
//            $.ajax({
//                type: "product",
//                url:'plugins/tags/remove',
//                data: {
//                    name: event.item,
//                    id: id,
//                    lang_id: lang_id
//                },
//                dataType: 'html'
//            });
//
//            return true;
//        });
    }
};

$(document).ready(function(){
   engine.shop.init();
});
