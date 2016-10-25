
engine.ordersStatus = {
    init: function()
    {
        $(document).on('click', '.b-ordersStatus-create', function(){
            engine.ordersStatus.create();
        });
        $(document).on('click', '.b-ordersStatus-edit', function(){
            engine.ordersStatus.edit($(this).data('id'));
        });
        $(document).on('click', '.b-ordersStatus-delete', function(){
            engine.ordersStatus.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./ordersStatus/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.ordersStatus.action_create,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('ordersStatus');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './ordersStatus/edit/' + id,
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
                    title: t.ordersStatus.action_edit,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('ordersStatus');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.ordersStatus.delete_question,
            function()
            {
                engine.request.get('./ordersStatus/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('ordersStatus');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.ordersStatus.init();
});