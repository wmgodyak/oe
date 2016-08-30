engine.users = {
    init: function()
    {
        console.log('Init users');
        $(document).on('click', '.b-users-create', function(){
            engine.users.create();
        });

        $(document).on('click', '.b-users-edit', function(){
            engine.users.edit($(this).data('id'));
        });

        $(document).on('click', '.b-users-delete', function(){
            engine.users.delete($(this).data('id'));
        });
        $(document).on('click', '.b-users-restore', function(){
            engine.users.restore($(this).data('id'));
        });
        $(document).on('click', '.b-users-remove', function(){
            engine.users.remove($(this).data('id'));
        });
        $(document).on('click', '.b-users-ban', function(){
            engine.users.ban($(this).data('id'));
        });
        $(document).on('click', '.b-users-group-create', function(){
            engine.users.group.create(0);
        });

        $(document).on('click','#changeusersAvatar',function(){
            $('#usersAvatar')
                .trigger('click')
                .change(function(){
                    $('#form').submit();
                });
        });

        engine.users.group.tree = new engine.tree('usersGroups');
        engine.users.group.tree
            .setUrl('module/run/users/groups/tree')
            .setContextMenu('create', t.users.group.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.users.group.create(node_id);
                }
            )
            .setContextMenu('edit', t.users.group.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                    engine.users.group.edit(node_id);
                }
            )
            .setContextMenu('del', t.users.group.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.users.group.delete(node_id);
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : 'module/run/users/group/move',
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
        engine.request.get('module/run/users/create', function(d)
        {
            var buttons = [
                {
                    text    : t.common.button_save,
                    "class" : 'btn-success',
                    click   : function(){
                        $('#form').submit();
                    }
                }
            ];
            var dialog = engine.dialog({
                content: d,
                title: t.users.create_title,
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
                        engine.refreshDataTable('users');
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
            url: 'module/run/users/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var buttons = [
                    {
                        text    : t.common.button_save,
                        "class" : 'btn-success',
                        click   : function(){
                            $('#form').submit();
                        }
                    }
                ];
                var dialog = engine.dialog({
                    content: d,
                    title: t.users.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#data_phone').mask('+99 (999) 9999999');

                $('#data_group_id').select2();

                engine.validateAjaxForm('#form', function(d){
                        if(d.s){
                            engine.refreshDataTable('users');
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
            t.users.delete_question,
            function()
            {
                engine.request.get('module/run/users/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    ban: function(id)
    {
        engine.confirm
        (
            t.users.ban_question,
            function()
            {
                engine.request.get('module/run/users/ban/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    remove: function(id)
    {
        engine.confirm
        (
            t.users.remove_question,
            function()
            {
                engine.request.get('module/run/users/remove/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    restore: function(id)
    {
        engine.confirm
        (
            t.users.restore_question,
            function()
            {
                engine.request.get('module/run/users/restore/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
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
                    url: 'module/run/users/groups/create/'+parent_id,
                    data:{a:1},
                    success: function(d)
                    {
                        var buttons = [
                            {
                                text    : t.common.button_save,
                                "class" : 'btn-success',
                                click   : function(){
                                    $('#usersGroupForm').submit();
                                }
                            }
                        ];

                        var dialog = engine.dialog({
                            content: d,
                            title: t.users.group.create_title,
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        $('#data_parent_id').select2();

                        engine.validateAjaxForm
                        (
                            '#usersGroupForm',
                            function(d){
                                if(d.s){
                                    //engine.refreshDataTable('users');
                                    engine.users.group.tree.refresh();
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
                url: 'module/run/users/groups/edit/' + id,
                data: {id: id, a: 1},
                success: function(d)
                {
                    var buttons = [
                        {
                            text    : t.common.button_save,
                            "class" : 'btn-success',
                            click   : function(){
                                $('#usersGroupForm').submit();
                            }
                        }
                    ];

                    var dialog = engine.dialog({
                        content: d,
                        title: t.users.group.action_edit,
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    $('#data_group_id').select2();

                    engine.validateAjaxForm('#usersGroupForm', function(d){
                        if(d.s){
                            engine.users.group.tree.refresh();
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
                t.users.group.delete_question,
                function()
                {
                    engine.request.post(
                        {
                            url:'module/run/users/groups/delete/' + id,
                            data: {a: 1},
                            success: function(d){
                                if(d > 0){

                                    engine.users.group.tree.refresh();
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
    engine.users.init();
});