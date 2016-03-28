{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-17T17:48:29+02:00
 * @name Сторінки
 *}
{include file="chunks/head.tpl"}

<body id="about-us">
{include file="modules/nav/top.tpl"}

<script src="{$theme_url}assets/js/vendor/jquery.flexslider.min.js"></script>
<link rel="stylesheet" type="text/css" href="{$theme_url}assets/css/vendor/flexslider.css">
<div id="slider">
    <div class="container">
        <div class="row header">
            <div class="col-md-12">
                <h3>{$page.name}</h3>
                <p>
                    {$page.description}
                </p>
            </div>
        </div>
        {include file="modules/slider.tpl"}
    </div>
</div>

<div id="info">
    <div class="container">
        {$page.content}
    </div>
</div>

<div id="cta">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="wrapper clearfix">
                    <h4>Try engine now and take your own project to a whole new level.</h4>
                    <a href="30" class="button button-small">Sign up free</a>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="chunks/footer.tpl"}

<script type="text/javascript">
    $(function() {
        $('.flexslider').flexslider({
            directionNav: false,
            slideshowSpeed: 4000
        });
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
</body>