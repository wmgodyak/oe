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
                    <a class="footer__link" href="1">
                        <img src="{$theme_url}/assets/img/footer-logo.png" alt="">
                    </a>
                </div>
                <div class="footer__c-description">{$t.theme.footer_text}</div>
                <div class="m_social">
                    <div class="social__heading">
                        {$t.theme.social_title}
                    </div>
                    <ul class="social__list">
                        <li class="social__item">
                            <a href="https://vk.com/cma.company" rel="nofollow" target="_blank" class="social__link social__link--vk"></a>
                        </li>
                        <li class="social__item">
                            <a href="https://www.facebook.com/people/%D0%A1%D0%B2%D1%96%D1%82-%D0%9C%D0%BE%D0%B1%D1%96%D0%BB%D1%8C%D0%BD%D0%B8%D1%85-%D0%90%D0%BA%D1%81%D0%B5%D1%81%D1%83%D0%B0%D1%80%D1%96%D0%B2/100011529574249" rel="nofollow" target="_blank" class="social__link social__link--fb"></a>
                        </li>
                        {* <li class="social__item">
                            <a href="#" class="social__link social__link--ok"></a>
                        </li> *}
                        <li class="social__item">
                            <a href="https://www.youtube.com/channel/UCFTB5AKaUZVDr-etBEic_Uw" target="_blank" rel="nofollow" class="social__link social__link--yt"></a>
                        </li>
                        <li class="social__item">
                            <a href="https://plus.google.com/+%D0%9A%D0%BE%D0%BC%D0%BF%D0%B0%D0%BD%D1%96%D1%8F%D0%A1%D0%9C%D0%90" rel="nofollow" target="_blank" class="social__link social__link--ig"></a>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- end footer__first -->

            <!-- begin footer__second -->
            <div class="footer__second">
                {include file="modules/nav/bottom.tpl"}
            </div>
            <!-- end footer__second -->

            <!-- begin footer__thirth -->
            <div class="footer__thirth">
                <div class="footer__heading">{$t.theme.footer_working_title}</div>
                <div class="footer__whours">{$t.theme.footer_working_hours}</div>
            </div>
            <!-- end footer__thirth -->

            <!-- begin footer__fourth -->
            <div class="footer__fourth">

                <div class="footer__heading">
                    {$t.theme.footer_contacts}
                </div>

                <div class="footer__contacts">

                    <span class="ks" href="#">
                        +38 (097) 59 88 666
                    </span>

                    <span class="vf" href="#">
                        +38 (099) 25 88 666
                    </span>

                    <span class="lc" href="#">
                        +38 (063) 59 88 666
                    </span>

                    <a class="gm" href="mailto:sma.lviv@gmail.com">
                        sma.lviv@gmail.com
                    </a>

                    <a class="sk" href="skype:sma_lviv?call">
                        sma_lviv
                    </a>

                </div>

            </div>
            <!-- end footer__fourth -->

            <!-- begin footer__fifth -->
            <div class="footer__fifth">
                {include file="modules/newsletter/form_footer.tpl"}
            </div>
            <!-- end footer__fifth -->
        </div>
    </div>
    <!-- end footer__main -->

    <!-- begin footer__bottom -->
    <div class="footer__bottom">
        <div class="container">
            <div class="copyright">
                © 2013-{date('Y')}, {$t.theme.copyright}
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
<script src='{$theme_url}/assets/js/vendor/notify.js'></script>
<script src='{$theme_url}/assets/js/vendor/slick.min.js'></script>
<script src='{$theme_url}/assets/js/vendor/jquery.fancybox.pack.js'></script>
<script>
    var translations = {json_encode($t)};
</script>
<script src="{$theme_url}/assets/js/main.js"></script>
<!-- end scripts -->
{if isset($modules_scripts)}
    {foreach $modules_scripts as $k=>$script}
        <script src="{$script}"></script>
    {/foreach}
{/if}
{include file="chunks/lodash_templates.tpl"}
</body>
</html>