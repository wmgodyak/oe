{*<pre>{print_r($orders)}</pre>*}
<h3 class="head-red">Мої замовлення:</h3>
<div class="orders">
    {foreach $orders as $order}
    <div class="order">
        <div class="header">
            <ul>
                <li class="number-order">№ {$order.oid}</li>
                <li class="center-block">{date('d.m.Y H:i:s', strtotime($order.created))}</li>
                <li class="right-block">
                    <span class="text-right">Статус: </span><span class="green">{$order.status}</span>
                    {if $order.paid}
                        <br><span style="color: red;">Оплачено</span>
                    {/if}
                </li>
                <li class="clearfix"></li>
            </ul>
        </div>
        <div class="content">

            {foreach $order.products as $product}
            <div class="product">
                <div class="img">
                    <img src="{$app->images->cover($product.id, 'thumbs')}">
                </div>
                <div class="description">
                    <a target="_blank" href="{$product.id}" class="link">{$product.name}</a>
                    <ul class="price">
                        <li>{$product.price} грн</li>
                        <li>{$product.quantity} шт.</li>
                        <li class="text-right">{$product.amount} грн</li>
                        <li class="clearfix"></li>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
            {/foreach}
            <div class="product-sum text-right">
                Разом до сплати: {$order.amount} грн
                {if $order.paid == 0 && $order.status_id >= 6 && $order.status_id < 11 && in_array($order.payment_id, [2,3]) }
                    <a class="btn md red" href="13;?oid={$order.oid}">Оплатити</a>
                {/if}
            </div>
        </div>
    </div>
    {/foreach}
</div>