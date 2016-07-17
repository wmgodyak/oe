{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:55+02:00
 * @name footer
 *}

<!-- become l_footer -->
<footer class="l_footer">

    <!-- begin footer__main -->
    <div class="footer__main">
        <div class="container">

            <!-- begin footer__first -->
            <div class="footer__first">
                <div class="footer__logo">
                    <a class="footer__link" href="#">
                        <img src="{$theme_url}/assets/img/footer-logo.png" alt="">
                    </a>
                </div>
                <div class="footer__c-description">
                    <span>Світ Мобільних Аксесуарів</span> - це
                    магазин, що пропонує якісний ремонт
                    та різні аксесуари для ваших телефонів
                    чи планшетів. Завжди якісно!
                </div>
                <div class="m_social">
                    <div class="social__heading">
                        Приєднуйтесь до нас у соцмережах:
                    </div>
                    <ul class="social__list">
                        <li class="social__item">
                            <a href="#" class="social__link social__link--vk"></a>
                        </li>
                        <li class="social__item">
                            <a href="#" class="social__link social__link--fb"></a>
                        </li>
                        <li class="social__item">
                            <a href="#" class="social__link social__link--ok"></a>
                        </li>
                        <li class="social__item">
                            <a href="#" class="social__link social__link--yt"></a>
                        </li>
                        <li class="social__item">
                            <a href="#" class="social__link social__link--ig"></a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- end footer__first -->

            <!-- begin footer__second -->
            <div class="footer__second">
                <div class="footer__heading">
                    Інформація
                </div>
                {include file="modules/nav/bottom.tpl"}
            </div>
            <!-- end footer__second -->

            <!-- begin footer__thirth -->
            <div class="footer__thirth">

                <div class="footer__heading">
                    Працюємо
                </div>

                <div class="footer__whours">
                    <span>З понеділка по п’ятницю:</span>

                    <span>09:00 - 19:00</span>

                    <span>Субота: 09:00 до 15:00</span>

                    <span>Неділя - вихідний</span>
                </div>
            </div>
            <!-- end footer__thirth -->

            <!-- begin footer__fourth -->
            <div class="footer__fourth">

                <div class="footer__heading">
                    Наші контакти
                </div>

                <div class="footer__contacts">

                    <a class="ks" href="#">
                        +38 (097) 59 88 666
                    </a>

                    <a class="vf" href="#">
                        +38 (099) 25 88 666
                    </a>

                    <a class="lc" href="#">
                        +38 (063) 59 88 666
                    </a>

                    <a class="gm" href="#">
                        sma.lviv@gmail.com
                    </a>

                    <a class="sk" href="#">
                        sma_lviv
                    </a>

                </div>

            </div>
            <!-- end footer__fourth -->

            <!-- begin footer__fifth -->
            <div class="footer__fifth">

                <div class="footer__heading">
                    Підписка
                </div>

                <div class="footer__subscription">
                    <div class="text">
                        Підпишіться на розсилку від СМА та
                        отримуйте завжди свіжі новини, акції
                        та пропозиції на свою електронну
                        скриньку.
                    </div>
                    <form action="#">
                        <div class="input-row">
                            <input type="email" placeholder="введіть ваш  e-mail">
                        </div>
                        <div class="btn-row">
                            <button>Підписатись</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- end footer__fifth -->
        </div>
    </div>
    <!-- end footer__main -->

    <!-- begin footer__bottom -->
    <div class="footer__bottom">
        <div class="container">
            <div class="copyright">
                © 2013-{date('Y')}, Інтернет-магазин СМА
            </div>
        </div>
    </div>
    <!-- end footer__bottom -->

</footer>
<!-- end l_footer -->


<!-- become scripts -->
<script src='{$theme_url}assets/js/vendor/jquery-1.11.3.min.js'></script>
<script src="{$theme_url}/assets/js/plugins.js"></script>
<script src='{$theme_url}/assets/js/vendor/jquery-ui.min.js'></script>
<script src='{$theme_url}/assets/js/vendor/jquery.formstyler.js'></script>
<script src='{$theme_url}/assets/js/vendor/owl.carousel.min.js'></script>
<script src='{$theme_url}/assets/js/vendor/jquery.barrating.min.js'></script>
<script src='{$theme_url}/assets/js/vendor/waterfall.min.js'></script>
<script src="{$theme_url}/assets/js/main.js"></script>
<!-- end scripts -->
{if isset($modules_scripts)}
    {foreach $modules_scripts as $k=>$script}
        <script src="{$script}"></script>
    {/foreach}
{/if}

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
                МІЙ КОШИК
            </div>
            <% if(total) { %>
            <div class="cart__price">
                товарів на суму
                <span><%- amount %></span>
            </div>
            <% } else { %>
                <div class="cart__price">
                    кошик порожній
                </div>
            <% } %>
        </div>
    </div>
{/literal}
{literal}<% if(total) { %>{/literal}
    <div class="cart__bottom">
        <a class="cart__link" href="10">Переглянути кошик</a>
    </div>
{literal}<% } %>{/literal}
</script>

<div id="oneClickTpl" style="display: none;">
    {literal}
    <form id="oneClick<%-formID%>" action="route/order/oneClick" method="post">
        <div class="form-group">
            <label for="oc_user_name_<%-formID%>">Ваше ім’я:</label>
            <input id="oc_user_name_<%-formID%>" name="user[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="oc_user_phone_<%-formID%>">Телефон</label><br>
            <input id="oc_user_phone_<%-formID%>" class="phone-mask" required name="user[phone]" type="tel">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        <input type="hidden" name="products_id" value="<%-products_id%>">
        <input type="hidden" name="variants_id" value="<%-variants_id%>">
    {/literal}
    </form>
</div>

<div id="wishlistCreateTpl" style="display: none;">
    {literal}
    <form id="wishlist<%-formID%>" action="route/wishlist/create" method="post">
        <div class="form-group">
            <label for="name_<%-formID%>">Введіть назву списку</label>
            <input id="name_<%-formID%>" name="data[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="phone_<%-formID%>">E-mail</label><br>
            <input id="phone_<%-formID%>" required name="data[email]" type="email">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
        <input type="hidden" name="products_id" value="<%-products_id%>">
        <input type="hidden" name="variants_id" value="<%-variants_id%>">
    {/literal}
    </form>
</div>
<script type="text/template" id="callbackTpl">
    {literal}
    <form id="callbackForm" action="route/callbacks/process" method="post">
        <div class="form-group">
            <label for="cb_name">Ваше ім'я</label><br>
            <input id="cb_name" name="data[name]" required type="text">
        </div>
        <div class="form-group">
            <label for="cb_phone">Телефон</label><br>
            <input id="cb_phone" name="data[phone]" class="phone-mask" required type="tel">
        </div>
        <input type="hidden" name="token" value="<%-token%>">
    {/literal}
    </form>
</script>
</body>
</html>