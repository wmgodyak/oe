engine.banners = {
    init: function()
    {
        $(document).on('click', '.b-banners-places-create', function(){
            engine.banners.places.create();
        });
        $(document).on('click', '.b-banners-places-edit', function(){
            engine.banners.places.edit($(this).data('id'));
        });
        $(document).on('click', '.b-banners-places-delete', function(){
            engine.banners.places.delete($(this).data('id'));
        });

        $(document).on('click', '.b-banners-create', function(){
            var id=$(this).data('id');
            engine.banners.create(id);
        });
        $(document).on('click', '.b-banners-edit', function(){
            engine.banners.edit($(this).data('id'));
        });
        $(document).on('click', '.b-banners-delete', function(){
            engine.banners.delete($(this).data('id'));
        });
        $(document).on('change', '#data_permanent', function(){
           if($(this).is(':checked')){
               $('#permanent_period').hide();
           } else {
               $('#permanent_period').show();
           }
        });
    },
    places: {
        create: function()
        {
            engine.request.get('./banners/plCreate', function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.banners_places.action_create,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('banners');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            });
        },
        edit: function(id)
        {
            engine.request.post({
                url: './banners/plEdit/' + id,
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
                        title: t.banners_places.action_edit,
                        autoOpen: true,
                        width: 600,
                        modal: true,
                        buttons: buttons
                    });

                    engine.validateAjaxForm('#form', function(d){
                        if(d.s){
                            engine.refreshDataTable('banners');
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
                t.banners_places.delete_question,
                function()
                {
                    engine.request.get('./banners/plDelete/' + id, function(d){
                        if(d > 0){
                            engine.refreshDataTable('banners');
                        }
                    });
                    $(this).dialog('close').dialog('destroy').remove();
                }
            );
        }
    },
    create: function(id)
    {
        engine.request.get('./banners/create/'+id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.banners.action_create,
                autoOpen: true,
                width: 800,
                modal: true,
                buttons: buttons
            });

            $("#data_df, #data_dt").datepicker({
                dateFormat: 'dd.mm.yy'
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('banners');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './banners/edit/' + id,
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
                    title: t.banners.action_edit,
                    autoOpen: true,
                    width: 800,
                    modal: true,
                    buttons: buttons
                });

                $("#data_df, #data_dt").datepicker({
                    dateFormat: 'dd.mm.yy'
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('banners');
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
            t.banners.delete_question,
            function()
            {
                engine.request.get('./banners/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('banners');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.banners.init();
});