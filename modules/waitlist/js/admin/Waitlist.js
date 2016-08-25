/**
 * Created by wg on 31.03.16.
 */
engine.callbacks = {
    init: function()
    {
        //console.log('Init callbacks');

        $( "#tabs" ).tabs({
            beforeLoad: function( event, ui ) {
                ui.jqXHR.fail(function() {
                    ui.panel.html(
                        "Couldn't load this tab. We'll try to fix this as soon as possible. ");
                });
            }
        });

        $(document).on('click', '.b-callbacks-edit', function(){
            var id = $(this).data('id');
            engine.callbacks.edit(id);
        });

        $(document).on('click', '.b-callbacks-approve', function(){
            engine.callbacks.approve($(this).data('id'));
        });

        $(document).on('click', '.b-callbacks-delete', function(){
            engine.callbacks.delete($(this).data('id'));
        });
        $(document).on('click', '.b-callbacks-spam', function(){
            engine.callbacks.spam($(this).data('id'));
        });
        $(document).on('click', '.b-callbacks-restore', function(){
            engine.callbacks.restore($(this).data('id'));
        });
    },
    edit: function(id)
    {
        engine.request.get('module/run/callbacks/edit/' + id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.callbacks.action_edit,
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

                        engine.refreshDataTable('callbacks');
                        //var $tabs = $('#tabs').tabs();
                        //var selected = $tabs.tabs('option', 'active');
                        //$("#tabs").tabs('load',selected);
                        //engine.refreshDataTable('callbacks');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                }
            );
        });
    },
    restore: function(id)
    {
        engine.request.get('module/run/callbacks/restore/' + id, function(d){
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
            t.callbacks.delete_question,
            function()
            {
                engine.request.get('module/run/callbacks/delete/' + id, function(d){
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
            t.callbacks.spam_question,
            function()
            {
                engine.request.get('module/run/callbacks/spam/' + id, function(d){
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
    engine.callbacks.init();
});