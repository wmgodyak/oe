engine.translations = {
    init: function()
    {
        console.log('Init translations');
        $(document).on('click', '.b-translations-create', function(){
            engine.translations.create();
        });
        $(document).on('click', '.b-translations-edit', function(){
            engine.translations.edit($(this).data('id'));
        });
        $(document).on('click', '.b-translations-delete', function(){
            engine.translations.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./translations/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.translations.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('translations');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './translations/edit/' + id,
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
                    title: t.translations.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('translations');
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
            t.translations.delete_question,
            function()
            {
                engine.request.get('./translations/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('translations');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.translations.init();
});