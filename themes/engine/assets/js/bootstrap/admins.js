engine.admins = {
    init: function()
    {
        console.log('Init admins');
        $(document).on('click', '.b-admins-create', function(){
            engine.admins.create();
        });
        $(document).on('click', '.b-admins-edit', function(){
            engine.admins.edit($(this).data('id'));
        });
        $(document).on('click', '.b-admins-delete', function(){
            engine.admins.delete($(this).data('id'));
        });

        $(document).on('click','#changeAdminAvatar',function(){
            $('#adminAvatar')
                .trigger('click')
                .change(function(){
                    $('#form').submit();
                });
        });

        engine.admins.group.tree = new engine.tree('usersGroup');
        engine.admins.group.tree
            .setUrl('./plugins/adminsGroup/tree')
            .setContextMenu('create', t.admins_group.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.admins.group.create(node_id);
                }
            )
            .setContextMenu('edit', t.admins_group.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                    engine.admins.group.edit(node_id);
                }
            )
            .setContextMenu('del', t.admins_group.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.admins.group.delete(node_id);
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                   url : './plugins/adminsGroup/move',
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


    },
    create: function()
    {
        engine.request.get('./admins/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.admins.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            $('#data_phone').mask('+99 (999) 9999999');
            $('#data_group_id').select2();

            engine.validateAjaxForm
            (
                '#form',
                function(d){
                    if(d.s){
                        engine.refreshDataTable('admins');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                },
                {
                    'data[password]': {
                        equalTo: "#data_password"
                    }
                }
            );
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './admins/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.admins.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#data_phone').mask('+99 (999) 9999999');

                $('#data_group_id').select2();

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('admins');
                        if(d.a == null){
                            dialog.dialog('close');
                            dialog.dialog('destroy').remove()
                        } else{
                            $('.edit-admin-avatar').attr('src', d.a);
                        }
                    }
                },
                    {
                        'data[password]': {
                            equalTo: "#data_password"
                        }
                    });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.admins.delete_question,
            function()
            {
                engine.request.get('./admins/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('admins');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    group: {
        tree: null,
        create: function(parent_id)
        {
            engine.request.post(
                {
                    url: './plugins/adminsGroup/create/'+parent_id,
                    data:{a:1},
                    success: function(d)
                    {
                        var bi = t.common.button_save;
                        var buttons = {};
                        buttons[bi] =  function(){
                            $('#adminsGroupForm').submit();
                        };
                        var dialog = engine.dialog({
                            content: d,
                            title: t.admins_group.create_title,
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        $('#data_parent_id').select2();

                        engine.validateAjaxForm
                        (
                            '#adminsGroupForm',
                            function(d){
                                if(d.s){
                                    //engine.refreshDataTable('admins');
                                    engine.admins.group.tree.refresh();
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            }
                        );
                    }
                });
        },
        edit: function(id)
        {
            engine.request.post({
                url: './plugins/adminsGroup/edit/' + id,
                data: {id: id, a: 1},
                success: function(d)
                {
                    var bi = t.common.button_save;
                    var buttons = {};
                    buttons[bi] =  function(){
                        $('#adminsGroupForm').submit();
                    };
                    var dialog = engine.dialog({
                        content: d,
                        title: t.admins_group.edit_title,
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    $('#data_group_id').select2();

                    engine.validateAjaxForm('#adminsGroupForm', function(d){
                            if(d.s){
                                engine.admins.group.tree.refresh();
                                dialog.dialog('close');
                                dialog.dialog('destroy').remove()
                            }
                        });
                }
            })
        },
        delete: function(id)
        {
            var dialog = engine.confirm
            (
                t.admins_group.delete_question,
                function()
                {
                    engine.request.post(
                        {
                            url:'./plugins/adminsGroup/delete/' + id,
                            data: {a: 1},
                            success: function(d){
                                if(d > 0){

                                    engine.admins.group.tree.refresh();
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            }
                        }
                    );
                }
            );
        }
    }
};

$(document).ready(function(){
    engine.admins.init();
});