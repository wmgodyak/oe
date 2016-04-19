
engine.currency = {
    init: function()
    {
        $(document).on('click', '.b-currency-create', function(){
            engine.currency.create();
        });
        $(document).on('click', '.b-currency-edit', function(){
            engine.currency.edit($(this).data('id'));
        });
        $(document).on('click', '.b-currency-delete', function(){
            engine.currency.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./currency/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.currency.create_title,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            $('#data_code').mask('aaa');

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('currency');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './currency/edit/' + id,
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
                    title: t.currency.edit_title,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                $('#data_code').mask('aaa');

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('currency');
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
            t.currency.delete_question,
            function()
            {
                engine.request.get('./currency/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('currency');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.currency.init();
});