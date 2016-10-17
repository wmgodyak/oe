
engine.payment = {
    init: function()
    {
        $(document).on('click', '.b-payment-create', function(){
            engine.payment.create();
        });
        $(document).on('click', '.b-payment-edit', function(){
            engine.payment.edit($(this).data('id'));
        });
        $(document).on('click', '.b-payment-delete', function(){
            engine.payment.delete($(this).data('id'));
        });
        $(document).on('click', '.b-payment-pub', function(){
            engine.payment.pub($(this).data('id'));
        });
        $(document).on('click', '.b-payment-hide', function(){
            engine.payment.hide($(this).data('id'));
        });

        $(document).on('change', '#data_module', function() {
            var module = this.value;

            var tmpl = _.template($('#settingsList').html()), ps =$("#p_settings") ;
            ps.html('');
            if(module == '') return;
            engine.request.post({
                url: 'payment/getModuleSettings',
                data: {module: module},
                success: function(res){
                    ps.html(tmpl({items: res.s}));
                }
            });
        });
    },
    create: function()
    {
        engine.request.get('./payment/create', function(d)
        {
            var buttons = [
                {
                    text    : t.common.button_save,
                    "class" : 'btn-success',
                    click   : function(){
                        $('#form').submit();
                    }
                }
            ];
            var dialog = engine.dialog({
                content: d,
                title: t.payment.create_title,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            $('#data_code').mask('aaa');
            $('#data_delivery,#data_module').select2();

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('payment');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './payment/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var buttons = [
                    {
                        text    : t.common.button_save,
                        "class" : 'btn-success',
                        click   : function(){
                            $('#form').submit();
                        }
                    }
                ];
                var dialog = engine.dialog({
                    content: d,
                    title: t.payment.action_edit,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                $('#data_code').mask('aaa');
                $('#data_delivery,#data_module').select2();
                $('#data_module').trigger('change');

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('payment');
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
            t.payment.delete_question,
            function()
            {
                engine.request.get('./payment/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('payment');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    pub: function(id)
    {
        engine.request.get('./payment/pub/' + id, function(d){
            if(d > 0){
                engine.refreshDataTable('payment');
            }
        });
    },
    hide: function(id)
    {
        engine.request.get('./payment/hide/' + id, function(d){
            if(d > 0){
                engine.refreshDataTable('payment');
            }
        });
    }
};

$(document).ready(function(){
   engine.payment.init();
});