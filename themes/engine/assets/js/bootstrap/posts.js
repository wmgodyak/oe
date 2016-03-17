/**
 * Created by wg on 29.02.16.
 */
engine.posts = {
    tree: null,
    init: function()
    {
        engine.require('content');

        $(document).on('click', '.b-posts-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id);});
        });

        $(document).on('click', '.b-posts-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id);
        });

        $(document).on('click', '.b-posts-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id);
        });

        $(document).on('click', '.b-posts-categories-create', function(){
            //self.location.href= "content/postsCategories/create";
        });

        var $tree = new engine.tree('postsCategories');
        this.tree = $tree;
        $tree
            .setUrl('./plugins/postsCategories/categories')
            .setContextMenu('create', t.posts.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    //self.location.href='content/postsCategories/create/' + node_id;
                }
            )
            .setContextMenu('edit', t.postsCategories.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                //self.location.href='content/postsCategories/edit/' + node_id;
                }
            )
            .setContextMenu('del', t.postsCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити сторінку?',
                        function()
                        {
                            engine.content.delete(node_id, function(d){
                                if(ACTION == 'create' || ACTION == 'edit'){
                                    self.location.href = 'content/posts';
                                }
                            });
                            $tree.refresh();
                        });
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : './plugins/postsCategories/move',
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
        create: function(parent_id)
        {
            var $tree = this.tree;
            engine.request.get('./postsCategories/create/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#form').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.postsCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        $tree.refresh();
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    } else {
                        engine.showFormErrors('#form', d.i);
                    }
                });
            });
        }
    }
};

$(document).ready(function(){
   engine.posts.init();
});
