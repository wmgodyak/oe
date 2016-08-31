<form action="module/run/order/process/{$order.id}" method="post" id="orderForm{$order.id}" class="form-horizontal">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="amount" class="col-sm-3 control-label">Сума</label>
                <div class="col-sm-9">
                    <input id="amount" value="{$order.amount}" readonly class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label for="order_delivery_id" class="col-sm-3 control-label">Доставка</label>
                <div class="col-sm-9">
                    <select name="data[delivery_id]" id="order_delivery_id" data-id="{$order.id}" class="form-control">
                        {foreach $delivery as $item}
                            <option {if $order.delivery_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div id="deliveryRow"></div>
            <div class="form-group">
                <label for="delivery_cost" class="col-sm-3 control-label">Вартість доставки</label>
                <div class="col-sm-9">
                    <input name="data[delivery_cost]" id="delivery_cost" class="form-control" value="{$order.delivery_cost}">
                </div>
            </div>

            <div class="form-group">
                <label for="payment_id" class="col-sm-3 control-label">Оплата</label>
                <div class="col-sm-9">
                    <select name="data[payment_id]" id="order_payment_id" class="form-control">
                        {foreach $payment as $item}
                            <option value="{$item.id}" {if $order.payment_id==$item.id}selected{/if}>{$item.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            {* <div class="form-group">
                <label for="prepayment" class="col-sm-3 control-label">Передплата</label>
                <div class="col-sm-9">
                    <input name="data[prepayment]" id="prepayment" class="form-control" value="{$order.prepayment}">
                </div>
            </div> *}
            <div class="form-group">
                <label for="paid" class="col-md-3 control-label">Оплачено</label>
                <div class="col-md-9" style="text-align: left">
                    <input type="hidden"  name="data[paid]"  value="0" {if $order.paid == 1}disabled{/if}>
                    <input class="switch" type="checkbox" name="data[paid]" id="paid" {if $order.paid == 1}checked{/if} value="1">
                </div>
            </div>

            <div class="form-group">
                <label for="status_id" class="col-sm-3 control-label">Статус</label>
                <div class="col-sm-9">
                    <select name="data[status_id]" id="status_id" class="form-control">
                        {foreach $status as $item}
                            <option value="{$item.id}" {if $order.status_id > $item.id}disabled{/if} {if $order.status_id==$item.id}selected{/if}>{$item.status}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="s_comment" class="col-sm-3 control-label">Коментар до статусу</label>
                <div class="col-sm-9">
                    <textarea name="s_comment" id="s_comment" class="form-control"></textarea>
                </div>
            </div>
        </div>
        <div class="col-md-6">

            <div class="form-group">
                <label for="users_id" class="col-sm-3 control-label">Клієнт</label>
                <div class="col-sm-7">
                    <input type="hidden" name="data[users_id]" id="users_id" value="{$order.users_id}">
                    <input type="text" id="users_name" readonly value="{$order.user.surname} {$order.user.name}">
                </div>
                <div class="col-sm-2">
                    <a href="javascript:;" class="b-o-users-add" title="Додати"><i class="fa fa-plus"></i></a>
                    {if $order.users_id > 0}
                        <a href="javascript:;" class="b-o-users-edit" data-id="{$order.users_id}" title="Редагувати"><i class="fa fa-pencil"></i></a>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Телефон</label>
                <div class="col-sm-9">
                    <input type="text" id="users_phone" readonly value="{$order.user.phone}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-9">
                    <input type="text" id="users_email" readonly value="{$order.user.email}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Група</label>
                <div class="col-sm-9">
                    <input type="text" id="users_group" readonly value="{$order.user.group_name}">
                </div>
            </div>

            <div class="form-group">
                <label for="comment" class="col-sm-3 control-label">Коментар</label>
                <div class="col-sm-9">
                    <textarea name="data[comment]" id="comment" class="form-control">{$order.comment}</textarea>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>
<script>
    var o_delivery_region_id       = '{$order.delivery_region_id}';
    var o_delivery_city_id         = '{$order.delivery_city_id}';
    var o_delivery_department_id   = '{$order.delivery_department_id}';

    {literal}

    function onDeliveryChange()
    {
        console.log('onDeliveryChange');
        var region_id = $("#delivery_region_id").find('option:selected').val(),
            city_id   = $("#delivery_city_id").find('option:selected').val();

        if(typeof region_id != 'undefined' && region_id != '') o_delivery_region_id = region_id;
        if(typeof city_id != 'undefined' && city_id != '') o_delivery_city_id = city_id;

        var delivery_id = $("#order_delivery_id").find('option:selected').val();

        var stpl = _.template(
                '<div class="form-group" id="<%- id%>_row">\
                    <label for="<%- id%>" class="col-sm-3 control-label"><%- label %></label>\
                    <div class="col-sm-9">\
                        <select class="form-control" name="<%-name%>" id="<%- id%>"><%=items%></select>\
                    </div>\
                </div>'
        );

        // trigger to extended options
        engine.request.post({
            url: 'module/run/delivery/onSelect',
            data: {
                delivery_id : delivery_id,
                region_id   : o_delivery_region_id,
                city_id     : o_delivery_city_id
            },
            dataType:'json',
            success: function(d)
            {
                var out = '';

                $(d.areas).each(function(c, e){
                    var opt = '<option value="">--виберіть--</option>';
                    $(e.items).each(function(k, item){
                        opt += '<option '+ (item.id == o_delivery_region_id ? 'selected' : '') +' value="'+ item.id +'">'+ item.name +'</option>';
                    });
                    out += stpl({
                        name: e.name, id: e.id, label: e.label, items: opt
                    });
                });

                $(d.city).each(function(c, e){
                    var opt = '<option value="">--виберіть--</option>';
                    $(e.items).each(function(k, item){
                        opt += '<option '+ (item.id == o_delivery_city_id ? 'selected' : '') +'  value="'+ item.id +'">'+ item.name +'</option>';
                    });

                    out += stpl({
                        name: e.name, id: e.id, label: e.label, items: opt
                    });
                });

                $(d.warehouses).each(function(c, e){
                    var opt = '<option value="">--виберіть--</option>';
                    $(e.items).each(function(k, item){
                        opt += '<option '+ (item.id == o_delivery_department_id ? 'selected' : '') +' value="'+ item.id +'">'+ item.name +'</option>';
                    });
                    out += stpl({
                        name: e.name, id: e.id, label: e.label, items: opt
                    });
                });

                $("#deliveryRow").html(out);
            }
        });
    }

    $("#order_delivery_id").change(function(){

        onDeliveryChange();

        var delivery_id = $("#order_delivery_id").find('option:selected').val();
        // payment
        engine.request.post({
            url: 'module/run/delivery/getPayment',
            data: {
                delivery_id: delivery_id
            },
            success: function(d)
            {
                var out = '';
                $(d.payment).each(function(i,e){
                    out += '<option value="'+ e.id +'">'+ e.name +'</option>'
                });
                $('#order_payment_id').html(out);

            }
        });
    }).trigger('change');

    $(document).on('change', '#delivery_region_id', function(){
        onDeliveryChange();
    });
    $(document).on('change', '#delivery_city_id', function(){
        onDeliveryChange();
    });

    {/literal}
    function setCustomerData(id){
        engine.request.post({
            url: 'module/run/order/customerData',
            data: {
                id: id
            },
            success: function(d){
                var user = d.user;
                $("#users_id").val(user.id);
                $("#users_name").val(user.surname + ' ' + user.name);
                $("#users_phone").val(user.phone);
                $("#users_email").val(user.email);
                $("#users_group").val(user.group_name);
            }
        });
    }

    $(document).on('click', '.b-o-users-add', function(){
        engine.request.get('module/run/order/selectCustomer/{$order.id}', function(res)
        {
            var dd = engine.dialog({
                title   : res.t,
                content : res.m,
                width: 900,
                buttons: {
                    'Додати': function ()
                    {
                        dd.dialog('close');//.dialog('remove');

                        engine.request.get('module/run/users/create', function(d)
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
                                title: t.users.create_title,
                                autoOpen: true,
                                width: 750,
                                modal: true,
                                buttons: buttons
                            });

                            $('#data_phone').mask('+99 (999) 9999999');
                            $('#data_group_id').select2();

                            engine.validateAjaxForm
                            (
                                    '#form',
                                    function(d){
                                        if(d.s){
                                            setCustomerData(d.id);
                                            dialog.dialog('close');
                                            dialog.dialog('destroy');//.remove()
                                        }
                                    },
                                    {
                                        'data[password]': {
                                            equalTo: "#data_password"
                                        }
                                    }
                            );
                        });
//                        d.dialog('close').dialog('remove');
//                        engine.users.create(function(d){
//                            setCustomerData(d.id);
////                            d.dialog('close').dialog('remove');
//                        });
                    },
                    'Зберегти': function ()
                    {
                        dd.dialog('close');//.dialog('remove');
                    }
                }
            });

            $("#selCustomer").select2({
                placeholder: "введіть імя, email або номер телефону",
                minimumInputLength: 3,
                ajax: {
                    url: "module/run/order/customersSearch",
                    dataType: 'json',
                    quietMillis: 250,
                    type: 'POST',
                    data: function (params) {
                        return {
                            q           : params.term, // search term
                            page        : params.page,
                            token       : TOKEN
                        };
                    }
                }
            }).on("select2:selecting", function(e) {
                engine.request.post({
                    url: 'module/run/order/process/{$order.id}',
                    data:{
                        token       : TOKEN,
                        data: {
                            users_id : e.params.args.data.id
                        }
                    },
                    success: function(res)
                    {
                        if(res.s){
                            setCustomerData(e.params.args.data.id);
                            dd.dialog('close');//.dialog('remove');
                        }
                    }
                });
        });
    });
    });

        $(document).on('click', '.b-o-users-edit', function(){
            var id = $(this).data('id');
//            engine.users.edit($(this).data('id'));
            engine.request.post({
                url: 'module/run/users/edit/' + id,
                data: {
                    id: id
                },
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
                        title: t.users.action_edit,
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    $('#data_phone').mask('+99 (999) 9999999');

                    $('#data_group_id').select2();

                    engine.validateAjaxForm('#form', function(d){
                                if(d.s){
                                    setCustomerData(id);
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            },
                            {
                                'data[password]': {
                                 equalTo: "#data_password"
                                }
                            });
                }
            });
        });

        engine.validateAjaxForm('#orderForm'+ {$order.id}, function (res) {
            engine.alert(res.m, 'success');
            engine.closeDialog();
            engine.refreshDataTable('orders');
        });
</script>