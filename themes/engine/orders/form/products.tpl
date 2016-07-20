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