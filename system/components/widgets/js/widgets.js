engine.widgets = {
    init: function()
    {
        $(document).on('click','.b-widgets-form', function(){
            var widget = $(this).data('id'), area = $(this).data('area');
            engine.widgets.form(widget, area);
        });

        $(document).on('click','.b-widgets-delete', function(){
            var widget = $(this).data('id'), area = $(this).data('area');
            engine.widgets.delete(widget, area);
        });

        $(document).on('change', '#inst_available_widgets', function(){
            var widget = $(this).find('option:selected').attr('value'), area = $('#area').val()
            engine.widgets.add(widget, area);
        });
    },
    form: function(widget, area)
    {
        if(widget == '') return;

        engine.request.post({
            url: 'widgets/form',
            data:{
                widget : widget,
                area   : area
            },
            success: function(res)
            {
                var pw = engine.dialog({
                    content: res,
                    title: 'Налаштування віджету',
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: {
                        "Зберегти": function(){
                            $('#widgetForm').submit();
                        }
                    }
                });
                engine.validateAjaxForm('#widgetForm', function(d){
                    pw.dialog('close');
                });
            }
        });
    },
    add: function(widget, area)
    {
        if(widget == '') return;

        engine.request.post({
            url: 'widgets/add',
            data:{
                widget : widget,
                area   : area
            },
            success: function(res)
            {
                engine.refreshDataTable('widgets');
                console.log(res);
            }
        });
    },
    delete: function(widget, area)
    {
        engine.confirm
        (
            t.widgets.delete_question,
            function()
            {
                engine.request.post({
                    url: 'widgets/delete',
                    data: {
                        widget : widget,
                        area   :  area
                    },
                    success: function(d){
                        if(d > 0){
                            engine.refreshDataTable('widgets');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }

};
$(document).ready(function(){
   engine.widgets.init();
});