{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-17T17:48:29+02:00
 * @name Сторінки
 *}
{include file="chunks/head.tpl"}
<body id="home">
{include file="modules/nav/top.tpl"}

<div id="hero">
    <div class="container">
        <h1 class="hero-text animated fadeInDown">
            The best OpenSource CMS <br />
            for your web site
        </h1>
        <p class="sub-text animated fadeInDown">
            Very simple and fast modular MVC system
        </p>
        <div class="cta animated fadeInDown">
            <a href="features.html" class="button-outline">See the tour</a>
            <a href="signup.html" class="button">Sign up free</a>
        </div>
        <div class="img"></div>
    </div>
</div>

<div id="features">
    <div class="container">
        <div class="row header">
            <div class="col-md-12">
                <h2>Need an easy way to customize your site?</h2>
                <p>React is perfect for novice developers and experts alike.</p>
            </div>
        </div>
        <div class="row feature">
            <div class="col-md-6 info">
                <h4>You don't need to have great technical experience to use your product.</h4>
                <p>
                    Whether you want to fill this paragraph with some text like I'm doing right now, this place
                    is perfect to describe some features or anything you want - React has a complete solution for you.
                </p>
            </div>
            <div class="col-md-6 image">
                <img src="{$theme_url}assets/images/feature1.png" class="img-responsive" alt="feature1" />
            </div>
        </div>
        <div class="divider"></div>
        <div class="row feature backwards">
            <div class="col-md-6 info">
                <h4>A fully featured well design template that works.</h4>
                <p>
                    You have complete control over the look & feel of your website, we offer the best quality so you
                    take your site up and running in no time.
                </p>
                <p>
                    Write some text here to explain the features of your site or application, it
                    has lots of uses.
                </p>
            </div>
            <div class="col-md-6 image">
                <img src="{$theme_url}assets/images/feature2.png" class="img-responsive" alt="feature2" />
            </div>
        </div>
    </div>
</div>

<div id="pricing">
    <div class="container">
        <div class="row header">
            <div class="col-md-12">
                <h3>Free trial. No contract. Cancel when you want.</h3>
                <p>All plans include a 7-day free trial</p>
            </div>
        </div>
        <div class="row charts">
            <div class="col-md-4">
                <div class="chart first">
                    <div class="quantity">
                        <span class="dollar">$</span>
                        <span class="price">29</span>
                        <span class="period">/month</span>
                    </div>
                    <div class="plan-name">Freelance</div>
                    <div class="specs">
                        <div class="spec">
                            <span class="variable">5</span>
                            team members
                        </div>
                        <div class="spec">
                            <span class="variable">Digital</span>
                            recurring billing
                        </div>
                        <div class="spec">
                            <span class="variable">Virtual</span>
                            online terminal
                        </div>
                        <div class="spec">
                            <span class="variable">10</span>
                            total products
                        </div>
                        <div class="spec">
                            <span class="variable">1.0%</span>
                            Transaction fee
                        </div>
                    </div>
                    <a class="btn-signup button-clear" href="signup.html">
                        <span>Start free trial</span>
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="chart featured">
                    <div class="popular">Most popular</div>
                    <div class="quantity">
                        <span class="dollar">$</span>
                        <span class="price">79</span>
                        <span class="period">/month</span>
                    </div>
                    <div class="plan-name">Profesional</div>
                    <div class="specs">
                        <div class="spec">
                            <span class="variable">15</span>
                            team members
                        </div>
                        <div class="spec">
                            <span class="variable">Digital</span>
                            recurring billing
                        </div>
                        <div class="spec">
                            <span class="variable">Virtual</span>
                            online terminal
                        </div>
                        <div class="spec">
                            <span class="variable">15</span>
                            total products
                        </div>
                        <div class="spec">
                            <span class="variable">0.5%</span>
                            Transaction fee
                        </div>
                    </div>
                    <a class="btn-signup button-clear" href="signup.html">
                        <span>Start free trial</span>
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="chart last">
                    <div class="quantity">
                        <span class="dollar">$</span>
                        <span class="price">119</span>
                        <span class="period">/month</span>
                    </div>
                    <div class="plan-name">Premium</div>
                    <div class="specs">
                        <div class="spec">
                            <span class="variable">Unlimited</span>
                            team members
                        </div>
                        <div class="spec">
                            <span class="variable">Digital</span>
                            recurring billing
                        </div>
                        <div class="spec">
                            <span class="variable">Virtual</span>
                            online terminal
                        </div>
                        <div class="spec">
                            <span class="variable">25</span>
                            total products
                        </div>
                        <div class="spec">
                            <span class="variable">No</span>
                            Transaction fee
                        </div>
                    </div>
                    <a class="btn-signup button-clear" href="signup.html">
                        <span>Start free trial</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="slider">
    <div class="container">
        <div class="row header">
            <div class="col-md-12">
                <h3>Includes all pages that a complete theme should have</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 slide-wrapper">
                <div class="slideshow">
                    <div class="btn-nav prev"></div>
                    <div class="btn-nav next"></div>
                    <div class="slide active">
                        <img src="{$theme_url}assets/images/slider/slide3.png" alt="slide3" />
                    </div>
                    <div class="slide">
                        <img src="{$theme_url}assets/images/slider/slide4.png" alt="slide4" />
                    </div>
                    <div class="slide">
                        <img src="{$theme_url}assets/images/slider/slide1.png" alt="slide1" />
                    </div>
                    <div class="slide">
                        <img src="{$theme_url}assets/images/slider/slide5.png" alt="slide5" />
                    </div>
                    <div class="slide">
                        <img src="{$theme_url}assets/images/slider/slide2.png" alt="slide2" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="testimonials">
    <div class="container">
        <div class="row header">
            <div class="col-md-12">
                <h3>Trusted by a lot businesses around the world:</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="testimonial pull-right">
                    <div class="quote">
                        I am just quoting some stuff but I am seriously happy about this product. Has a lot of powerful
                        features and is so easy to set up, I could stay customizing it day and night, it's just so much fun!
                        <div class="arrow-down">
                            <div class="arrow"></div>
                            <div class="arrow-border"></div>
                        </div>
                    </div>
                    <div class="author">
                        <img src="{$theme_url}assets/images/testimonials/testimonial3.jpg" class="pic" alt="testimonial3" />
                        <div class="name">John McClane</div>
                        <div class="company">Microsoft</div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="testimonial">
                    <div class="quote">
                        This thing is one of those tools that everybody should be using. I really like it and with this ease to use, you can kickstart your projects and apps and just focus on your business!
                        <div class="arrow-down">
                            <div class="arrow"></div>
                            <div class="arrow-border"></div>
                        </div>
                    </div>
                    <div class="author">
                        <img src="{$theme_url}assets/images/testimonials/testimonial2.jpg" class="pic" alt="testimonial2" />
                        <div class="name">Karen Jones</div>
                        <div class="company">Pixar Co.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="cta">
    <p>
        Start your free 14 day trial!
    </p>
    <a href="signup.html">
        Sign up for free
    </a>
</div>

<div id="clients">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h3>Our Customers</h3>
                <p>
                    These are some of our customers who have helped us by using our product.
                </p>
                <div class="logos">
                    <img src="{$theme_url}assets/images/logos/google.png">
                    <img src="{$theme_url}assets/images/logos/facebook.png">
                    <img src="{$theme_url}assets/images/logos/apple.png">
                    <img src="{$theme_url}assets/images/logos/stripe.png">
                    <img src="{$theme_url}assets/images/logos/yahoo.png">
                </div>
            </div>
        </div>
    </div>
</div>

{include file="chunks/footer.tpl"}
