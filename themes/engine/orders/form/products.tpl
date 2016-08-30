{*<pre>{print_r($amount)}</pre>*}
{*<pre>{print_r($products)}</pre>*}
<table class="table">
    <thead>
        <tr>
            <th>№</th>
            <th>Назва</th>
            <th>Ціна</th>
            <th>Кількість</th>
            <th>Сума</th>
            <th>Вид.</th>
        </tr>
    </thead>
    <tbody>
    {foreach $products as $product}
        <tr>
            <td>{$product.sku}</td>
            <td>{$product.name}</td>
            <td>{$product.price}</td>
            <td>{$product.quantity}</td>
            <td>{$product.price * $product.quantity}</td>
            <td><a href="javascript:;" class="order-products-delete" data-id="{$product.opid}" title="Видалити"><i class="fa fa-remove"></i></a></td>
        </tr>
    {/foreach}
    <tr>
        <td colspan="4" style="text-align: right">Сума: </td>
        <td><b>{$amount}</b></td>
    </tr>
    </tbody>
</table>

<div class="form-group">
    <label for="prepayment" class="col-sm-3 control-label">Додайте товар</label>
    <div class="col-sm-9">
        <select id="addProduct{$order.id}" class="form-control"></select>
    </div>
</div>
<script>
    $(document).on('click', '.order-products-delete', function(){
        var id = $(this).data('id');
        var d = engine.confirm('Дійсно видалити?', function(){
           engine.request.get("module/run/order/products/delete/" + id, function(res){
               var $tabs = $('#orderTabs{$order.id}').tabs();
               var selected = $tabs.tabs('option', 'active');
               $tabs.tabs('load',selected);
               d.dialog('close');
           });
        });
    });
    $("#addProduct{$order.id}").select2({
        placeholder: "введіть артикул або назву товару",
        minimumInputLength: 3,
        ajax: {
            url: "module/run/order/products/search",
            dataType: 'json',
            quietMillis: 250,
            type: 'POST',
            data: function (params) {
                return {
                    q           : params.term, // search term
                    page        : params.page,
                    currency_id : {$order.currency_id},
                    group_id    : {$order.users_group_id},
                    token       : TOKEN
                };
            }
        }
    }).on("select2:selecting", function(e) {
//        console.log(e.params.args.data.id);return;
        var status_id = $('#status_id').find('option:selected').val();
        status_id = parseInt(status_id);
        if(status_id > 5) {
            engine.alert('Неможливо редагувати товари при даному статусі');
            return;
        }
        engine.request.post({
            url: 'module/run/order/products/create',
            data:{
                orders_id   : {$order.id},
                products_id : e.params.args.data.id,
                currency_id : {$order.currency_id},
                group_id    : {$order.users_group_id},
                token       : TOKEN
            },
            success: function(res)
            {
                var $tabs = $('#orderTabs{$order.id}').tabs();
                var selected = $tabs.tabs('option', 'active');
                $tabs.tabs('load',selected);
            }
        });
    });
</script>