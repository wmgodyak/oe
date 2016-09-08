<form action="9" id="cartItems"></form>
<script>
    window.cItems = {json_encode($mod->order->cart->products(), true)};
    window.cKits = {json_encode($mod->order->cart->kits())};
    window.bonus_rate = {$settings.modules.Shop.config.bonus_rate};
</script>
{literal}
    <script type="text/template" id="cartTemplate">

        <% amount = 0 %>
        <% bonus  = 0 %>

        <% if(items != null && items.length ) { %>
        <div class="goods-list">
            <div class="goods-list__top-row">
                <div class="item item1">
                    Товар
                </div>
                <div class="item item2">
                    Кількість
                </div>
                <div class="item item3">
                    Сума
                </div>
            </div>
            <div class="goods-list__main">
                <% items.forEach(function(item) { %>
                <div class="goods-list__row">
                    <div class="item item1">
                        <% if ( item.img ) { %>
                        <img src="<%- item.img%>">
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
                            Артикул товару: <%- item.sku%>
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
                <% bonus  += item.bonus %>
                <% }); %>
            </div>
        </div>

        <% } %>
        <% if(kits != null && kits.length) { %>
        <% console.log(kits); %>
        <div class="promotion-banner">
            <div class="heading">
                Комплект
            </div>
            <% kits.forEach(function(item){  %>

            <div class="promotion-banner-wrap">
                <div class="content">
                    <div class="item item1">
                        <div class="img-block">
                            <div class="img" style="background-image: url('<%- item.product.img %>');"></div>
                        </div>
                        <div class="name"><%- item.product.name %></div>
                        <div class="price-row">
                            <div class="price"><%- item.product.price %> грн.</div>
                        </div>
                    </div>
                    <% item.products.forEach(function(product){ %>
                    <div class="item item2">
                        <div class="img-block">
                            <div class="img" style="background-image: url('<%- product.img %>');"></div>
                        </div>
                        <div class="name"><%- product.name %></div>
                        <div class="price-row">
                            <div class="old-price"><%- product.original_price %> грн</div>
                            <div class="price"><%- product.price %> грн</div>
                        </div>
                    </div>
                    <% }); %>
                    <div class="equals">
                        <div class="row">
                            <div class="new-price">
                                <%- item.amount %> грн
                            </div>
                        </div>
                        <div class="row">
                            <div class="old-price">
                                <%- item.original_amount %> грн
                            </div>
                        </div>
                    </div>
                </div>
                <div class="result-block">
                    <div class="wrap">
                        <span>Ви економите <%- item.save_amount %> грн.</span>
                        <div class="text">
                            Замовляйте комплекти
                            та платіть дешевше
                        </div>
                        <div class="btn-row">
                            <button class="btn red b-cart-kits-delete" type="button" data-id="<%- item.id %>">Видалити</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class=""><br></div>
            <% amount += item.amount %>
            <% bonus  += (item.amount * bonus_rate) %>
            <% }); %>
        </div>
        <% } %>

        <% if (amount > 0) { %>

        <div class="total-price-block">
            <div class="left">
                <div class="row-price">
                    Разом до сплати: <span><%-amount%> грн</span>
                </div>
                <div class="row-bonus">
                    Ваш СМА бонус: <span>+<%- bonus.toFixed(2) %> грн</span>
                </div>
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