{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-14T09:33:08+03:00
 * @name Кошик
 *}

{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin cart-page -->
    <div class="cart-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container clearfix">
            <div class="cart-page__content">

                <div class="heading">{$page.name}</div>
                <form action="9" id="cartItems"></form>
                {*<pre>{print_r($mod->order->cart->items())}</pre>*}
                <script>var cItems = {json_encode($mod->order->cart->items(), true)}</script>
                {include file="modules/shop/widgets/new.tpl"}
            </div>

            <aside class="aside">{include file="chunks/sidebar.tpl"}</aside>
        </div>

    </div>
    <!-- end cart-page -->
</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}
{literal}
    <script type="text/template" id="cartTemplate">
        <% if( items.length ) { %>
        <div class="goods-list">
            <div class="goods-list__top-row">
                <div class="item item1">
                    Товар
                </div>
                <div class="item item2">
                    Кількість:
                </div>
                <div class="item item3">
                    Загальна сума:
                </div>
            </div>
            <div class="goods-list__main">
                <% amount = 0 %>
                <% items.forEach(function(item) { %>
                <div class="goods-list__row">
                    <div class="item item1">
                        <% if ( item.img.image ) { %>
                            <img src="<%- item.img.path%>thumbs/<%- item.img.image%>">
                        <% } else { %>
                            <img src="/uploads/noimage.jpg">
                        <% } %>
                    </div>
                    <div class="item item2">
                        <div class="name"><%- item.name%></div>
                        <div class="songle-price">
                            <%- item.price%> грн.
                        </div>
                        <div class="code">
                            код товару: <%- item.sku%>
                        </div>
                    </div>
                    <div class="item item3">
                        <div class="item-counter">
                            <div class="column fl">
                                <input style="width: 50px;" onchange="this.value = parseInt(this.value); if(typeof  this.value == 'undefined') this.value=1;" class="counter-mask cart-item-quantity" type="number" value="<%- item.quantity%>" data-id="<%=item.products_id%>">
                            </div>
                        </div>
                    </div>
                    <div class="item item4">
                        <div class="total-price">
                            <%- item.quantity * item.price%> грн.
                        </div>
                    </div>
                    <div class="item item5">
                        <a class="delate-item cart-delete-item" data-id="<%=item.products_id%>" href="javascript:;">
                            <span>Видалити з кошика</span>
                        </a>
                    </div>
                </div>
                <% amount += item.quantity * item.price %>
                <% }); %>
            </div>
        </div>

        <div class="total-price-block">
            <div class="left">
                <div class="row-price">
                    Разом до сплати: <span><%-amount%> грн</span>
                </div>
                <!-- div class="row-bonus">
                    Ваш СМА бонус: <span>+28,38 грн</span>
                </div -->
            </div>
            <div class="right">
                <button type="submit" class="btn md red">Оформити замовлення</button>
            </div>
        </div>
        <% } else { %>
            <p>Ваш кошик порожній</p>
        <% } %>
    </script>
{/literal}