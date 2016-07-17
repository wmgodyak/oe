{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin main -->
    <main class="main">

        <!-- begin container -->
        <div class="container clearfix">
            {include file="modules/shop/nav.tpl"}
            {include file="modules/banners/home.tpl"}
        </div>
        <!-- end container -->

    </main>
    <!-- end main -->

    <!-- begin main-goods -->
    <div class="main-goods">

        <div class="container">

            {include file="modules/shop/widgets/actions.tpl"}
            {include file="modules/shop/widgets/new.tpl"}

        </div>

    </div>
    <!-- end main-goods -->

    {include file="modules/blog/latest.tpl"}

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}