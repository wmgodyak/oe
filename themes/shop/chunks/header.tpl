{block name="header"}
<header class="{block name="header.class"}site-header header-opt-8{/block}">
        <div class="header-top">
            <div class="container">

                <ul class="hotline nav-left">
                    <li><span class="wellcome">Wellcome to BigShop <a href="">Register</a> <span>or</span> <a href="">Login</a></span></li>
                </ul>

                <ul class="links nav-right">
                    <li class="link-account"><a href=""><img alt="img" src="{$theme_url}assets/images/icon/index9/user.png">My Account </a></li>
                    <li class="link-wishlist"><a href="" ><img alt="img" src="{$theme_url}assets/images/icon/index9/wishlist.png">My Wishlist</a></li>
                    <li class="link-checkout"><a href=""><img alt="img" src="{$theme_url}assets/images/icon/index9/checkout.png">Check Out </a></li>
                    <li class="dropdown switcher  switcher-language">
                        <a data-toggle="dropdown" role="button" href="#" class="dropdown-toggle switcher-trigger" aria-expanded="false">
                            <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_english.png">
                            <span>English </span>
                            <i aria-hidden="true" class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu switcher-options ">
                            <li class="switcher-option">
                                <a href="#">
                                    <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_english.png">English
                                </a>
                            </li>
                            <li class="switcher-option">
                                <a href="#">
                                    <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_french.png">French
                                </a>
                            </li>
                            <li class="switcher-option">
                                <a href="#">
                                    <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_germany.png">Germany
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown switcher  switcher-currency">
                        <a data-toggle="dropdown" role="button" href="#" class="dropdown-toggle switcher-trigger"><span>USD</span> <i aria-hidden="true" class="fa fa-angle-down"></i></a>
                        <ul class="dropdown-menu switcher-options ">
                            <li class="switcher-option">
                                <a href="#">
                                    <i class="fa fa-usd" aria-hidden="true"></i> USD
                                </a>
                            </li>
                            <li class="switcher-option">
                                <a href="#">
                                    <i class="fa fa-eur" aria-hidden="true"></i> eur
                                </a>
                            </li>
                            <li class="switcher-option">
                                <a href="#">
                                    <i class="fa fa-gbp" aria-hidden="true"></i> gbp
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>

            </div>
        </div>

        <!-- header-content -->
        <div class="header-content">
            <div class="container">

                <div class="row">

                    <div class="col-md-3 nav-left">
                        <!-- logo -->
                        <strong class="logo">
                            <a href=""><img src="{$theme_url}assets/images/media/index8/logo.png" alt="logo"></a>
                        </strong><!-- logo -->
                    </div>

                    <div class="col-md-5 col-lg-6  nav-mind">

                        <!-- block search -->
                        <div class="block-search">
                            <div class="block-title">
                                <span>Search</span>
                            </div>
                            <div class="block-content">
                                <div class="categori-search  ">
                                    <select data-placeholder="All Categories" class="categori-search-option">
                                        <option>All Categories</option>
                                        <option>Fashion</option>
                                        <option>Tops Blouses</option>
                                        <option>Clothing</option>
                                        <option>Furniture</option>
                                        <option>Bathtime Goods</option>
                                        <option>Shower Curtains</option>
                                    </select>
                                </div>
                                <div class="form-search">
                                    <form>
                                        <div class="box-group">
                                            <input type="text" class="form-control" placeholder="Search here...">
                                            <button class="btn btn-search" type="button"><span>search</span></button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div><!-- block search -->

                    </div>

                    <div class="col-md-4 col-lg-3  nav-right">

                        <!-- block mini cart -->
                        <div class="block-minicart dropdown">
                            <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                <span class="cart-icon"></span>
                                <span class="counter qty">
                                        <span class="cart-text">cart</span>
                                        <span class="counter-number">6</span>
                                        <span class="counter-label">6 <span>Item(s)</span></span>
                                        <span class="counter-price">$75.00</span>
                                    </span>
                            </a>
                            <div class="dropdown-menu">
                                <form>
                                    <div  class="minicart-content-wrapper" >
                                        <div class="subtitle">
                                            You have 6 item(s) in your cart
                                        </div>
                                        <div class="minicart-items-wrapper">
                                            <ol class="minicart-items">
                                                <li class="product-item">
                                                    <a class="product-item-photo" href="#" title="The Name Product">
                                                        <img class="product-image-photo" src="{$theme_url}assets/images/media/index1/minicart.jpg" alt="The Name Product">
                                                    </a>
                                                    <div class="product-item-details">
                                                        <strong class="product-item-name">
                                                            <a href="#">Burberry Pink &amp; black</a>
                                                        </strong>
                                                        <div class="product-item-qty">
                                                            <span class="label">Quantity:</span ><span class="number">6</span>
                                                        </div>
                                                        <div class="product-item-price">
                                                            <span class="price"> $17.96</span>
                                                        </div>
                                                        <div class="product-item-actions">
                                                            <a class="action delete" href="#" title="Remove item">
                                                                <span>Remove</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="product-item">
                                                    <a class="product-item-photo" href="#" title="The Name Product">
                                                        <img class="product-image-photo" src="{$theme_url}assets/images/media/index1/minicart.jpg" alt="The Name Product">
                                                    </a>
                                                    <div class="product-item-details">
                                                        <strong class="product-item-name">
                                                            <a href="#">Burberry Pink &amp; black</a>
                                                        </strong>
                                                        <div class="product-item-qty">
                                                            <span class="label">Quantity:</span ><span class="number">6</span>
                                                        </div>
                                                        <div class="product-item-price">
                                                            <span class="price"> $17.96</span>
                                                        </div>
                                                        <div class="product-item-actions">
                                                            <a class="action delete" href="#" title="Remove item">
                                                                <span>Remove</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ol>
                                        </div>
                                        <div class="subtotal">
                                            <span class="label">Total</span>
                                            <span class="price">$630</span>
                                        </div>
                                        <div class="actions">
                                            <a class="btn btn-viewcart" href="">
                                                <span>Shopping bag</span>
                                            </a>
                                            <button class="btn btn-checkout" type="button" title="Check Out">
                                                <span>Check out</span>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!-- block mini cart -->


                        <!-- link  wishlish-->
                        <a href="" class="link-favorites"><span>Favorites</span></a>

                    </div>

                </div>

            </div>
        </div><!-- header-content -->

        <div class="header-nav mid-header">
            <div class=" container">
                <div class="box-header-nav">
                    <span data-action="toggle-nav-cat" class="nav-toggle-menu nav-toggle-cat"><span>Categories</span><i aria-hidden="true" class="fa fa-bars"></i></span>
                    <div class="block-nav-categori">
                        <div class="block-title">
                            <span>Categories</span>
                        </div>
                        <div class="block-content">
                            <ul class="ui-categori">
                                <li class="parent">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat1.png" alt="nav-cat"></span>
                                        Electronics
                                    </a>
                                    <span class="toggle-submenu"></span>
                                    <div class="submenu" style="background-image: url({$theme_url}assets/images/media/index1/bgmenu.jpg);">
                                        <ul class="categori-list clearfix">
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Smartphone</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">TElevision</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Camera</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                        <ul class="categori-list clearfix">
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Smartphone</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">TElevision</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Camera</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="parent">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat2.png" alt="nav-cat"></span>
                                        Smartphone & Table
                                    </a>
                                    <span class="toggle-submenu"></span>
                                    <div class="submenu">
                                        <div class="categori-img">
                                            <a href=""><img src="{$theme_url}assets/images/media/index1/categori-img1.jpg" alt="categori-img"></a>
                                        </div>
                                        <ul class="categori-list">
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Smartphone</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">TElevision</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">Camera</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                            <li class="col-sm-3">
                                                <strong class="title"><a href="">washing machine</a></strong>
                                                <ul>
                                                    <li><a href="">Skirts    </a></li>
                                                    <li><a href="">Jackets</a></li>
                                                    <li><a href="">Jumpusuits</a></li>
                                                    <li><a href="">Scarvest</a></li>
                                                    <li><a href="">T-Shirts</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li class="parent">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat3.png" alt="nav-cat"></span>
                                        Television
                                    </a>
                                    <span class="toggle-submenu"></span>
                                    <div class="submenu">
                                        <strong class="subtitle"><span>special products</span></strong>
                                        <div class="owl-carousel"
                                             data-nav="true"
                                             data-dots="false"
                                             data-margin="30"
                                             data-autoplayTimeout="300"
                                             data-autoplay="true"
                                             data-loop="true"
                                             {literal}data-responsive='{
                                                "0":{"items":1},
                                                "380":{"items":1},
                                                "480":{"items":1},
                                                "600":{"items":1},
                                                "992":{"items":4}
                                                }'{/literal}>

                                            <div class="product-item product-item-opt-1">
                                                <div class="product-item-info">
                                                    <div class="product-item-photo">
                                                        <a class="product-item-img" href=""><img alt="product name" src="{$theme_url}assets/images/media/index1/product-menu1.jpg"></a>
                                                    </div>
                                                    <div class="product-item-detail">
                                                        <strong class="product-item-name"><a href="">Asus Ispiron 20</a></strong>
                                                        <div class="product-item-price">
                                                            <span class="price">$45.00</span>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-item product-item-opt-1">
                                                <div class="product-item-info">
                                                    <div class="product-item-photo">
                                                        <a class="product-item-img" href=""><img alt="product name" src="{$theme_url}assets/images/media/index1/product-menu2.jpg"></a>
                                                    </div>
                                                    <div class="product-item-detail">
                                                        <strong class="product-item-name"><a href="">Electronics Ispiron 20 </a></strong>
                                                        <div class="product-item-price">
                                                            <span class="price">$45.00</span>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-item product-item-opt-1">
                                                <div class="product-item-info">
                                                    <div class="product-item-photo">
                                                        <a class="product-item-img" href=""><img alt="product name" src="{$theme_url}assets/images/media/index1/product-menu3.jpg"></a>
                                                    </div>
                                                    <div class="product-item-detail">
                                                        <strong class="product-item-name"><a href="">Samsung Ispiron 20 </a></strong>
                                                        <div class="product-item-price">
                                                            <span class="price">$45.00</span>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-item product-item-opt-1">
                                                <div class="product-item-info">
                                                    <div class="product-item-photo">
                                                        <a class="product-item-img" href=""><img alt="product name" src="{$theme_url}assets/images/media/index1/product-menu4.jpg"></a>
                                                    </div>
                                                    <div class="product-item-detail">
                                                        <strong class="product-item-name"><a href="">Electronics Ispiron 20 </a></strong>
                                                        <div class="product-item-price">
                                                            <span class="price">$45.00</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="product-item product-item-opt-1">
                                                <div class="product-item-info">
                                                    <div class="product-item-photo">
                                                        <a class="product-item-img" href=""><img alt="product name" src="{$theme_url}assets/images/media/index1/product-menu4.jpg"></a>
                                                    </div>
                                                    <div class="product-item-detail">
                                                        <strong class="product-item-name"><a href="">Samsung Ispiron 20 </a></strong>
                                                        <div class="product-item-price">
                                                            <span class="price">$45.00</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat4.png" alt="nav-cat"></span>
                                        Shoes & Accessories
                                    </a>
                                </li>

                                <li>
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat8.png" alt="nav-cat"></span>
                                        Sport & Outdoors
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat9.png" alt="nav-cat"></span>
                                        Computer & Networking
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat10.png" alt="nav-cat"></span>
                                        Flashlights & Lamps
                                    </a>
                                </li>
                                <li class="cat-link-orther">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat10.png" alt="nav-cat"></span>
                                        Sport & Outdoors
                                    </a>
                                </li>
                                <li class="cat-link-orther">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat9.png" alt="nav-cat"></span>
                                        Watch & Jewellry
                                    </a>
                                </li>
                                <li class="cat-link-orther">
                                    <a href="">
                                        <span class="icon"><img src="{$theme_url}assets/images/icon/index1/nav-cat8.png" alt="nav-cat"></span>
                                        Flashlights & Lamps
                                    </a>
                                </li>

                            </ul>

                            <div class="view-all-categori">
                                <a  class="open-cate btn-view-all">All Categories</a>
                            </div>
                        </div>

                    </div>

                    {include file="chunks/menu.tpl"}

                    <span data-action="toggle-nav" class="nav-toggle-menu"><span>Menu</span><i aria-hidden="true" class="fa fa-bars"></i></span>

                    <div class="block-minicart dropdown ">
                        <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                            <span class="cart-icon"></span>
                        </a>
                        <div class="dropdown-menu">
                            <form>
                                <div  class="minicart-content-wrapper" >
                                    <div class="subtitle">
                                        You have 6 item(s) in your cart
                                    </div>
                                    <div class="minicart-items-wrapper">
                                        <ol class="minicart-items">
                                            <li class="product-item">
                                                <a class="product-item-photo" href="#" title="The Name Product">
                                                    <img class="product-image-photo" src="{$theme_url}assets/images/media/index1/minicart.jpg" alt="The Name Product">
                                                </a>
                                                <div class="product-item-details">
                                                    <strong class="product-item-name">
                                                        <a href="#">Burberry Pink &amp; black</a>
                                                    </strong>
                                                    <div class="product-item-qty">
                                                        <span class="label">Quantity:</span ><span class="number">6</span>
                                                    </div>
                                                    <div class="product-item-price">
                                                        <span class="price"> $17.96</span>
                                                    </div>
                                                    <div class="product-item-actions">
                                                        <a class="action delete" href="#" title="Remove item">
                                                            <span>Remove</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </li>
                                            <li class="product-item">
                                                <a class="product-item-photo" href="#" title="The Name Product">
                                                    <img class="product-image-photo" src="{$theme_url}assets/images/media/index1/minicart.jpg" alt="The Name Product">
                                                </a>
                                                <div class="product-item-details">
                                                    <strong class="product-item-name">
                                                        <a href="#">Burberry Pink &amp; black</a>
                                                    </strong>
                                                    <div class="product-item-qty">
                                                        <span class="label">Quantity:</span ><span class="number">6</span>
                                                    </div>
                                                    <div class="product-item-price">
                                                        <span class="price"> $17.96</span>
                                                    </div>
                                                    <div class="product-item-actions">
                                                        <a class="action delete" href="#" title="Remove item">
                                                            <span>Remove</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </li>
                                        </ol>
                                    </div>
                                    <div class="subtotal">
                                        <span class="label">Total</span>
                                        <span class="price">$630</span>
                                    </div>
                                    <div class="actions">
                                        <a class="btn btn-viewcart" href="">
                                            <span>Shopping bag</span>
                                        </a>
                                        <button class="btn btn-checkout" type="button" title="Check Out">
                                            <span>Check out</span>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="block-search">
                        <div class="block-title">
                            <span>Search</span>
                        </div>
                        <div class="block-content">
                            <div class="form-search">
                                <form>
                                    <div class="box-group">
                                        <input type="text" class="form-control" placeholder="Search here...">
                                        <button class="btn btn-search" type="button"><span>search</span></button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="dropdown setting">
                        <a data-toggle="dropdown" role="button" href="#" class="dropdown-toggle "><span>Settings</span> <i aria-hidden="true" class="fa fa-user"></i></a>
                        <div class="dropdown-menu  ">
                            <div class="switcher  switcher-language">
                                <strong class="title">Select language</strong>
                                <ul class="switcher-options ">
                                    <li class="switcher-option">
                                        <a href="#">
                                            <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_french.png">
                                        </a>
                                    </li>
                                    <li class="switcher-option">
                                        <a href="#">
                                            <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_germany.png">
                                        </a>
                                    </li>
                                    <li class="switcher-option">
                                        <a href="#">
                                            <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_english.png">
                                        </a>
                                    </li>
                                    <li class="switcher-option switcher-active">
                                        <a href="#">
                                            <img class="switcher-flag" alt="flag" src="{$theme_url}assets/images/flags/flag_spain.png">
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="switcher  switcher-currency">
                                <strong class="title">SELECT CURRENCIES</strong>
                                <ul class="switcher-options ">
                                    <li class="switcher-option">
                                        <a href="#">
                                            <i class="fa fa-usd" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                    <li class="switcher-option switcher-active">
                                        <a href="#">
                                            <i class="fa fa-eur" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                    <li class="switcher-option">
                                        <a href="#">
                                            <i class="fa fa-gbp" aria-hidden="true"></i>
                                        </a>
                                    </li>

                                </ul>
                            </div>
                            <ul class="account">
                                <li><a href="">Wishlist</a></li>
                                <li><a href="">My Account</a></li>
                                <li><a href="">Checkout</a></li>
                                <li><a href="">Compare</a></li>
                                <li><a href="">Login/Register</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </header><!-- end HEADER -->
{/block}