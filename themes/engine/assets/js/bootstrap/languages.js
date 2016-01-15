engine.languages = {
    init: function()
    {
        console.log('Init languages');
        $(document).on('click', '.b-languages-create', function(){
            engine.languages.create();
        });
        $(document).on('click', '.b-languages-edit', function(){
            engine.languages.edit($(this).data('id'));
        });
        $(document).on('click', '.b-languages-delete', function(){
            engine.languages.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./languages/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.languages.create_title,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            $('#data_code').mask('aa');

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('languages');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './languages/edit/' + id,
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
                    title: t.languages.edit_title,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                $('#data_code').mask('aa');

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('languages');
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
            t.languages.delete_question,
            function()
            {
                engine.request.get('./languages/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('languages');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.languages.init();
});