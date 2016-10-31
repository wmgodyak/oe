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

{if $app->issetModule('mainPosts')}
    {include file="modules/main_posts/index.tpl"}
{/if}

<!--blog-psots-->
<section id="posts">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                {foreach $app->module->blog->posts(0,3) as $post}
                <article class="standard-post-format grid-box">
                    <div class="post-featured-image">
                        <a href="{$post.id}" title ="{$post.title}"><img src="{$app->images->cover($post.id, 'post')}" alt="{$post.title}"></a>
                    </div>

                    <div class="the-post">
                        <div class="post-title">
                            <h2><a href="{$post.id}" title ="{$post.title}">{$post.name}</a></h2>
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
                                <i class="fa fa-comment-o"></i><a href="index.html#">Comments</a>
                            </div>
                        </div>
                        <div class="post_content">
                            {$post.intro}
                            <div class="readmore">
                                <a href="{$post.id}" class="btn">Continue Reading..</a>
                            </div>
                        </div>
                    </div>
                </article>
                {/foreach}
                {$app->module->blog->pagination()}
            </div>

            <!-----sidebar----->
            <aside class="col-md-4">
                <div class="sidebar">
                    <div class="sidebar_widget grid-box widgetbox">
                        <div class="about_me">
                            <h6 class="sidebar-title"><span>About <em>Me</em></span></h6>
                            <div class="about_img"><img src="{$app->page->features->getImageValue(2, 'about_img')}" alt="image"> </div>
                            <div class="about_text">{$app->page->features->getValue(2, 'about_text')}</div>
                        </div>
                    </div>

                    {*<div class="sidebar_widget grid-box widgetbox">*}
                        {*<h6 class="sidebar-title"><span>Recent <em>Posts</em></span></h6>*}
                        {*<!---latest-post-1--->*}
                        {*<div class="latest-post">*}
                            {*<div class="latest-post-img">*}
                                {*<a href="index.html#"><img alt="image" src="{$theme_url}assets/images/latest-post-img-1.jpg"> </a>*}
                            {*</div>*}
                            {*<div class="latest-post-content">*}
                                {*<div class="latest-post-title">*}
                                    {*<h6><a href="index.html#">Lorem Ipsum has <em>industry's dummy</em></a></h6>*}
                                {*</div>*}
                                {*<div class="post-meta-elements">*}
                                    {*<div class="meta-post-cat">*}
                                        {*<i class="fa fa-tags"></i><a href="index.html#">Travel</a>*}
                                    {*</div>*}
                                    {*<div class="meta-post-date">*}
                                        {*<i class="fa fa-clock-o"></i> Jan 25, 2016*}
                                    {*</div>*}
                                {*</div>*}
                            {*</div>*}
                        {*</div>*}
                        {*<!---/latest-post-1--->*}
                        {*<!---latest-post-2--->*}
                        {*<div class="latest-post">*}
                            {*<div class="latest-post-img">*}
                                {*<a href="index.html#"><img alt="image" src="{$theme_url}assets/images/latest-post-img-2.jpg"> </a>*}
                            {*</div>*}
                            {*<div class="latest-post-content">*}
                                {*<div class="latest-post-title">*}
                                    {*<h6><a href="index.html#">There are many <em>variations passages</em></a></h6>*}
                                {*</div>*}
                                {*<div class="post-meta-elements">*}
                                    {*<div class="meta-post-cat">*}
                                        {*<i class="fa fa-tags"></i><a href="index.html#">Lifestyle</a>*}
                                    {*</div>*}
                                    {*<div class="meta-post-date">*}
                                        {*<i class="fa fa-clock-o"></i> Jan 25, 2016*}
                                    {*</div>*}
                                {*</div>*}
                            {*</div>*}



                        {*</div>*}
                        {*<!---/latest-post-2--->*}
                    {*</div>*}

                    {include file="modules/blog/categories.tpl"}

                    <div class="sidebar_widget grid-box widgetbox">
                        <h6 class="sidebar-title"><span>Tags</span></h6>
                        <div class="post_tags">
                            {foreach $app->module->blog->tags() as $tag}
                                <a href="{$app->page->url(11)}/tag/{$tag.tag}">{$tag.tag}</a>
                            {/foreach}
                        </div>
                    </div>

                </div>
            </aside>
            <!-----/sidebar----->
        </div>
    </div>
</section>
<!--/blog-posts-->

{include file="chunks/footer.tpl"}
{include file="chunks/scripts.tpl"}

</body>
</html>