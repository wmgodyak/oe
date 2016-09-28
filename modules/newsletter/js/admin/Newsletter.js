var sgTree = null;
$(document).ready(function(){
    $.jstree.defaults.state.key = 'jstree_nusug';
    sgTree = new engine.tree('newsletter_subscribers_group');
    sgTree
        .setUrl('module/run/newsletter/subscribers/groups/tree')
        .setContextMenu('edit', 'Edit', 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.newsletter.subscribers.group.edit(node_id);
            }
        )
        .setContextMenu('del', 'Delete', 'fa-remove', function(o){
                var node_id= o.reference[0].id;
                engine.newsletter.subscribers.group.delete(node_id);
            }
        )
        .init();
    
    $(document).on('click', '.b-newsletter-subscribers-group-create', function(){
        engine.newsletter.subscribers.group.create();
    });

    $(document).on('click', '.b-newsletter-subscribers-delete', function(){
        var id = $(this).data('id');
        var dialog = engine.confirm
        (
            'Confirm remove subscriber',
            function()
            {
                engine.request.get('module/run/newsletter/subscribers/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('newsletter_subscribers');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });

            }
        );
    });
    $(document).on('click', '.b-newsletter-campaigns-delete', function(){
        var id = $(this).data('id');
        var dialog = engine.confirm
        (
            'Confirm delete campaigns',
            function()
            {
                engine.request.get(
                    'module/run/newsletter/campaigns/delete/' + id,
                    function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('newsletter_campaigns');
                            dialog.dialog('close');
                            dialog.dialog('destroy').remove()
                        }
                    }
                );

            }
        );
    });
});

engine.newsletter = {
    subscribers: {
        deleteSelected: function(items)
        {
           var dialog = engine.confirm('Confirm delete selected subscribers', function(){
                engine.request.post({
                    url: 'module/run/newsletter/subscribers/deleteSelected',
                    data: {items: items},
                    success: function(res){
                        engine.refreshDataTable('newsletter_subscribers');
                        dialog.dialog('close');
                        engine.alert('Success');
                    }
                });
            });
        },
        moveToGroup: function(items)
        {
            engine.request.post({
                url: 'module/run/newsletter/subscribers/moveToGroup',
                data: {items: items},
                success: function(res){
                   var dialog = engine.dialog({
                       title: 'Move to group',
                       content: res,
                       width: 500,
                       buttons: {
                           move: function(){
                               $("#moveToGroupForm").submit();
                           }
                       }
                    });


                    engine.validateAjaxForm('#moveToGroupForm', function(d){
                        if(d.s){
                            engine.alert('Success');
                            dialog.dialog('close');
                            dialog.dialog('destroy').remove()
                        }
                    });
                },
                dataType: 'html'
            });

        },
        copyToGroup: function(items)
        {
            engine.request.post({
                url: 'module/run/newsletter/subscribers/copyToGroup',
                data: {items: items},
                success: function(res){
                   var dialog = engine.dialog({
                       title: 'Move to group',
                       content: res,
                       width: 500,
                       buttons: {
                           copy: function(){
                               $("#copyToGroupForm").submit();
                           }
                       }
                    });


                    engine.validateAjaxForm('#copyToGroupForm', function(d){
                        if(d.s){
                            engine.alert('Success');
                            dialog.dialog('close');
                            dialog.dialog('destroy').remove()
                        }
                    });
                },
                dataType: 'html'
            });

        },
        group: {
            create: function()
            {
                engine.request.post(
                    {
                        url: 'module/run/newsletter/subscribers/groups/create',
                        data:{a:1},
                        success: function(d)
                        {
                            var buttons = [
                                {
                                    text    : t.common.button_save,
                                    "class" : 'btn-success',
                                    click   : function(){
                                        $('#newsletter_subscribers_group_form').submit();
                                    }
                                }
                            ];

                            var dialog = engine.dialog({
                                content: d,
                                title: 'Create group',
                                autoOpen: true,
                                width: 750,
                                modal: true,
                                buttons: buttons
                            });

                            engine.validateAjaxForm
                            (
                                '#newsletter_subscribers_group_form',
                                function(d){
                                    if(d.s){
                                        sgTree.refresh();
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
                    url: 'module/run/newsletter/subscribers/groups/edit/' + id,
                    data: {id: id, a: 1},
                    success: function(d)
                    {
                        var buttons = [
                            {
                                text    : 'Save',
                                "class" : 'btn-success',
                                click   : function(){
                                    $('#newsletter_subscribers_group_form').submit();
                                }
                            }
                        ];

                        var dialog = engine.dialog({
                            content: d,
                            title: 'Edit group',
                            autoOpen: true,
                            width: 600,
                            modal: true,
                            buttons: buttons
                        });

                        engine.validateAjaxForm('#newsletter_subscribers_group_form', function(d){
                            if(d.s){
                                sgTree.refresh();
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
                    'Confirm delete group',
                    function()
                    {
                        engine.request.get(
                            'module/run/newsletter/subscribers/groups/delete/' + id,
                            function(d)
                            {
                                if(d > 0){
                                    sgTree.refresh();
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            }
                        );
                    }
                );
            }
        }
    }
};