/**
 * Created by wg on 29.02.16.
 */
engine.megamenu = {
    init: function()
    {
        $(document).on('click', '.b-post-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id, 'module/run/megamenu');});
        });

        $(document).on('click', '.b-post-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/megamenu');
        });

        $(document).on('click', '.b-post-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/megamenu');
        });

        $(document).on('click', '.b-megamenu-categories-create', function(){
            engine.megamenu.categories.create(0);
        });

        $('#categories').select2();


        $.jstree.defaults.state.key = 'jstree_megamenu';
        var $tree = new engine.tree('megamenuCategories');
        $tree
            .setUrl('module/run/megamenu/categories/tree')
            .setContextMenu('create', t.megamenu.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.megamenu.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.megamenu.categories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.megamenu.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.megamenu.categories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'Дійсно видалити Категорію?',
                        function()
                        {
                            engine.request.get('module/run/megamenu/categories/delete/'+node_id, function(res){
                                if(res.s ){
                                    if(ACTION == 'create' || ACTION == 'edit'){
                                        self.location.href = 'module/run/megamenu';
                                    }
                                    $tree.refresh();
                                    dialog.dialog('destroy').remove();
                                    $tree.jstree('refresh');
                                } else {
                                    alert(res.m);
                                }
                            }, 'json');
                        });
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : 'module/run/megamenu/categories/move',
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
            var infoName = $("#megamenuCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#megamenuCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#megamenuCategoriesForm .info-title, #megamenuCategoriesForm .into-h1, #megamenuCategoriesForm .info-keywords, #megamenuCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#megamenuCategoriesForm .info-url:eq('+i+')'), title = $('#megamenuCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

            $('#megamenuCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#megamenuCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#megamenuCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#megamenuCategories');
            engine.request.get('module/run/megamenu/categories/create/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#megamenuCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.megamenu.categories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#megamenuCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#megamenuCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#megamenuCategories');
            engine.request.get('module/run/megamenu/categories/edit/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#megamenuCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.megamenu.categories.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#megamenuCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#megamenuCategoriesForm', d.i);
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
//                type: "POST",
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
   engine.megamenu.init();
});
