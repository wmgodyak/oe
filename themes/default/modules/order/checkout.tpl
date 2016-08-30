
<div class="container clearfix">
    {if !isset($smarty.session.cart) || empty($smarty.session.cart)}
        <p>Ваш кошик порожній. Нічого замовляти</p>
    {else}
        {assign var='amount' value="0"}
        {assign var='bonus' value="0"}
        {*<pre>{print_r($settings)}</pre>*}
        <!-- begin aside -->
        <aside class="aside">

            <div class="goods-list">
                <div class="goods-list__top-row">
                    <div class="item item1">
                        Склад замовлення:
                    </div>
                    <div class="item item-right">
                        <a href="10" class="edit">Змінити замовлення</a>
                    </div>
                </div>
                <div class="goods-list__main">

                    {foreach $mod->order->cart->products() as $item}
                        <div class="goods-list__row">
                            <div class="item item1">
                                {if isset($item.img.image)}
                                    <img src="{$item.img.path}thumbs/{$item.img.image}" alt="">
                                {else}
                                    <img src="/uploads/noimage.jpg" alt="">
                                {/if}
                            </div>
                            <div class="item item2">
                                <div class="name">
                                    <a href="{$item.id}">{$item.name}</a>
                                </div>
                                <div class="songle-price">
                                    {$item.price}  x   {$item.quantity}   =   {$item.price * $item.quantity} грн
                                </div>
                                <div class="bonus">
                                    <span class="red">Ваш СМА бонус: </span><span class="green">+{round($settings.modules.Shop.config.bonus_rate * $item.price * $item.quantity, 2)} грн</span>
                                </div>
                            </div>
                        </div>

                        {assign var='amount' value=$amount + $item.price * $item.quantity }
                        {assign var='bonus' value=$bonus + round($settings.modules.Shop.config.bonus_rate * $item.price * $item.quantity, 2) }
                    {/foreach}
                </div>
            </div>
            {foreach $mod->order->cart->kits() as $kit}
                {*<pre>{print_r($kit)}</pre>*}
                <div class="promotion-banner" style="float: none; width: 100%; padding: 0">
                    <div class="promotion-banner-wrap">
                        <div class="content">
                            <div class="item item1">
                                <div class="img-block">
                                    <div class="img" style="background-image: url('{$kit.product.img}');"></div>
                                </div>
                                <div class="name">{$kit.product.name}</div>
                                <div class="price-row">
                                    <div class="price">{$kit.product.price} грн</div>
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
                                        {round($kit.amount,2)} грн
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="old-price">
                                        {round($kit.original_amount,2)} грн
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div><br></div>
                {assign var='amount' value=$amount + $kit.amount}
                {assign var='bonus' value=$bonus + round($settings.modules.Shop.config.bonus_rate * $kit.amount, 2) }
            {/foreach}
        </aside>

        <!-- end aside -->
        <form id="checkout" method="post" action="route/order/checkout" class="order-page__content">

            <div class="heading">
                Оформити замовлення
            </div>

            <table class="info">
                <tr>
                    <td colspan="3"><h3 class="head-red">Ваші контактні дані:</h3></td>
                </tr>
                <tr>
                    <td><label for="">Ваше ім’я*</label></td>
                    <td><input tabindex="1" type="text" placeholder="Введіть ім’я" autofocus required name="user[name]" {if isset($user.name)}value="{$user.name}"{/if}></td>
                    <td><input tabindex="2" type="text" placeholder="Введіть прізвище" required name="user[surname]" {if isset($user.surname)}value="{$user.surname}"{/if}></td>
                </tr>
                <tr>
                    <td><label for="">Номер телефону</label></td>
                    <td colspan="2"><input tabindex="3" type="text" placeholder="38( 063 ) 12 - 34 - 567" id="user_phone" required name="user[phone]" {if isset($user.phone)}value="{$user.phone}"{/if}></td>
                </tr>
                <tr>
                    <td><label for="">Електронна пошта*</label></td>
                    <td colspan="2"><input  tabindex="4" type="email" {if isset($user.email) && strpos($user.email,'one.click') == false}disabled{/if} required name="user[email]" {if isset($user.email)}value="{$user.email}"{/if}></td>
                </tr>
            </table>
            <table class="info">
                <tr>
                    <td colspan="2"><h3 class="head-red">Спосіб доставки та оплати:</h3></td>
                </tr>
                <tr id="deliveryRow">
                    <td><label for="">Спосіб доставки*</label></td>
                    <td>
                        <div class="select">
                            <select tabindex="5" name="data[delivery_id]" id="order_delivery_id">
                                {foreach $mod->delivery->get() as $item}
                                    <option value="{$item.id}">{$item.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label for="">Спосіб оплати*</label></td>
                    <td>
                        <div class="select">
                            <select name="data[payment_id]" id="order_payment_id"></select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label for="">Коментар до замовлення</label></td>
                    <td><textarea name="data[comment]" cols="30" rows="10"></textarea></td>
                </tr>
            </table>

            <div class="total-price-block">
                <div class="left">
                    <div class="row-price">
                        Разом до сплати: <span>{round($amount, 2)} грн</span>
                    </div>
                    <div class="row-bonus">
                        Ваш СМА бонус: <span>+{$bonus} грн</span>
                    </div>
                </div>
                <div class="right">
                    <button type="submit" class="btn md red">Оформити замовлення</button>
                </div>
            </div>
            <input type="hidden" name="token" value="{$token}">
        </form>
    {/if}
</div>