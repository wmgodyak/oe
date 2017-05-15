{block name="header"}
<header class="{block name="header.class"}header-style-1{/block}">

    <!-- ============================================== TOP MENU ============================================== -->
    <div class="top-bar animate-dropdown">
        <div class="container">
            <div class="header-top-inner">
                <div class="cnt-account">
                    <ul class="list-unstyled">
                        <li><a href="#"><i class="icon fa fa-user"></i>My Account</a></li>
                        <li><a href="#"><i class="icon fa fa-heart"></i>Wishlist</a></li>
                        <li><a href="#"><i class="icon fa fa-shopping-cart"></i>My Cart</a></li>
                        <li><a href="#"><i class="icon fa fa-key"></i>Checkout</a></li>
                        <li><a href="#"><i class="icon fa fa-sign-in"></i>Login</a></li>
                    </ul>
                </div><!-- /.cnt-account -->

                <div class="cnt-block">
                    <ul class="list-unstyled list-inline">
                        <li class="dropdown dropdown-small">
                            <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><span class="key">currency :</span><span class="value">USD </span><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">USD</a></li>
                                <li><a href="#">INR</a></li>
                                <li><a href="#">GBP</a></li>
                            </ul>
                        </li>

                        <li class="dropdown dropdown-small">
                            <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown"><span class="key">language :</span><span class="value">English </span><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">English</a></li>
                                <li><a href="#">French</a></li>
                                <li><a href="#">German</a></li>
                            </ul>
                        </li>
                    </ul><!-- /.list-unstyled -->
                </div><!-- /.cnt-cart -->
                <div class="clearfix"></div>
            </div><!-- /.header-top-inner -->
        </div><!-- /.container -->
    </div><!-- /.header-top -->
    <!-- ============================================== TOP MENU : END ============================================== -->
    <div class="main-header">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-3 logo-holder">
                    <!-- ============================================================= LOGO ============================================================= -->
                    <div class="logo">
                        <a href="home.html">

                            <img src="{$theme_url}assets/images/logo.png" alt="">

                        </a>
                    </div><!-- /.logo -->
                    <!-- ============================================================= LOGO : END ============================================================= -->				</div><!-- /.logo-holder -->

                <div class="col-xs-12 col-sm-12 col-md-6 top-search-holder">
                    <div class="contact-row">
                        <div class="phone inline">
                            <i class="icon fa fa-phone"></i> (400) 888 888 868
                        </div>
                        <div class="contact inline">
                            <i class="icon fa fa-envelope"></i> saler@unicase.com
                        </div>
                    </div><!-- /.contact-row -->
                    <!-- ============================================================= SEARCH AREA ============================================================= -->
                    <div class="search-area">
                        <form>
                            <div class="control-group">

                                <ul class="categories-filter animate-dropdown">
                                    <li class="dropdown">

                                        <a class="dropdown-toggle"  data-toggle="dropdown" href="category.html">Categories <b class="caret"></b></a>

                                        <ul class="dropdown-menu" role="menu" >
                                            <li class="menu-header">Computer</li>
                                            <li role="presentation"><a role="menuitem" tabindex="-1" href="category.html">- Laptops</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="-1" href="category.html">- Tv & audio</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="-1" href="category.html">- Gadgets</a></li>
                                            <li role="presentation"><a role="menuitem" tabindex="-1" href="category.html">- Cameras</a></li>

                                        </ul>
                                    </li>
                                </ul>

                                <input class="search-field" placeholder="Search here..." />

                                <a class="search-button" href="#" ></a>

                            </div>
                        </form>
                    </div><!-- /.search-area -->
                    <!-- ============================================================= SEARCH AREA : END ============================================================= -->				</div><!-- /.top-search-holder -->

                <div class="col-xs-12 col-sm-12 col-md-3 animate-dropdown top-cart-row">
                    <!-- ============================================================= SHOPPING CART DROPDOWN ============================================================= -->

                    <div class="dropdown dropdown-cart">
                        <a href="#" class="dropdown-toggle lnk-cart" data-toggle="dropdown">
                            <div class="items-cart-inner">
                                <div class="total-price-basket">
                                    <span class="lbl">cart -</span>
					<span class="total-price">
						<span class="sign">$</span>
						<span class="value">600.00</span>
					</span>
                                </div>
                                <div class="basket">
                                    <i class="glyphicon glyphicon-shopping-cart"></i>
                                </div>
                                <div class="basket-item-count"><span class="count">2</span></div>

                            </div>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <div class="cart-item product-summary">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="image">
                                                <a href="detail.html"><img src="{$theme_url}assets/images/cart.jpg" alt=""></a>
                                            </div>
                                        </div>
                                        <div class="col-xs-7">

                                            <h3 class="name"><a href="index.php?page-detail">Simple Product</a></h3>
                                            <div class="price">$600.00</div>
                                        </div>
                                        <div class="col-xs-1 action">
                                            <a href="#"><i class="fa fa-trash"></i></a>
                                        </div>
                                    </div>
                                </div><!-- /.cart-item -->
                                <div class="clearfix"></div>
                                <hr>

                                <div class="clearfix cart-total">
                                    <div class="pull-right">

                                        <span class="text">Sub Total :</span><span class='price'>$600.00</span>

                                    </div>
                                    <div class="clearfix"></div>

                                    <a href="checkout.html" class="btn btn-upper btn-primary btn-block m-t-20">Checkout</a>
                                </div><!-- /.cart-total-->


                            </li>
                        </ul><!-- /.dropdown-menu-->
                    </div><!-- /.dropdown-cart -->

                    <!-- ============================================================= SHOPPING CART DROPDOWN : END============================================================= -->				</div><!-- /.top-cart-row -->
            </div><!-- /.row -->

        </div><!-- /.container -->

    </div><!-- /.main-header -->

    <!-- ============================================== NAVBAR ============================================== -->
    <div class="header-nav animate-dropdown">
        <div class="container">
            <div class="yamm navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button data-target="#mc-horizontal-menu-collapse" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="nav-bg-class">
                    <div class="navbar-collapse collapse" id="mc-horizontal-menu-collapse">
                        <div class="nav-outer">
                            <ul class="nav navbar-nav">
                                <li class="active dropdown yamm-fw">
                                    <a href="home.html" data-hover="dropdown" class="dropdown-toggle" data-toggle="dropdown">Home</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <div class="yamm-content">
                                                <div class="row">
                                                    <div class="col-md-8 col-sm-8">
                                                        <div class="row">
                                                            <div class='col-md-12'>

                                                                <div class="col-xs-12 col-sm-6 col-md-3">
                                                                    <h2 class="title">Computer</h2>
                                                                    <ul class="links">
                                                                        <li><a href="#">Lenovo</a></li>
                                                                        <li><a href="#">Microsoft </a></li>
                                                                        <li><a href="#">Fuhlen</a></li>
                                                                        <li><a href="#">Longsleeves</a></li>
                                                                    </ul>
                                                                </div><!-- /.col -->

                                                                <div class="col-xs-12 col-sm-6 col-md-3">
                                                                    <h2 class="title">Camera</h2>
                                                                    <ul class="links">
                                                                        <li><a href="#">Fuhlen</a></li>
                                                                        <li><a href="#">Lenovo</a></li>
                                                                        <li><a href="#">Microsoft </a></li>
                                                                        <li><a href="#">Longsleeves</a></li>
                                                                    </ul>
                                                                </div><!-- /.col -->

                                                                <div class="col-xs-12 col-sm-6 col-md-3">
                                                                    <h2 class="title">Apple Store</h2>
                                                                    <ul class="links">
                                                                        <li><a href="#">Longsleeves</a></li>
                                                                        <li><a href="#">Fuhlen</a></li>
                                                                        <li><a href="#">Lenovo</a></li>
                                                                        <li><a href="#">Microsoft </a></li>
                                                                    </ul>
                                                                </div><!-- /.col -->

                                                                <div class="col-xs-12 col-sm-6 col-md-3">
                                                                    <h2 class="title">Smart Phone</h2>
                                                                    <ul class="links">
                                                                        <li><a href="#">Microsoft </a></li>
                                                                        <li><a href="#">Longsleeves</a></li>
                                                                        <li><a href="#">Fuhlen</a></li>
                                                                        <li><a href="#">Lenovo</a></li>

                                                                    </ul>
                                                                </div><!-- /.col -->

                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                    </div>
                                                </div><!-- /.row -->

                                                <!-- ============================================== WIDE PRODUCTS ============================================== -->
                                                <div class="wide-banners megamenu-banner">
                                                    <div class="row">
                                                        <div class="col-sm-12 col-md-8">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-sm-6 col-md-6">
                                                                        <div class="wide-banner cnt-strip">
                                                                            <div class="image">
                                                                                <img class="img-responsive" data-echo="{$theme_url}assets/images/banners/4.jpg" src="{$theme_url}assets/images/blank.gif" alt="">
                                                                            </div>
                                                                            <div class="strip">
                                                                                <div class="strip-inner text-right">
                                                                                    <h3 class="white">new trend</h3>
                                                                                    <h2 class="white">apple product</h2>
                                                                                </div>
                                                                            </div>
                                                                        </div><!-- /.wide-banner -->
                                                                    </div><!-- /.col -->

                                                                    <div class="col-sm-6 col-md-6">
                                                                        <div class="wide-banner cnt-strip">
                                                                            <div class="image">
                                                                                <img class="img-responsive" data-echo="{$theme_url}assets/images/banners/5.jpg" src="{$theme_url}assets/images/blank.gif" alt="">
                                                                            </div>
                                                                            <div class="strip">
                                                                                <div class="strip-inner text-left">
                                                                                    <h3 class="white">camera collection</h3>
                                                                                    <h2 class="white">new arrivals</h2>
                                                                                </div>
                                                                            </div>
                                                                        </div><!-- /.wide-banner -->
                                                                    </div><!-- /.col -->
                                                                </div>

                                                            </div><!-- /.row -->
                                                        </div>
                                                        <div class="col-sm-12 col-md-4 hidden-xs hidden-sm">
                                                            <p class="text ">LenovoProin gravida nibh vel velit auctor aliquet es  Aenean sollicitudin,lorem quis bibendu auctor,nisi elit consequat ipsum auctor.</p>
                                                        </div>
                                                    </div>
                                                </div><!-- /.wide-banners -->

                                                <!-- ============================================== WIDE PRODUCTS : END ============================================== -->

                                            </div><!-- /.yamm-content -->					</li>
                                    </ul>
                                </li>
                                <li class="dropdown yamm">
                                    <a href="home.html" data-hover="dropdown" class="dropdown-toggle" data-toggle="dropdown">Desktop</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <div class="yamm-content">
                                                <div class="row">
                                                    <div class='col-sm-12'>
                                                        <div class="col-xs-12 col-sm-12 col-md-4">
                                                            <h2 class="title">Laptops &amp; Notebooks</h2>
                                                            <ul class="links">
                                                                <li><a href="#">Power Supplies Power</a></li>
                                                                <li><a href="#">Power Supply Testers Sound </a></li>
                                                                <li><a href="#">Sound Cards (Internal)</a></li>
                                                                <li><a href="#">Video Capture &amp; TV Tuner Cards</a></li>
                                                                <li><a href="#">Other</a></li>
                                                            </ul>
                                                        </div><!-- /.col -->

                                                        <div class="col-xs-12 col-sm-12 col-md-4">
                                                            <h2 class="title">Computers &amp; Laptops</h2>
                                                            <ul class="links">
                                                                <li><a href="#">Computer Cases &amp; Accessories</a></li>
                                                                <li><a href="#">CPUs, Processors</a></li>
                                                                <li><a href="#">Fans, Heatsinks &amp; Cooling</a></li>
                                                                <li><a href="#">Graphics, Video Cards</a></li>
                                                                <li><a href="#">Interface, Add-On Cards</a></li>
                                                                <li><a href="#">Laptop Replacement Parts</a></li>
                                                                <li><a href="#">Memory (RAM)</a></li>
                                                                <li><a href="#">Motherboards</a></li>
                                                                <li><a href="#">Motherboard &amp; CPU Combos</a></li>
                                                                <li><a href="#">Motherboard Components &amp; Accs</a></li>
                                                            </ul>
                                                        </div><!-- /.col -->

                                                        <div class="col-xs-12 col-sm-12 col-md-4">
                                                            <h2 class="title">Dekstop Parts</h2>
                                                            <ul class="links">
                                                                <li><a href="#">Power Supplies Power</a></li>
                                                                <li><a href="#">Power Supply Testers Sound</a></li>
                                                                <li><a href="#">Sound Cards (Internal)</a></li>
                                                                <li><a href="#">Video Capture &amp; TV Tuner Cards</a></li>
                                                                <li><a href="#">Other</a></li>
                                                            </ul>
                                                        </div><!-- /.col -->
                                                    </div>
                                                </div><!-- /.row -->
                                            </div><!-- /.yamm-content -->					</li>
                                    </ul>
                                </li>

                                <li class="dropdown">

                                    <a href="category.html">Electronics
                                        <span class="menu-label hot-menu hidden-xs">hot</span>
                                    </a>
                                </li>
                                <li class="dropdown hidden-sm">

                                    <a href="category.html">Television
                                        <span class="menu-label new-menu hidden-xs">new</span>
                                    </a>
                                </li>

                                <li class="dropdown hidden-sm">
                                    <a href="category.html">Smart Phone</a>
                                </li>

                                <li class="dropdown">
                                    <a href="contact.html">Contact</a>
                                </li>

                                <li class="dropdown navbar-right">
                                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-toggle="dropdown">Pages</a>
                                    <ul class="dropdown-menu pages">
                                        <li>
                                            <div class="yamm-content">
                                                <div class="row">

                                                    <div class='col-xs-12 col-sm-4 col-md-4'>
                                                        <ul class='links'>
                                                            <li><a href="home.html">Home I</a></li>
                                                            <li><a href="home2.html">Home II</a></li>
                                                            <li><a href="category.html">Category</a></li>
                                                            <li><a href="category-2.html">Category II</a></li>
                                                            <li><a href="detail.html">Detail</a></li>
                                                            <li><a href="detail2.html">Detail II</a></li>
                                                            <li><a href="shopping-cart.html">Shopping Cart Summary</a></li>

                                                        </ul>
                                                    </div>
                                                    <div class='col-xs-12 col-sm-4 col-md-4'>
                                                        <ul class='links'>
                                                            <li><a href="checkout.html">Checkout</a></li>
                                                            <li><a href="blog.html">Blog</a></li>
                                                            <li><a href="blog-details.html">Blog Detail</a></li>
                                                            <li><a href="contact.html">Contact</a></li>
                                                            <li><a href="homepage1.html">Homepage 1</a></li>
                                                            <li><a href="homepage2.html">Homepage 2</a></li>
                                                            <li><a href="home-furniture.html">Home Furniture</a></li>
                                                        </ul>
                                                    </div>
                                                    <div class='col-xs-12 col-sm-4 col-md-4'>
                                                        <ul class='links'>
                                                            <li><a href="sign-in.html">Sign In</a></li>
                                                            <li><a href="my-wishlist.html">Wishlist</a></li>
                                                            <li><a href="terms-conditions.html">Terms and Condition</a></li>
                                                            <li><a href="track-orders.html">Track Orders</a></li>
                                                            <li><a href="product-comparison.html">Product-Comparison</a></li>
                                                            <li><a href="faq.html">FAQ</a></li>
                                                            <li><a href="404.html">404</a></li>
                                                        </ul>

                                                    </div>

                                                </div>
                                            </div>
                                        </li>


                                    </ul>
                                </li>

                            </ul><!-- /.navbar-nav -->
                            <div class="clearfix"></div>
                        </div><!-- /.nav-outer -->
                    </div><!-- /.navbar-collapse -->


                </div><!-- /.nav-bg-class -->
            </div><!-- /.navbar-default -->
        </div><!-- /.container-class -->

    </div><!-- /.header-nav -->
    <!-- ============================================== NAVBAR : END ============================================== -->

</header>
{/block}