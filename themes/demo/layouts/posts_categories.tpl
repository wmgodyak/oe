{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name default
 *}
{include file="chunks/head.tpl"}
{include file="chunks/header.tpl"}
{if $page.id == 11}{$page.id=0}{/if}
{if $smarty.get.q != ''}
    {assign var='posts' value= $app->module->blog->search($page.id)}
    {else}
    {assign var='posts' value= $app->module->blog->posts($page.id)}
{/if}

<!--blog-psots-->
<section id="posts">
    <div class="container">
        <div class="category_heading text-center">
            <h1>{$page.h1}</h1>
        </div>
        <div class="row">
            <div class="col-md-12">
                {if $mod->blog->hasError()}
                    <div class="two-col-sidebar">
                        <div class="alert alert-danger">
                            <button data-dismiss="alert" class="close" type="button">×</button>
                            <strong>Error</strong><br>
                            {implode('<br>', $mod->blog->getError())}
                        </div>
                    </div>
                {else}
                    <div class="two-col-sidebar">
                        {if empty($posts) && $smarty.get.q != ''}
                            <div class="two-col-sidebar">
                                <div class="alert alert-info">
                                    <button data-dismiss="alert" class="close" type="button">×</button>
                                    <strong>Error</strong><br>
                                    <p>Your search query: {$smarty.get.q}</p>
                                    <p>Sorry, no results found</p>
                                </div>
                            </div>
                        {/if}
                        {if !empty($selected_tag)}
                            <div class="two-col-sidebar">
                                <div class="alert alert-info">
                                    <button data-dismiss="alert" class="close" type="button">×</button>
                                    <strong>Info</strong><br>
                                    <p>Post by tag: {$selected_tag}</p>
                                </div>
                            </div>
                        {/if}
                        {foreach $posts as $post}
                            <article class="standard-post-format grid-box">
                                {*<pre>{print_r($post)}</pre>*}
                            <div class="post-featured-image">
                                <a href="{$post.id}"><img src="{$app->images->cover($post.id, 'post')}" alt="{$post.title}"></a>
                            </div>

                            <div class="the-post">
                                <div class="post-title">
                                    <h2><a href="{$post.id}">{$post.name}</a></h2>
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
                                        <i class="fa fa-comment-o"></i><a href="#">Comments</a>
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
                    </div>
                    {*{include file="chunks/pagination.tpl"}*}
                    {$app->module->blog->pagination()}
                {/if}
            </div>
        </div>
    </div>
</section>
<!--/blog-posts-->

{include file="chunks/footer.tpl"}
{include file="chunks/scripts.tpl"}

</body>
</html>