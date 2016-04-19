/**
 * Created by wg on 29.02.16.
 */
engine.pages = {
    init: function()
    {
        engine.require('content');

        $(document).on('click', '.b-pages-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id);});
        });

        $(document).on('click', '.b-pages-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id);
        });

        $(document).on('click', '.b-pages-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id);
        });

        $(document).on('click', '.b-pages-tree-create', function(){
            self.location.href= "content/pages/create";
        });

        var $tree = new engine.tree('pagesTree');
        $tree
            .setUrl('./plugins/pagesTree/tree')
            .setContextMenu('create', t.pages.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='content/pages/create/' + node_id;
                }
            )
            .setContextMenu('edit', t.pages.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                self.location.href='content/pages/edit/' + node_id;
                }
            )
            .setContextMenu('del', t.pages.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити сторінку?',
                        function()
                        {
                            engine.content.delete(node_id, function(d){
                                if(ACTION == 'create' || ACTION == 'edit'){
                                    self.location.href = 'content/pages';
                                }
                            });
                            $tree.refresh();
                        });
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : './plugins/pagesTree/move',
                    data: {
                        id: data.node.id,
                        'old_parent' : data.old_parent,
                        //'old_position' : data.old_position,
                        'parent' : data.parent,
                        'position' : data.position
                    }
                });
            })
            .init();
    }
};

$(document).ready(function(){
   engine.pages.init();
});
