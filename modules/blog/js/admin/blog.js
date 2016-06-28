/**
 * Created by wg on 29.02.16.
 */
engine.blog = {
    init: function()
    {
        //engine.require('content');
        //engine.require('bootstrap-tagsinput.min', '/themes/engine/assets/js/vendor/');

        $(document).on('click', '.b-post-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id, 'module/run/blog');});
        });

        $(document).on('click', '.b-post-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/blog');
        });

        $(document).on('click', '.b-post-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/blog');
        });

        $(document).on('click', '.b-blog-categories-create', function(){
            engine.blog.categories.create(0);
        });

        $('#categories').select2();


        var $tree = new engine.tree('blogCategories');
        $tree
            .setUrl('module/run/blog/categories/tree')
            .setContextMenu('create', t.blog.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.blog.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.blogCategories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.blog.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.blogCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'Дійсно видалити Категорію?',
                        function()
                        {
                            engine.request.get('module/run/blog/categories/delete/'+node_id, function(res){
                                if(res.s ){
                                    if(ACTION == 'create' || ACTION == 'edit'){
                                        self.location.href = 'module/run/blog';
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
                    url : 'module/run/blog/categories/move',
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
            var infoName = $("#blogCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#blogCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#blogCategoriesForm .info-title, #blogCategoriesForm .into-h1, #blogCategoriesForm .info-keywords, #blogCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#blogCategoriesForm .info-url:eq('+i+')'), title = $('#blogCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

            $('#blogCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#blogCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#blogCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#blogCategories');
            engine.request.get('module/run/blog/categories/create/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#blogCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.blogCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#blogCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#blogCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#blogCategories');
            engine.request.get('module/run/blog/categories/edit/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#blogCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.blogCategories.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#blogCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#blogCategoriesForm', d.i);
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
   engine.blog.init();
});
