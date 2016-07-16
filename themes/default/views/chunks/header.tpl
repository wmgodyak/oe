
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

                {include file="modules/languages/switcher.tpl"}

                <!-- begin wish-list -->
                <div class="wish-list">
                    <a class="wish-list__link" id="wishlistLink" href="12">Лист бажань</a>
                </div>
                <!-- end wish-list -->

                {$mod->users->nav()}

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
                <a href="#" class="logo__link">
                    <img src="{$theme_url}/assets/img/logo.png" alt="Світ Мобільних Аксесуарів" title="Світ Мобільних Аксесуарів" class="logo-icon">
                    <img src="{$theme_url}/assets/img/logo-text.png" alt="" class="logo-text">
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

                <!-- begin tel-search__top -->
                <div class="tel-search__top">
                    <ul class="tel__list">
                        <li class="tel__item tel__item--vodafone">
                            099 <a class="show-phone" href="#">{$t.common.phone_show}</a>
                            <span class="hidden">123 12 21</span>
                        </li>
                        <li class="tel__item tel__item--kyivstar">
                            097 <a class="show-phone" href="#">{$t.common.phone_show}</a>
                            <span class="hidden">123 12 21</span>
                        </li>
                        <li class="tel__item tel__item--lifecell">
                            063 <a class="show-phone" href="#">{$t.common.phone_show}</a>
                            <span class="hidden">123 12 21</span>
                        </li>
                        <li class="tel__item tel__item--order-call ">
                            <a href="javascript:;" id="callback">{$t.common.callback_link}</a>
                        </li>
                    </ul>
                </div>
                <!-- end tel-search__top -->

                {include file="modules/shop/search/form.tpl"}
            </div>
            <!-- end tel-search -->

            <!-- begin cart -->
            <div class="cart" id="blockCart"></div>
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