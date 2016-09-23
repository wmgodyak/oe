
<!-- begin l_header -->
<header class="l_header">

    <!-- begin header__top -->
    <div class="header__top">

        <!-- begin container -->
        <div class="container">

            {include file="modules/nav/top.tpl"}

            <div class="xs-phone">
                {$t.common.phone}
            </div>

            <!-- begin header__activities -->
            <div class="header__activities">

                {$mod->users->nav()}

                <!-- begin wish-list -->
                <div class="comparison-list">
                    <a class="comparison-list__link" title="Переглянути список вибраних товарів для порівняння" id="comparison_link" href="15">Порівняння</a>
                </div>
                <div class="wish-list">
                    <a class="wish-list__link" title="Переглянути список вибраних товарів" id="wishlistLink" href="27">Лист бажань</a>
                </div>
                <!-- end wish-list -->

                {include file="modules/languages/switcher.tpl"}



            </div>
            <!-- end header__activities -->

        </div>
        <!-- end container -->

    </div>
    <!-- end header__top -->

    <!-- begin header__main -->
    <div class="header__main">

        <!-- begin container -->
        <div class="container">

            <!-- begin logo -->
            <div class="logo">
                <a  {if $page.id != 1 } href="1"{/if} class="logo__link">
                    <img src="{$theme_url}/assets/img/logo.png" alt="Світ Мобільних Аксесуарів" title="Світ Мобільних Аксесуарів" class="logo-icon">
                    {*<img src="{$theme_url}/assets/img/logo-text.png" alt="" class="logo-text">*}
                    <img src="{$theme_url}/assets/img/main-logo.png" alt="Світ Мобільних Аксесуарів" class="logo-text">
                </a>
                <div class="side-menu-switcher">
                    <a href="#">
                        <span></span>
                    </a>
                </div>
            </div>
            <!-- end logo -->

            <!-- begin tel-search -->
            <div class="tel-search">
                {include file="chunks/header_phones.tpl"}
                {include file="modules/shop/search/form.tpl"}
            </div>
            <!-- end tel-search -->

            <!-- begin cart -->
            <a href="cart" class="cart" id="blockCart" title="Переглянути кошик"></a>
            <!-- end cart -->

        </div>
        <!-- end container -->

    </div>
    <!-- end header__main -->

    <!-- begin header__xs -->
    <div class="header__xs">
        <div class="container">
            <form class="search-form" action="9">
                <input type="text" required name="q" placeholder="Пошук по магазину">
                <button class="search-btn" type="submit"></button>
            </form>
        </div>
    </div>
    <!-- end header__xs -->

</header>
<!-- end l_header -->