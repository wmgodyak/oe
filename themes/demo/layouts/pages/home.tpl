{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
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

<!--post-slider-->
<section id="myCarousel" class="carousel slide post-slider">
    <div class="container">
        <div class="carousel-inner">
            <div class="item active">
                <div class="post-slider-image"><img alt="car1" src="{$theme_url}assets/images/slider-img-1.jpg"></div>
                <div class="post-slider-text">
                    <div class="post-slider-title">
                        <h2><a href="index.html#">Anything embarrassing <em>hidden middle</em></a></h2>
                    </div>
                    <div class="post-meta-elements">
                        <div class="meta-post-author">
                            <i class="fa fa-user"></i><a href="index.html#">By:Admin</a>
                        </div>
                        <div class="meta-post-cat">
                            <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>
                        </div>
                        <div class="meta-post-date">
                            <i class="fa fa-clock-o"></i>Jan 25, 2016
                        </div>
                    </div>
                    <div class="post-slider-content">
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.</p>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="post-slider-image"><img alt="car1" src="{$theme_url}assets/images/slider-post-image-2.jpg"></div>
                <div class="post-slider-text">
                    <div class="post-slider-title">
                        <h2><a href="index.html#">The standard <em>Lorem Ipsum used</em></a></h2>
                    </div>
                    <div class="post-meta-elements">
                        <div class="meta-post-author">
                            <i class="fa fa-user"></i><a href="index.html#">By:Admin</a>
                        </div>
                        <div class="meta-post-cat">
                            <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>
                        </div>
                        <div class="meta-post-date">
                            <i class="fa fa-clock-o"></i>Jan 25, 2016
                        </div>
                    </div>
                    <div class="post-slider-content">
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.</p>
                    </div>
                </div>
            </div>
        </div>
        <a class="left carousel-control" href="index.html#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
        <a class="right carousel-control" href="index.html#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </div>
</section>
<!--post-slider-end-->

<!--blog-psots-->
<section id="posts">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <article class="standard-post-format grid-box">
                    <div class="post-featured-image">
                        <a href="index.html#"><img src="{$theme_url}assets/images/post-featured-image-01.jpg" alt="image"></a>
                    </div>

                    <div class="the-post">
                        <div class="post-title">
                            <h2><a href="index.html#">Inside The Garden & <em>Blooming Flowers</em></a></h2>
                        </div>
                        <div class="post-meta-elements">
                            <div class="meta-post-author">
                                <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                            </div>
                            <div class="meta-post-cat">
                                <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>, <a href="index.html#">Standard</a>
                            </div>
                            <div class="meta-post-date">
                                <i class="fa fa-clock-o"></i>Jan 25, 2016
                            </div>
                            <div class="meta-post-commetns">
                                <i class="fa fa-comment-o"></i><a href="index.html#">Comments</a>
                            </div>
                        </div>
                        <div class="post_content">
                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley. Dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text..</p>
                            <div class="readmore">
                                <a href="index.html#" class="btn">Continue Reading..</a>
                            </div>
                        </div>
                    </div>
                </article>

                <article class="standard-post-format grid-box">
                    <div class="post-featured-image">
                        <a href="index.html#"><img src="{$theme_url}assets/images/post-featured-image-02.jpg" alt="image"></a>
                    </div>

                    <div class="the-post">
                        <div class="post-title">
                            <h2><a href="index.html#">It is a long established <em>will be distracted</em> </a></h2>
                        </div>
                        <div class="post-meta-elements">
                            <div class="meta-post-author">
                                <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                            </div>
                            <div class="meta-post-cat">
                                <i class="fa fa-tags"></i><a href="index.html#">Standard</a>
                            </div>
                            <div class="meta-post-date">
                                <i class="fa fa-clock-o"></i>Jan 25, 2016
                            </div>
                            <div class="meta-post-commetns">
                                <i class="fa fa-comment-o"></i><a href="index.html#">Comments</a>
                            </div>
                        </div>
                        <div class="post_content">
                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley. Dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text..</p>
                            <div class="readmore">
                                <a href="index.html#" class="btn">Continue Reading..</a>
                            </div>
                        </div>
                    </div>
                </article>

                <article class="standard-post-format grid-box">
                    <div class="quote-post-entry">
                        <div class="entry-overlay">
                            <div style="background-image:url(images/slider-img-1.jpg);background-repeat:no-repeat;background-size: cover;width:100%;height:100%;"></div>
                        </div>
                        <div class="quote-link">
                            <p><i class="fa fa-quote-left"></i> Pork loin leberkas ribeye capicola. Ribeye meatloaf sirloin shank, turkey pork loin salami. Flank strip steak shankle drumstick kevin  rump tail chickeRibeye meatloaf sirloin shank.   <i class="fa fa-quote-right"></i></p>
                            <span> - leberkas </span>
                        </div>
                    </div>

                    <div class="the-post">
                        <div class="post-title">
                            <h2><a href="index.html#">Quote post format <em>packages and web page</em></a></h2>
                        </div>
                        <div class="post-meta-elements">
                            <div class="meta-post-author">
                                <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                            </div>
                            <div class="meta-post-cat">
                                <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>, <a href="index.html#">Standard</a>
                            </div>
                            <div class="meta-post-date">
                                <i class="fa fa-clock-o"></i>Jan 25, 2016
                            </div>
                            <div class="meta-post-commetns">
                                <i class="fa fa-comment-o"></i><a href="index.html#">Comments</a>
                            </div>
                        </div>
                        <div class="post_content">
                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley. Dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text..</p>
                            <div class="readmore">
                                <a href="index.html#" class="btn">Continue Reading..</a>
                            </div>
                        </div>
                    </div>
                </article>

                <div class="pagination">
                    <ul>
                        <li><span class="nav-prev">Prev.</span></li>
                        <li><span class="current">1</span></li>
                        <li><a href="index.html#">2</a></li>
                        <li><a href="index.html#">3</a></li>
                        <li><a href="index.html#">4</a></li>
                        <li><a href="index.html#" class="nav-prev">Next</a></li>
                    </ul>
                </div>

            </div>

            <!-----sidebar----->

            <aside class="col-md-4">
                <div class="sidebar">
                    <div class="sidebar_widget grid-box widgetbox">
                        <div class="about_me">
                            <h6 class="sidebar-title"><span>About <em>Me</em></span></h6>
                            <div class="about_img"> <img src="{$theme_url}assets/images/morena-girl.jpg" alt="image"> </div>
                            <div class="about_text">
                                <h5>Shane <em>Doe</em></h5>
                                <div class="subtitle">Fashionista &amp; Photographer</div>
                                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.</p>
                                <a href="http://engine.log/demo/newsroom/demo1/about-me.html" class="btn">Read More.</a>
                            </div>
                        </div>
                    </div>

                    <div class="sidebar_widget grid-box widgetbox">
                        <h6 class="sidebar-title"><span>Recent <em>Posts</em></span></h6>
                        <!---latest-post-1--->
                        <div class="latest-post">
                            <div class="latest-post-img">
                                <a href="index.html#"><img alt="image" src="{$theme_url}assets/images/latest-post-img-1.jpg"> </a>
                            </div>
                            <div class="latest-post-content">
                                <div class="latest-post-title">
                                    <h6><a href="index.html#">Lorem Ipsum has <em>industry's dummy</em></a></h6>
                                </div>
                                <div class="post-meta-elements">
                                    <div class="meta-post-cat">
                                        <i class="fa fa-tags"></i><a href="index.html#">Travel</a>
                                    </div>
                                    <div class="meta-post-date">
                                        <i class="fa fa-clock-o"></i> Jan 25, 2016
                                    </div>
                                </div>
                            </div>



                        </div>
                        <!---/latest-post-1--->
                        <!---latest-post-2--->
                        <div class="latest-post">
                            <div class="latest-post-img">
                                <a href="index.html#"><img alt="image" src="{$theme_url}assets/images/latest-post-img-2.jpg"> </a>
                            </div>
                            <div class="latest-post-content">
                                <div class="latest-post-title">
                                    <h6><a href="index.html#">There are many <em>variations passages</em></a></h6>
                                </div>
                                <div class="post-meta-elements">
                                    <div class="meta-post-cat">
                                        <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>
                                    </div>
                                    <div class="meta-post-date">
                                        <i class="fa fa-clock-o"></i> Jan 25, 2016
                                    </div>
                                </div>
                            </div>



                        </div>
                        <!---/latest-post-2--->
                        <!---latest-post-3--->
                        <div class="latest-post">
                            <div class="latest-post-img">
                                <a href="index.html#"><img alt="image" src="{$theme_url}assets/images/latest-post-img-3.jpg"> </a>
                            </div>
                            <div class="latest-post-content">
                                <div class="latest-post-title">
                                    <h6><a href="index.html#">Lorem Ipsum has <em>industry's dummy</em></a></h6>
                                </div>
                                <div class="post-meta-elements">
                                    <div class="meta-post-cat">
                                        <i class="fa fa-tags"></i><a href="index.html#">Fashion</a>
                                    </div>
                                    <div class="meta-post-date">
                                        <i class="fa fa-clock-o"></i> Jan 25, 2016
                                    </div>
                                </div>
                            </div>



                        </div>
                        <!---/latest-post-3--->
                    </div>

                    <div class="sidebar_widget grid-box widgetbox">
                        <h6 class="sidebar-title"><span>Categories</span></h6>
                        <div class="psot_categories">
                            <ul>
                                <li><a href="index.html#">Collection</a></li>
                                <li><a href="index.html#">Fashion</a></li>
                                <li><a href="index.html#">Lifestyle</a></li>
                                <li><a href="index.html#">Motivation</a></li>
                                <li><a href="index.html#">Photography</a></li>
                                <li><a href="index.html#">Travel</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="sidebar_widget grid-box widgetbox">
                        <h6 class="sidebar-title"><span>Tags</span></h6>
                        <div class="post_tags">
                            <a href="index.html#">Collection</a>
                            <a href="index.html#">Fashion</a>
                            <a href="index.html#">Lifestyle</a>
                            <a href="index.html#">Motivation</a>
                            <a href="index.html#">Photography</a>
                            <a href="index.html#">Spring</a>
                            <a href="index.html#">Photography</a>
                            <a href="index.html#">You</a>
                            <a href="index.html#">Link</a>
                            <a href="index.html#">Flatness</a>
                            <a href="index.html#">Walk</a>
                            <a href="index.html#">News</a>
                            <a href="index.html#">Lifestyle</a>
                            <a href="index.html#">Video</a>
                            <a href="index.html#">Audio</a>
                        </div>
                    </div>

                </div>
            </aside>
            <!-----/sidebar----->
        </div>
    </div>
</section>
<!--/blog-posts-->



<!--popular-psots-->
<section id="popular-posts" class="padding_none">
    <div class="text-center">
        <div class="sect-heading"><p><i class="fa fa-rocket"></i>Popular Posts</p></div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-1.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">Industry's <em>standard dummy text</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Motivation</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-2.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">Industry's <em>standard dummy text</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-3.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">This is the <em>exact time you left</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Photography</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-4.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">This is the <em>exact time you left</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i>B<a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Fashion</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-5.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">Maiores explicabo <em>beatae omnis</em> </a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Collection</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="index.html#"> <img src="{$theme_url}assets/images/populat-post-img-6.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="index.html#">Beatae omnis <em>modi laboriosam</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="index.html#">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>
<!--/popular-psots-->

{include file="chunks/footer.tpl"}
{include file="chunks/scripts.tpl"}

</body>
</html>