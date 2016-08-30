/**
 * Created by wg on 31.03.16.
 */
engine.feedback = {
    init: function()
    {
        //console.log('Init feedback');

        $( "#tabs" ).tabs({
            beforeLoad: function( event, ui ) {
                ui.jqXHR.fail(function() {
                    ui.panel.html(
                        "Couldn't load this tab. We'll try to fix this as soon as possible. ");
                });
            }
        });

        $(document).on('click', '.b-feedback-edit', function(){
            var id = $(this).data('id');
            engine.feedback.edit(id);
        });

        $(document).on('click', '.b-feedback-approve', function(){
            engine.feedback.approve($(this).data('id'));
        });

        $(document).on('click', '.b-feedback-delete', function(){
            engine.feedback.delete($(this).data('id'));
        });
        $(document).on('click', '.b-feedback-spam', function(){
            engine.feedback.spam($(this).data('id'));
        });
        $(document).on('click', '.b-feedback-restore', function(){
            engine.feedback.restore($(this).data('id'));
        });
    },
    edit: function(id)
    {
        engine.request.get('module/run/feedback/edit/' + id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.feedback.action_edit,
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

                        engine.refreshDataTable('feedback');
                        //var $tabs = $('#tabs').tabs();
                        //var selected = $tabs.tabs('option', 'active');
                        //$("#tabs").tabs('load',selected);
                        //engine.refreshDataTable('feedback');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                }
            );
        });
    },
    restore: function(id)
    {
        engine.request.get('module/run/feedback/restore/' + id, function(d){
            if(d > 0){
                var $tabs = $('#tabs').tabs();
                var selected = $tabs.tabs('option', 'active');
                $("#tabs").tabs('load',selected);
            }
        });
        $(this).dialog('close').dialog('destroy').remove();
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.feedback.delete_question,
            function()
            {
                engine.request.get('module/run/feedback/delete/' + id, function(d){
                    if(d > 0){
                        var $tabs = $('#tabs').tabs();
                        var selected = $tabs.tabs('option', 'active');
                        $("#tabs").tabs('load',selected);
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
            t.feedback.spam_question,
            function()
            {
                engine.request.get('module/run/feedback/spam/' + id, function(d){
                    if(d > 0){
                        var $tabs = $('#tabs').tabs();
                        var selected = $tabs.tabs('option', 'active');
                        $("#tabs").tabs('load',selected);
                    }
                });

                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
    engine.feedback.init();
});