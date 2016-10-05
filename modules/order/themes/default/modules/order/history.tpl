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
            {if $order.kits|count}
                {*<pre>{print_r($order.kits)}</pre>*}
                <div class="promotion-banner">
                    <div class="heading">Комплект</div>
                    {foreach $order.kits as $kit}
                        <div class="promotion-banner-wrap">
                            <div class="content">
                                <div class="item item1">
                                    <div class="img-block">
                                        <div class="img" style="background-image: url('{$product.image}');"></div>
                                    </div>
                                    <div class="name">{$product.name}</div>
                                    <div class="price-row">
                                        <div class="price">{$product.price}{$t.shop.currency.uah}</div>
                                    </div>
                                </div>
                                {foreach $kit.products as $item}
                                    <div class="item item2">
                                        <div class="img-block">
                                            <div class="img" style="background-image: url('{$item.img}');"></div>
                                        </div>
                                        <div class="name">{$item.name}</div>
                                        <div class="price-row">
                                            <div class="old-price">{$item.original_price} грн</div>
                                            <div class="price">{$item.price} грн</div>
                                        </div>
                                    </div>
                                {/foreach}
                                <div class="equals">
                                    <div class="row">
                                        <div class="new-price">
                                            {$kit.amount} грн
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="old-price">
                                            {$kit.original_amount} грн
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class=""><br></div>
                    {/foreach}
                </div>
            {/if}
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