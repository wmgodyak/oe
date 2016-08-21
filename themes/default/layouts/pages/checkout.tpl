{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-13T18:16:48+03:00
 * @name Checkout
 *}

{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin cart-page -->
    <div class="order-page">

        {include file="modules/breadcrumbs.tpl"}

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

                        {foreach $mod->order->cart->items() as $item}
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
                        <td><input type="text" placeholder="Введіть ім’я" required name="user[name]" {if isset($user.name)}value="{$user.name}"{/if}></td>
                        <td><input type="text" placeholder="Введіть прізвище" required name="user[surname]" {if isset($user.surname)}value="{$user.surname}"{/if}></td>
                    </tr>
                    <tr>
                        <td><label for="">Номер телефону</label></td>
                        <td colspan="2"><input type="text" placeholder="38( 063 ) 12 - 34 - 567" id="user_phone" required name="user[phone]" {if isset($user.phone)}value="{$user.phone}"{/if}></td>
                    </tr>
                    <tr>
                        <td><label for="">Електронна пошта*</label></td>
                        <td colspan="2"><input type="email" {if isset($user)}disabled{/if} required name="user[email]" {if isset($user.email)}value="{$user.email}"{/if}></td>
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
                                <select name="data[delivery_id]" id="order_delivery_id">
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
                            Разом до сплати: <span>{$amount} грн</span>
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

            {$mod->order->kits()}

            {/if}
        </div>

    </div>
    <!-- end cart-page -->
</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}