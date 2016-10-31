{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name default
 *}
{include file="chunks/head.tpl"}
{include file="chunks/header.tpl"}

<section class="page_heading">
    <div class="container">
        <div class="text-center">
            <h1>{$page.h1}</h1>
            {$page.intro}
        </div>
    </div>
</section>
<!--about-me-->
<section id="about_me" class="padding_none">
    <div class="container">
        <div class="padding_4x4_40 white_bg">
            {$page.content}
        </div>
        <div class="space-60"></div>
    </div>
</section>
{include file="chunks/footer.tpl"}
{include file="chunks/scripts.tpl"}

</body>
</html>