<script type="text/template" id="tplCart">
    {literal}
        <div class="cart__main">
            <div class="cart__img">
                <div class="inner">
                    <div class="cart_amount"><%- total %></div>
                </div>
            </div>
            <div class="cart__text">
                <div class="cart__header">
                    <%- translations.order.cart.block_title %>
                </div>
                <% if(total) { %>
                <div class="cart__price">
                    <%- translations.order.cart.block_text %>
                    <span><%- amount %><%- translations.shop.currency.uah %></span>
                </div>
                <% } else { %>
                <div class="cart__price">
                    <%- translations.order.cart.block_empty %>
                </div>
                <% } %>
            </div>
        </div>
    {/literal}
    {literal}<% if(total) { %>{/literal}
    <div class="cart__bottom">
        <a class="cart__link" href="10">{$t.order.cart.block_link}</a>
    </div>
    {literal}<% } %>{/literal}
</script>

<script id="oneClickTpl" type="text/template">
    {literal}
    <form id="oneClick<%-formID%>" action="route/order/oneClick" method="post">
        <div class="form-group">
            <label for="oc_user_name_<%-formID%>"><%- translations.order.one_click.uname %></label>
            <input id="oc_user_name_<%-formID%>" name="user[name]" {/literal}{if $user.name}value="{$user.name}"{/if}{literal} required type="text">
        </div>
        <div class="form-group">
            <label for="oc_user_phone_<%-formID%>"><%- translations.order.one_click.uphone %></label>
            <input id="oc_user_phone_<%-formID%>" class="phone-mask" {/literal}{if $user.phone}value="{$user.phone}"{/if}{literal} required name="user[phone]" type="tel">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        <input type="hidden" name="products_id" value="<%-products_id%>">
        <input type="hidden" name="variants_id" value="<%-variants_id%>">
    </form>
    {/literal}
</script>

<script id="wishlistCreateTpl" type="text/template">
    {literal}
    <form id="wishlist<%-formID%>" action="route/wishlist/create" method="post">
        <div class="form-group">
            <label for="name_<%-formID%>"><%- translations.wishlist.form_list_name %></label>
            <input id="name_<%-formID%>" name="data[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="phone_<%-formID%>"><%- translations.wishlist.form_list_email %></label>
            <input id="phone_<%-formID%>" required name="data[email]" type="email">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        <input type="hidden" name="products_id" value="<%-products_id%>">
        <input type="hidden" name="variants_id" value="<%-variants_id%>">
        {/literal}
    </form>
</script>

<script id="waitListTpl" type="text/template">
    {literal}
    <form id="waitList<%-formID%>" action="route/waitlist/create" method="post">
        <p><%- translations.waitlist.title %></p>
        <p>&nbsp;</p>
        <div class="form-group">
            <label for="name_<%-formID%>"><%- translations.waitlist.uname %></label>
            <input id="name_<%-formID%>" name="data[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="phone_<%-formID%>"><%- translations.waitlist.uemail %></label>
            <input id="phone_<%-formID%>" required name="data[email]" type="email">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        <input type="hidden" name="data[products_id]" value="<%-products_id%>">
        <input type="hidden" name="data[variants_id]" value="<%-variants_id%>">
        {/literal}
    </form>
</script>
<script type="text/template" id="callbackTpl">
    {literal}
    <form id="callbackForm" action="route/callbacks/process" method="post">
        <div class="form-group">
            <label for="cb_name"><%- translations.callbacks.uname %></label><br>
            <input id="cb_name" name="data[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="cb_phone"><%- translations.callbacks.uphone %></label><br>
            <input id="cb_phone" name="data[phone]" class="phone-mask" required type="tel">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        {/literal}
    </form>
</script>