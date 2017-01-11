/**
 * Created by wg on 29.02.16.
 */
engine.guides = {
    init: function()
    {
        $(document).on('click', '.b-guides-delete', function(){
            var id = $(this).data('id');
            engine.guides.delete(id);
        });

        $(document).on('click', '.b-guides-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'guides');
        });

        $(document).on('click', '.b-guides-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'guides');
        });

        $(document).on('click', '.b-guides-create', function(){
            var id = $(this).data('id'); id = typeof id == 'undefined' ? 0 : id;
            engine.guides.create(id);
        });

        $(document).on('click', '.b-guides-edit', function(){
            var id = $(this).data('id');
            engine.guides.edit(id);
        });

        $.jstree.defaults.state.key = 'jstree_guides';
        var $tree = new engine.tree('guidesTree');
        $tree
            .setUrl('guides/tree')
            .setContextMenu('create', t.guides.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.guides.create(node_id);
                }
            )
            .setContextMenu('edit', t.guides.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                    engine.guides.edit(node_id);
                }
            )
            .setContextMenu('del', t.guides.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.guides.delete(node_id);
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.product({
                    url : 'guides/move',
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

    before: function()
    {
        var infoName = $("#guidesForm .info-name");
        infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

        $("#guidesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
        $("#guidesForm .info-title, #guidesForm .into-h1, #guidesForm .info-keywords, #guidesForm .info-description")
            .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

        infoName.each(function(i,e){
            var inp = $('#guidesForm .info-url:eq('+i+')'), title = $('#guidesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
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

        $('#guidesForm #switchLanguages').find('button').click(function(){
            $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
            var code = $(this).data('code');
            $('#guidesForm .switch-lang:not(.lang-'+code+')').hide();
            $('#guidesForm .switch-lang.lang-' + code).show();
        });

    },
    create: function(parent_id)
    {
        var $this = this;
        var $tree = $('#guidesTree');
        engine.request.get('guides/create/' + parent_id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#guidesForm').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.guides.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#guidesForm', function(d){
                if(d.s){
                    engine.refreshDataTable('content');
                    dialog.dialog('destroy').remove();
                    $tree.jstree('refresh');
                } else {
                    engine.showFormErrors('#guidesForm', d.i);
                }
            });

            $this.before();

        });
    },
    edit: function(id)
    {
        var $this = this;
        var $tree = $('#guidesTree');
        engine.request.get('guides/edit/' + id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#guidesForm').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.guides.action_edit,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#guidesForm', function(d){
                if(d.s){
                    engine.refreshDataTable('content');
                    dialog.dialog('destroy').remove();
                    $tree.jstree('refresh');
                } else {
                    engine.showFormErrors('#guidesForm', d.i);
                }
            });

            $this.before();

        });
    },
    delete: function(id)
    {
        var $tree = $('#guidesTree');
       var dialog = engine.confirm
        (
            'Дійсно видалити довідник?',
            function()
            {
                engine.request.get('guides/delete/'+id, function(res){
                    engine.refreshDataTable('content');
                    dialog.dialog('destroy').remove();
                    $tree.jstree('refresh');
                }, 'json');
            });
    }
};

$(document).ready(function(){
   engine.guides.init();
});
