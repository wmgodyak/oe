engine.guides = {
    init: function()
    {
        console.log('Init guides');
        $(document).on('click', '.b-guides-create', function(){
            var parent_id = $(this).data('parent_id');
            engine.guides.create(parent_id);
        });
        $(document).on('click', '.b-guides-edit', function(){
            engine.guides.edit($(this).data('id'));
        });
        $(document).on('click', '.b-guides-delete', function(){
            engine.guides.delete($(this).data('id'));
        });
    },
    create: function(parent_id)
    {
        engine.request.get('./guides/create/' + parent_id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.guides.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('guides');
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
            url: './guides/edit/' + id,
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
                    title: t.guides.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('guides');
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
            t.guides.delete_question,
            function()
            {
                engine.request.get('./guides/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('guides');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.guides.init();
});