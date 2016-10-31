{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name post
 *}
{include file="chunks/head.tpl"}
{include file="chunks/header.tpl"}

<section id="single-post">
    <div class="container">
        <article class="standard-post-format grid-box">
            {*<pre>{print_r($post)}</pre>*}
            <div class="single-post-head text-center">
                <div class="post-title">
                    <h2>{$post.h1}</h2>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11?author={$post.author.id}">{$post.author.name}</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i>
                        {foreach $post.categories as $i=>$category}
                            <a href="{$category.id}">{$category.name}</a>{if isset($post.categories[$i+1])}, {/if}
                        {/foreach}
                    </div>
                    <div class="meta-post-date">
                        <i class="fa fa-clock-o"></i>{date('M d, Y', $post.created)}
                    </div>
                    <div class="meta-post-commetns">
                        <i class="fa fa-comment-o"></i><a href="11">Comments</a>
                    </div>
                </div>
            </div>
            {if $post.images|count > 1}
                <div id="myCarousel" class="carousel slide post-slider" data-ride="carousel">
                    <div class="carousel-inner">
                        {foreach $post.images as $i=>$image}
                        <div class="item {if $i == 0}active{/if}"><img alt="car1" src="{$image.path}post/{$image.image}"></div>
                        {/foreach}
                    </div>
                    <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
                    <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                </div>
                {else}
                <div class="post-featured-image">
                    <img src="{$post.image.path}post/{$post.image.image}" alt="image">
                </div>
            {/if}

            <div class="the-post">
                <div class="post_content">
                    {$post.content}
                    <div class="post_tag_share">
                        <div class="post_tags">
                            <h5>Tags</h5>
                            {foreach $post.tags as $tag}
                                <a href="{$app->page->url(11)}/tag/{$tag.tag}">{$tag.tag}</a>
                            {/foreach}
                        </div>
                        <div class="blog-share-button ">
                            <h5><i class="fa fa-share-alt"></i> Share</h5>
                            <ul>
                                <li><a href="11"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="11"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="11"><i class="fa fa-linkedin"></i></a></li>
                                <li><a href="11"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="11"><i class="fa fa-pinterest-p"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </article>

        {assign var='related' value=$app->module->blog->relatedPosts($post.id)}
        {if $related|count}
        <!--Related Post-->
        <div class="all_related_post white_bg padding_4x4_30">
            <h3>Related <em>Post</em></h3>
            {foreach $related as $post}
                <div class="col-md-4 col-sm-6">
                    <article class="related_posts">
                        <div class="related_post_image">
                            <a href="{$post.id}" title="{$post.title}"> <img src="{$app->images->cover($post.id, 'post')}" alt="{$post.title}"> </a>
                        </div>
                        <div class="related_post_text">
                            <div class="related_post_title">
                                <h5><a href="{$post.id}" title="{$post.title}">{$post.name}</a></h5>
                            </div>
                            <div class="post-meta-elements">
                                <div class="meta-post-author">
                                    <i class="fa fa-user"></i><a href="11?author={$post.author.id}">{$post.author.name}</a>
                                </div>
                                <div class="meta-post-cat">
                                    <i class="fa fa-tags"></i>
                                    {foreach $post.categories as $i=>$category}
                                        <a href="{$category.id}">{$category.name}</a>{if isset($post.categories[$i+1])}, {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    </article>
                </div>
            {/foreach}
        </div>
        <!--/Related Post-->
        {/if}

        <!--comments-->
        <div class="all_comments">
            <h3>Comments <em>(3)</em></h3>
            <ul>
                <li class="comment_list">
                    <div class="comment_author_avatar">
                        <img src="{$theme_url}assets/images/populat-post-img-4.jpg" alt="image">
                    </div>

                    <div class="comment_content">
                        <div class="comment_info">
                            <h6 class="comment_author">Admin<a href="11"></a></h6>
                            <span class="comment_date">December 17, 2015</span>
                            <span class="comment_time">10:44 am</span>
                        </div>
                        <div class="comment_text_wrap">
                            <div class="comment_text"><p>Aliquam id nibh vestibulum, finibus felis at, dictum libero. Nullam dignissim vel quam at placerat. Suspendisse potenti. Vivamus lacinia nunc in orci iaculis, non luctus est aliquam. Integer quis tincidunt metus. Duis ornare ultrices nisi ut feugiat.</p>
                            </div>
                        </div>
                        <div class="comment_reply"><a href="11" class="btn"><i class="fa fa-reply"></i> Reply</a></div>
                    </div>
                </li>
                <li class="comment_list">
                    <div class="comment_author_avatar">
                        <img src="{$theme_url}assets/images/populat-post-img-4.jpg" alt="image">
                    </div>
                    <div class="comment_content">
                        <div class="comment_info">
                            <h6 class="comment_author">Admin<a href="11"></a></h6>
                            <span class="comment_date">December 17, 2015</span>
                            <span class="comment_time">10:44 am</span>
                        </div>
                        <div class="comment_text_wrap">
                            <div class="comment_text"><p>Aliquam id nibh vestibulum, finibus felis at, dictum libero. Nullam dignissim vel quam at placerat. Suspendisse potenti. Vivamus lacinia nunc in orci iaculis, non luctus est aliquam. Integer quis tincidunt metus. Duis ornare ultrices nisi ut feugiat.</p>
                            </div>
                        </div>
                        <div class="comment_reply"><a href="11" class="btn"><i class="fa fa-reply"></i> Reply</a></div>
                    </div>
                    <ul class="child_list">
                        <div class="comment_author_avatar">
                            <img src="{$theme_url}assets/images/populat-post-img-4.jpg" alt="image">
                        </div>
                        <div class="comment_content">
                            <div class="comment_info">
                                <h6 class="comment_author">Admin<a href="11"></a></h6>
                                <span class="comment_date">December 17, 2015</span>
                                <span class="comment_time">10:44 am</span>
                            </div>
                            <div class="comment_text_wrap">
                                <div class="comment_text"><p>Aliquam id nibh vestibulum, finibus felis at, dictum libero. Nullam dignissim vel quam at placerat. Suspendisse potenti. Vivamus lacinia nunc in orci iaculis, non luctus est aliquam. Integer quis tincidunt metus. Duis ornare ultrices nisi ut feugiat.</p>
                                </div>
                            </div>
                            <div class="comment_reply"><a href="11" class="btn"><i class="fa fa-reply"></i> Reply</a></div>
                        </div>
                    </ul>
                </li>
            </ul>
        </div>
        <!--/comments-->

        <div class="psot_comment">
            <h3>Leave a <em>Reply</em> </h3>
            <div class="commentform">
                <form action="gallery-post-format.html">
                    <div class="form-group">
                        <textarea tabindex="4" rows="7" class="required" id="comment" placeholder="Your message" name="comment"></textarea>
                    </div>

                    <div class="form-group">
                        <input type="text" aria-required="true" size="30" value="" placeholder="Name *" name="author" id="author">
                    </div>

                    <div class="form-group">
                        <input type="email" aria-required="true" size="30" value="" placeholder="Email *" name="email" id="email">
                    </div>

                    <div class="form-group">
                        <input type="text" size="30" value="" placeholder="Website" name="url" id="url">
                    </div>

                    <div class="form-group">
                        <input type="submit" value="Post comment" class="submit btn active_btn" id="submit" name="submit">
                    </div>


                </form>
            </div>
        </div>

    </div>
</section>
<!--/blog-posts-->



<!--popular-posts-->
<section id="popular-posts" class="padding_none">
    <div class="text-center">
        <div class="sect-heading"><p><i class="fa fa-rocket"></i>Popular Posts</p></div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-1.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">Industry's <em>standard dummy text</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Motivation</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-2.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">Industry's <em>standard dummy text</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Lifestyle</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-3.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">This is the <em>exact time you left</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Photography</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-4.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">This is the <em>exact time you left</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i>B<a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Fashion</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-5.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">Maiores explicabo <em>beatae omnis</em> </a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Collection</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-4 col-md-2">
        <div class="popular_posts">
            <div class="populat_post_image">
                <a href="11"> <img src="{$theme_url}assets/images/populat-post-img-6.jpg" alt="image"> </a>
            </div>
            <div class="popular_posts_text">
                <div class="populat_post_title">
                    <h5><a href="11">Beatae omnis <em>modi laboriosam</em></a></h5>
                </div>
                <div class="post-meta-elements">
                    <div class="meta-post-author">
                        <i class="fa fa-user"></i><a href="11">Admin</a>
                    </div>
                    <div class="meta-post-cat">
                        <i class="fa fa-tags"></i><a href="11">Lifestyle</a>
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