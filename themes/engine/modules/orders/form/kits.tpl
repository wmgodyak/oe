{if $kits|count}
    <table class="table">
        <thead>
            <tr>
                <th>№</th>
                <th>Назва</th>
                <th>Ціна</th>
            </tr>
        </thead>
        <tbody>
        {foreach $kits as $kit}
            <tr><td colspan="3" style="text-align: left; font-weight: bold;">Комплект {$kit.product_name} , {$kit.kits_products_price} грн. Кількість: {$kit.quantity} шт.</td></tr>
        {foreach $kit.products as $product}
            <tr>
                <td>{$product.sku}</td>
                <td>{$product.name}</td>
                <td>{$product.price}</td>
            </tr>
        {/foreach}
            <tr>
                <td colspan="2" style="text-align: right">Сума: </td>
                <td><b>{$kit.amount}</b></td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <div class="clear"><br></div>
{/if}