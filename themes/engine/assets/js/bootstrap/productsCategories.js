/**
 * Created by wg on 29.02.16.
 */
engine.productsCategories = {
    init: function()
    {
        engine.require('content');

        $(document).on('click', '.b-productsCategories-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id);});
        });

        $(document).on('click', '.b-productsCategories-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id);
        });

        $(document).on('click', '.b-productsCategories-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id);
        });

        $(document).on('click', '.b-productsCategories-tree-create', function(){
            self.location.href= "content/productsCategories/create";
        });

        var $tree = new engine.tree('productsCategories');
        $tree
            .setUrl('./content/productsCategories/tree?a=productsCategories')
            .setContextMenu('create', t.productsCategories.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='content/productsCategories/create/' + node_id;
                }
            )
            .setContextMenu('edit', t.productsCategories.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                self.location.href='content/productsCategories/edit/' + node_id;
                }
            )
            .setContextMenu('del', t.productsCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити сторінку?',
                        function()
                        {
                            engine.content.delete(node_id, function(d){
                                if(ACTION == 'create' || ACTION == 'edit'){
                                    self.location.href = 'content/productsCategories';
                                }
                            });
                            $tree.refresh();
                        });
                }
            )
            .setContextMenu('products', t.productsCategories.products, 'fa-list', function(o){
                    var node_id= o.reference[0].id;
                    self.location.href='content/products/index/' + node_id;
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : './plugins/productsCategories/move',
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
   engine.productsCategories.init();
});
