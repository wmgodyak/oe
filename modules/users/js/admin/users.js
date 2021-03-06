engine.users = {
    init: function()
    {
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

        $.jstree.defaults.state.key = 'jstree_ug';
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

        $(document).on('click', '.b-users-import', function(){
            engine.users.im.uploadForm();
        });

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
                    }
                },
                {
                    'data[password]': {
                        equalTo: "#data_password"
                    }
                }
            );

            $('#changeAvatar').click(function(){
                $('#adminAvatar')
                    .trigger('click')
                    .change(function(){
                        $('#editProfileForm').submit();
                    });
            });
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

                $('#changeAvatar').click(function(){
                    $('#adminAvatar')
                        .trigger('click')
                        .change(function(){
                            $('#editProfileForm').submit();
                        });
                });
            }
        })
    },
    delete: function(id)
    {
        var dialog = engine.confirm
        (
            t.users.delete_question,
            function()
            {
                engine.request.get('module/run/users/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                dialog.dialog('close');
            }
        );
    },
    ban: function(id)
    {
        var dialog = engine.confirm
        (
            t.users.ban_question,
            function()
            {
                engine.request.get('module/run/users/ban/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                dialog.dialog('close');
            }
        );
    },
    remove: function(id)
    {
        var dialog = engine.confirm
        (
            t.users.remove_question,
            function()
            {
                engine.request.get('module/run/users/remove/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                dialog.dialog('close');
            }
        );
    },
    restore: function(id)
    {
        var dialog = engine.confirm
        (
            t.users.restore_question,
            function()
            {
                engine.request.get('module/run/users/restore/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('users');
                    }
                });
                dialog.dialog('close');
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
                                }
                            }
                        }
                    );
                }
            );
        }
    },
    im: {
        uploadForm: function()
        {
            engine.request.get('module/run/users/import', function(res){
                var dialog = engine.dialog({
                    title: 'Імпорт клієнтів',
                    content: res,
                    width: 500,
                    buttons: {
                        'Вперед' : function()
                        {
                            $('#usersImportUploadForm').submit();
                        }
                    }
                });

                engine.validateAjaxForm
                (
                    '#usersImportUploadForm',
                    function(d){
                        if(d.s){
                            dialog.dialog('close');
                            engine.users.im.customize(d.f);
                        }
                    }
                );
            });
        },

        customize: function(file)
        {
            engine.request.get('module/run/users/import/customize/' + file, function(res){
                if(res.s){
                    var dialog = engine.dialog({
                        title: 'Імпорт клієнтів. Крок 2.',
                        content: res.i,
                        width: 650,
                        buttons: {
                            'Далі' : function()
                            {
                                $('#usersImportCustomizeForm').submit();
                            }
                        }
                    });

                    engine.validateAjaxForm
                    (
                        '#usersImportCustomizeForm',
                        function(d){
                            if(d.s){
                                engine.refreshDataTable('users');
                                dialog.dialog('close');

                                engine.dialog({
                                   title: 'Інформація',
                                   content: "<div style='height: 500px; overflow-y: scroll; text-align: left;'>Імпорт завершено. Імпортовано " + d.res.inserted + ". <br> Лог:  <p style='font-size: 12px;'>" + d.res.error + "</p></div>",
                                   width: 750
                                });
                            }
                        }
                    );

                    $(".csv-conf").change(function(){
                        var v = $(this).find('option:selected').val(), col = $(this).data('id');
                        if(v == 'meta'){
                            $('.meta-col-'+col).show();
                        } else {
                            $('.meta-col-'+col).hide();
                        }
                    });
                }
            });
        }
    }
};

$(document).ready(function(){
    engine.users.init();
});