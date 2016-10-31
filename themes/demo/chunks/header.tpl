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
                {include file="modules/blog/search_form.tpl"}
            </div>
        </div>
    </div>
    <!--/.nav-collapse -->
</header>
<!--navigation end-->