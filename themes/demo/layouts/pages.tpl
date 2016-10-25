{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name default
 *}
{include file="chunks/head.tpl"}

<!--navigation-->
<header class="navbar navbar-inverse">
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <div class="logo">
                    <a href="1" title="{$app->page->title(1)}"><img src="{$theme_url}assets/images/logo.png" alt="logo-image"></a>
                </div>
            </div>

            <div class="col-md-7">
                {include file="chunks/nav.tpl"}
            </div>

            <div class="col-md-3">
                <div class="search">
                    <div class="search_button"><i class="fa fa-search"></i> <i class="fa fa-close"></i></div>
                    <form role="form" id="search_form">
                        <div class="form-group has-feedback">
                            <input type="text" placeholder="Search.." class="form-control input-sm">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--/.nav-collapse -->
</header>
<!--navigation end-->

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