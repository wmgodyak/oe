engine.customers = {
    init: function()
    {
        console.log('Init customers');
        $(document).on('click', '.b-customers-create', function(){
            engine.customers.create();
        });

        $(document).on('click', '.b-customers-edit', function(){
            engine.customers.edit($(this).data('id'));
        });

        $(document).on('click', '.b-customers-delete', function(){
            engine.customers.delete($(this).data('id'));
        });
        $(document).on('click', '.b-customers-restore', function(){
            engine.customers.restore($(this).data('id'));
        });
        $(document).on('click', '.b-customers-remove', function(){
            engine.customers.remove($(this).data('id'));
        });
        $(document).on('click', '.b-customers-ban', function(){
            engine.customers.ban($(this).data('id'));
        });
        $(document).on('click', '.b-customers-group-create', function(){
            engine.customers.group.create(0);
        });

        $(document).on('click','#changeCustomersAvatar',function(){
            $('#customersAvatar')
                .trigger('click')
                .change(function(){
                    $('#form').submit();
                });
        });

        engine.customers.group.tree = new engine.tree('customersGroups');
        engine.customers.group.tree
            .setUrl('module/run/customers/groups/tree')
            .setContextMenu('create', t.customers_group.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.customers.group.create(node_id);
                }
            )
            .setContextMenu('edit', t.customers_group.tree_edit, 'fa-pencil', function(o){
                    var node_id= o.reference[0].id;
                    engine.customers.group.edit(node_id);
                }
            )
            .setContextMenu('del', t.customers_group.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.customers.group.delete(node_id);
                }
            )
            .move(function(e, data){
                console.log(data);

                engine.request.post({
                    url : 'module/run/customers/group/move',
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
        engine.request.get('module/run/customers/create', function(d)
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
                title: t.customers.create_title,
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
                        engine.refreshDataTable('customers');
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
            url: 'module/run/customers/edit/' + id,
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
                    title: t.customers.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#data_phone').mask('+99 (999) 9999999');

                $('#data_group_id').select2();

                engine.validateAjaxForm('#form', function(d){
                        if(d.s){
                            engine.refreshDataTable('customers');
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
            t.customers.delete_question,
            function()
            {
                engine.request.get('module/run/customers/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('customers');
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
            t.customers.ban_question,
            function()
            {
                engine.request.get('module/run/customers/ban/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('customers');
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
            t.customers.remove_question,
            function()
            {
                engine.request.get('module/run/customers/remove/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('customers');
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
            t.customers.restore_question,
            function()
            {
                engine.request.get('module/run/customers/restore/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('customers');
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
                    url: 'module/run/customers/groups/create/'+parent_id,
                    data:{a:1},
                    success: function(d)
                    {
                        var buttons = [
                            {
                                text    : t.common.button_save,
                                "class" : 'btn-success',
                                click   : function(){
                                    $('#customersGroupForm').submit();
                                }
                            }
                        ];

                        var dialog = engine.dialog({
                            content: d,
                            title: t.customers_group.create_title,
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        $('#data_parent_id').select2();

                        engine.validateAjaxForm
                        (
                            '#customersGroupForm',
                            function(d){
                                if(d.s){
                                    //engine.refreshDataTable('customers');
                                    engine.customers.group.tree.refresh();
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
                url: 'module/run/customers/groups/edit/' + id,
                data: {id: id, a: 1},
                success: function(d)
                {
                    var buttons = [
                        {
                            text    : t.common.button_save,
                            "class" : 'btn-success',
                            click   : function(){
                                $('#customersGroupForm').submit();
                            }
                        }
                    ];

                    var dialog = engine.dialog({
                        content: d,
                        title: t.customers_group.action_edit,
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    $('#data_group_id').select2();

                    engine.validateAjaxForm('#customersGroupForm', function(d){
                        if(d.s){
                            engine.customers.group.tree.refresh();
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
                t.customers_group.delete_question,
                function()
                {
                    engine.request.post(
                        {
                            url:'module/run/customers/groups/delete/' + id,
                            data: {a: 1},
                            success: function(d){
                                if(d > 0){

                                    engine.customers.group.tree.refresh();
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
    engine.customers.init();
});