/**
 * Created by wg on 31.03.16.
 */
engine.comments = {
    init: function()
    {
        console.log('Init comments');

        $( "#tabs" ).tabs({
            beforeLoad: function( event, ui ) {
                ui.jqXHR.fail(function() {
                    ui.panel.html(
                        "Couldn't load this tab. We'll try to fix this as soon as possible. ");
                });
            }
        });

        $(document).on('click', '.b-comments-reply', function(){
            var id = $(this).data('id');
            engine.comments.reply(id);
        });

        $(document).on('click', '.b-comments-edit', function(){
            var id = $(this).data('id');
            engine.comments.edit(id);
        });

        $(document).on('click', '.b-comments-approve', function(){
            engine.comments.approve($(this).data('id'));
        });

        $(document).on('click', '.b-comments-delete', function(){
            engine.comments.delete($(this).data('id'));
        });
        $(document).on('click', '.b-comments-spam', function(){
            engine.comments.spam($(this).data('id'));
        });
        $(document).on('click', '.b-comments-restore', function(){
            engine.comments.restore($(this).data('id'));
        });
    },
    reply: function(id)
    {
        engine.request.get('module/run/comments/reply/' + id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.comments.action_reply,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm
            (
                '#form',
                function(d){
                    if(d.s){
                        var $tabs = $('#tabs').tabs();
                        var selected = $tabs.tabs('option', 'active');
                        $("#tabs").tabs('load',selected);
                        //engine.refreshDataTable('comments');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                }
            );
        });
    },
    edit: function(id)
    {
        engine.request.get('module/run/comments/edit/' + id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.comments.action_edit,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm
            (
                '#form',
                function(d){
                    if(d.s){
                        var $tabs = $('#tabs').tabs();
                        var selected = $tabs.tabs('option', 'active');
                        $("#tabs").tabs('load',selected);
                        //engine.refreshDataTable('comments');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                }
            );
        });
    },
    approve: function(id)
    {
        engine.request.get('./module/run/comments/approve/' + id, function(d){
            if(d > 0){
                //var $tabs = $('#tabs').tabs();
                //var selected = $tabs.tabs('option', 'active');
                //$("#tabs").tabs('load',selected);
                location.reload(true);
            }
        });
        $(this).dialog('close').dialog('destroy').remove();
    },
    restore: function(id)
    {
        engine.request.get('./module/run/comments/restore/' + id, function(d){
            if(d > 0){
                //var $tabs = $('#tabs').tabs();
                //var selected = $tabs.tabs('option', 'active');
                //$("#tabs").tabs('load',selected);
                location.reload(true);
            }
        });
        $(this).dialog('close').dialog('destroy').remove();
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.comments.delete_question,
            function()
            {
                engine.request.get('./module/run/comments/delete/' + id, function(d){
                    if(d > 0){
                        //var $tabs = $('#tabs').tabs();
                        //var selected = $tabs.tabs('option', 'active');
                        //$("#tabs").tabs('load',selected);
                        location.reload(true);
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    spam: function(id)
    {
        engine.confirm
        (
            t.comments.spam_question,
            function()
            {
                engine.request.get('./module/run/comments/spam/' + id, function(d){
                    if(d > 0){
                        //var $tabs = $('#tabs').tabs();
                        //var selected = $tabs.tabs('option', 'active');
                        //$("#tabs").tabs('load',selected);
                        location.reload(true);
                    }
                });

                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
    engine.comments.init();
});