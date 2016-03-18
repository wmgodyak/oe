/**
 * Created by wg on 29.02.16.
 */
engine.posts = {
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
            engine.posts.categories.create(0);
        });

        $('#categories').select2();


        var $tree = new engine.tree('postsCategories');
        $tree
            .setUrl('./plugins/postsCategories/categories')
            .setContextMenu('create', t.posts.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.posts.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.postsCategories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.posts.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.postsCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити Категорію?',
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
        before: function()
        {
            var infoName = $("#postCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#postCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#postCategoriesForm .info-title, #postCategoriesForm .into-h1, #postCategoriesForm .info-keywords, #postCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#postCategoriesForm .info-url:eq('+i+')'), title = $('#postCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

            $('#postCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#postCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#postCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#postsCategories');
            engine.request.get('./plugins/postsCategories/createCategories/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#postCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.postsCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#postCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove()
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#postCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#postsCategories');
            engine.request.get('./plugins/postsCategories/editCategories/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#postCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.postsCategories.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#postCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove()
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#postCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        }
    }
};

$(document).ready(function(){
   engine.posts.init();
});
