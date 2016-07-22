<form action="module/run/order/process/{$order.id}" method="post" id="orderForm{$order.id}" class="form-horizontal">
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label for="delivery_id" class="col-sm-3 control-label">Доставка</label>
                <div class="col-sm-9">
                    <select name="data[delivery_id]" id="delivery_id" data-id="{$order.id}" class="form-control">
                        {foreach $delivery as $item}
                            <option {if $order.delivery_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="delivery_cost" class="col-sm-3 control-label">Вартість доставки</label>
                <div class="col-sm-9">
                    <input name="data[delivery_cost]" id="delivery_cost" class="form-control" value="{$order.delivery_cost}">
                </div>
            </div>
            <div class="form-group">
                <label for="delivery_address" class="col-sm-3 control-label">Адреса доставки</label>
                <div class="col-sm-9">
                    <textarea name="data[delivery_address]" id="delivery_address" class="form-control">{$order.delivery_address}</textarea>
                </div>
            </div>

            <div class="form-group">
                <label for="payment_id" class="col-sm-3 control-label">Оплата</label>
                <div class="col-sm-9">
                    <select name="data[payment_id]" id="payment_id_{$order.id}" class="form-control">
                        {foreach $payment as $item}
                            <option value="{$item.id}" {if $order.payment_id==$item.id}selected{/if}>{$item.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="prepayment" class="col-sm-3 control-label">Передплата</label>
                <div class="col-sm-9">
                    <input name="data[prepayment]" id="prepayment" class="form-control" value="{$order.prepayment}">
                </div>
            </div>
            <div class="form-group">
                <label for="paid" class="col-md-3 control-label">Оплачено</label>
                <div class="col-md-9">
                    <input type="hidden"  name="data[paid]"  value="0" {if $order.paid == 1}disabled{/if}>
                    <input class="switch" type="checkbox" name="data[paid]" id="paid" {if $order.paid == 1}checked{/if} value="1">
                </div>
            </div>

            <div class="form-group">
                <label for="status_id" class="col-sm-3 control-label">Статус</label>
                <div class="col-sm-9">
                    <select name="data[status_id]" id="status_id" class="form-control">
                        {foreach $status as $item}
                            <option value="{$item.id}" {if $order.status_id==$item.id}selected{/if}>{$item.status}</option>
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
                    <textarea name="data[comment]" id="comment" disabled class="form-control">{$order.comment}</textarea>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>
<script>

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