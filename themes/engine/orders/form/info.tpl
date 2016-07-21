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
                    <input type="hidden" name="data[users_id]" id="users_id">
                    <input type="text" readonly value="{$order.user.surname} {$order.user.name}">

                    {*<select name="data[users_id]" id="users_id" class="form-control">*}
                        {*{foreach $users as $item}*}
                            {*<option value="{$item.id}" {if $order.users_id == $item.id}selected{/if}>{$item.surname} {$item.name}</option>*}
                        {*{/foreach}*}
                    {*</select>*}
                </div>
                <div class="col-sm-2">
                    {if $order.users_id > 0}
                        <a href="javascript:;" class="b-o-users-edit" data-id="{$order.users_id}" title="Редагувати"><i class="fa fa-pencil"></i></a>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Телефон</label>
                <div class="col-sm-9">
                    <input type="text" readonly value="{$order.user.phone}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-9">
                    <input type="text" readonly value="{$order.user.email}">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Група</label>
                <div class="col-sm-9">
                    <input type="text" readonly value="{$order.user.group_name}">
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

    $(document).on('click', '.b-o-users-edit', function(){
        engine.users.edit($(this).data('id'));
    });
    engine.validateAjaxForm('#orderForm'+ {$order.id}, function (res) {
        engine.alert(res.m, 'success');
        engine.closeDialog();
        engine.refreshDataTable('orders');
    });
</script>