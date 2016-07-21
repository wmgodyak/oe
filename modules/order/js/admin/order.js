engine.orders = {
    init: function()
    {
        $(document).on('click', '.b-orders-edit', function(){
            engine.orders.edit($(this).data('id'));
        });

        $(document).on('click', '.b-orders-delete', function(){
            engine.orders.delete($(this).data('id'));
        });

        $(document).on('change', '#delivery_id', function(){
            var id = $(this).data('id');
            var delivery_id = $(this).find('option:selected').val();
            engine.request.post({
                url  : '/route/delivery/getPayment',
                data : {delivery_id: delivery_id},
                success: function(d)
                {
                    var out = '';
                    $(d.payment).each(function(i,e){
                        out += '<option value="'+ e.id +'">'+ e.name +'</option>'
                    });
                    $('#payment_id_'+id).html(out);
                }
            })
        });

    },
    edit: function(id)
    {
        engine.request.get('module/run/order/edit/'+id, function(res)
        {
           var d = engine.dialog({
               title   : res.t,
               content : res.m,
               width: 750,
               buttons: {
                   'Зберегти': function ()
                   {
                       $('#orderForm'+ id).submit();
                   }
               }
           });
            //engine.styleInputs();
            $('#orderTabs'+ id).tabs();
        });
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.order.delete_question,
            function()
            {
                engine.request.get('./module/run/order/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('orders');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }

};
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
        engine.request.get('./module/run/order/status/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.order.status.action_create,
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
            url: './module/run/order/status/edit/' + id,
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
                    title: t.order.status.action_edit,
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
            t.order.status.delete_question,
            function()
            {
                engine.request.get('./module/run/order/status/delete/' + id, function(d){
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
    engine.orders.init();
    engine.ordersStatus.init();
});