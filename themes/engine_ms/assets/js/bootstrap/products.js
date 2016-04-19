/**
 * Created by wg on 29.02.16.
 */
engine.products = {
    init: function()
    {
        //engine.require('content');
        engine.require('bootstrap-tagsinput.min', '/themes/engine/assets/js/vendor/');

        $(document).on('click', '.b-products-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id);});
        });

        $(document).on('click', '.b-products-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id);
        });

        $(document).on('click', '.b-products-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id);
        });

        $(document).on('click', '.b-products-categories-create', function(){
            //self.location.href= "content/productsCategories/create";
            engine.products.categories.create(0);
        });

        $('#categories').select2();

        var $tree = new engine.tree('productsCategories');
        $tree
            .setUrl('./plugins/productsCategories/tree')
            .setContextMenu('create', t.products.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.products.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.productsCategories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.products.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.productsCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити Категорію?',
                        function()
                        {
                            engine.content.delete(node_id, function(d){
                                if(ACTION == 'create' || ACTION == 'edit'){
                                    self.location.href = 'content/products';
                                }
                            });
                            $tree.refresh();
                        });
                }
            )
            .move(function(e, data){
                engine.request.post({
                    url : './plugins/productsCategories/move',
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
            var infoName = $("#productsCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#productsCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#productsCategoriesForm .info-title, #productsCategoriesForm .into-h1, #productsCategoriesForm .info-keywords, #productsCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#productsCategoriesForm .info-url:eq('+i+')'), title = $('#productsCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

            $('#productsCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#productsCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#productsCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#productsCategories');
            engine.request.get('./plugins/productsCategories/createCategories/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#productsCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.productsCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#productsCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#productsCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#productsCategories');
            engine.request.get('./plugins/productsCategories/editCategories/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#productsCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.productsCategories.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#productsCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#productsCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        }
    }
};

$(document).ready(function(){
   engine.products.init();
});
