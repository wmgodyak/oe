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

    $(document).on('change', '#data_smtp', function(){
       if($(this).is(':checked')){
           $('.check-smtp').attr('readonly', true).removeAttr('required');
       } else {
           $('.check-smtp').removeAttr('readonly').attr('required', true);
       }
    });

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

    $(document).on('click', '.b-newsletter-campaigns-run', function(e){
        e.preventDefault();
        var id = $(this).data('id');

        engine.request.get(
            'module/run/newsletter/campaigns/run/' + id,
            function(d)
            {
                if(d > 0){
                    engine.refreshDataTable('newsletter_campaigns');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            }
        );
    });
    $(document).on('click', '.b-newsletter-campaigns-stop', function(e){
        e.preventDefault();
        var id = $(this).data('id');
        var dialog = engine.confirm
        (
            'Cancel campaign?',
            function()
            {
                engine.request.get(
                    'module/run/newsletter/campaigns/stop/' + id,
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

    $(document).on('click', '.b-newsletter-campaigns-pause', function(e){
        e.preventDefault();
        var id = $(this).data('id');
        engine.request.get(
            'module/run/newsletter/campaigns/pause/' + id,
            function(d)
            {
                if(d > 0){
                    engine.refreshDataTable('newsletter_campaigns');
                }
            }
        );
    });

    $(document).on('click', '.b-newsletter-subscribers-import-from-users', function(){
        engine.request.get('module/run/newsletter/subscribers/importFromContacts', function(d){
            if(d > 0) {
                engine.alert('Контакти оновлено!');
                engine.refreshDataTable('newsletter_campaigns');
            }
        });
    });


    $(document).on('click', '.b-newsletter-subscribers-import', function(){
        engine.newsletter.subscribers.im.uploadForm();
    });
});

engine.newsletter = {
    subscribers: {
        im: {
            uploadForm: function()
            {
                engine.request.get('module/run/newsletter/subscribers/import', function(res){
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
                                engine.newsletter.subscribers.im.customize(d.f);
                            }
                        }
                    );
                });
            },

            customize: function(file)
            {
                engine.request.get('module/run/newsletter/subscribers/import/customize/' + file, function(res){
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
        },
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