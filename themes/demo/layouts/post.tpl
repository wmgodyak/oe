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
            {$post.images = $app->images->get($post.id, 'post')}
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
                    <img src="{$app->images->cover($post.id, 'post')}" alt="image">
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
        {$events->call('display_comments', $post)}
    </div>
</section>
<!--/blog-posts-->
{include file="chunks/footer.tpl"}
{include file="chunks/scripts.tpl"}

</body>
</html>