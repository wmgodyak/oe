
engine.delivery = {
    init: function()
    {
        $(document).on('click', '.b-delivery-create', function(){
            engine.delivery.create();
        });
        $(document).on('click', '.b-delivery-edit', function(){
            engine.delivery.edit($(this).data('id'));
        });
        $(document).on('click', '.b-delivery-delete', function(){
            engine.delivery.delete($(this).data('id'));
        });

        $(document).on('click', '.b-delivery-pub', function(){
            engine.delivery.pub($(this).data('id'));
        });
        $(document).on('click', '.b-delivery-hide', function(){
            engine.delivery.hide($(this).data('id'));
        });


        $(document).on('change', '#data_module', function() {
            var module = this.value;

            var tmpl = _.template($('#settingsList').html()), ps =$("#d_settings") ;
            ps.html('');
            if(module == '') return;
            engine.request.post({
                url: 'delivery/getModuleSettings',
                data: {module: module},
                success: function(res){
                    ps.html(tmpl({items: res.s}));
                }
            });
        });

    },
    create: function()
    {
        engine.request.get('./delivery/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.delivery.create_title,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            $('#data_code').mask('aaa');
            $('#data_payment').select2();

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('delivery');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './delivery/edit/' + id,
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
                    title: t.delivery.edit_title,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                $('#data_code').mask('aaa');
                $('#data_payment').select2();
                $('#data_module').trigger('change');

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('delivery');
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
            t.delivery.delete_question,
            function()
            {
                engine.request.get('./delivery/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('delivery');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    pub: function(id)
    {
        engine.request.get('./delivery/pub/' + id, function(d){
            if(d > 0){
                engine.refreshDataTable('delivery');
            }
        });
    },
    hide: function(id)
    {
        engine.request.get('./delivery/hide/' + id, function(d){
            if(d > 0){
                engine.refreshDataTable('delivery');
            }
        });
    }
};

$(document).ready(function(){
   engine.delivery.init();
});