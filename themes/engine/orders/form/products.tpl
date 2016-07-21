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
        </tr>
    </thead>
    <tbody>
    {foreach $products as $product}
        <tr>
            <td>{$product.id}</td>
            <td>{$product.name}</td>
            <td>{$product.price}</td>
            <td>{$product.quantity}</td>
            <td>{$product.price * $product.quantity}</td>
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
    $("#addProduct{$order.id}").select2({
        placeholder: "введіть артикул або назву товару",
        minimumInputLength: 0,
        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
            url: "module/run/order/products/search",
            dataType: 'json',
            quietMillis: 250,
            type: 'POST',
            minimumInputLength: 3,
            data: function (params) {
                return {
                    q: params.term, // search term
                    page: params.page,
                    currency_id : {$order.currency_id},
                    group_id    : {$order.users_group_id},
                    token       : TOKEN
                };
            },
            results: function (data, page) { // parse the results into the format expected by Select2.
                // since we are using custom formatting functions we do not need to alter the remote JSON data
                return { results: data.items };
            },
            cache: true
        }
    }).on("select2-selecting", function(e) {

        return;
        var osID = $('#data_status_id').find('option:selected').val();
        osID = parseInt(osID);
        if(osID >= 5) {
            engine.alert('РџРѕРјРёР»РєР°', 'Р’Рё РЅРµ РјРѕР¶РµС‚Рµ РјС–РЅСЏС‚Рё РєС–Р»СЊРєС–СЃС‚СЊ С‚РѕРІР°СЂС–РІ, С‚РѕРјСѓ С‰Рѕ РІРѕРЅРё РІР¶Рµ РІС–РґРїСЂР°РІР»РµРЅС– РІ 1C.', 'error');
            return;
        }
        if($('#ordersProducts').find('tbody').find('tr').length == 1){
            alert('РћРґРёРЅ С‚РѕРІР°СЂ РЅР° Р·Р°РјРѕРІР»РµРЅРЅСЏ.');
            return ;
        }

        var item = e.object, orders_id = $('#orders_id').val();
        $.get('orders/addProduct/' + orders_id + '/' + item.id, function(d)
        {
            if( d > 0 ) {
                var tpl = $('<tr id="row-'+ d +'">\
                        <td>'+ item.id +'</td>\
                        <td>'+ item.text +'</td>\
                        <td><input type="text" value="'+ item.price +'" name="products['+ d +'][price]" id="price_'+ d +'" onchange="if(isNaN(this.value)){ this.value = 0; }; engine.orders.updateItem('+ d +');" class="form-control"></td>\
                        <td><input type="text" value="1" name="products['+ d +'][quantity]" id="quantity_'+ d +'" onchange="if(isNaN(this.value)){ this.value = 0; }; engine.orders.updateItem('+ d +');" class="form-control"></td>\
                        <td id="amount_'+ d +'" class="op-amount">'+ item.price +'</td>\
                        <td><a style="color: red" onclick="engine.orders.deleteProduct('+ d +')" href="javascript:void(0);"><i class="icon-oyi icon-remove"></i></a></td>\
                    </tr>');
                $('#ordersProducts').append(tpl);
            }
        });
    });
</script>