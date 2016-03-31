{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-17T17:48:39+02:00
 * @name Статті
 *}

{include file="chunks/head.tpl"}
<body id="blogpost">
{include file="modules/nav/top.tpl"}

<div id="blogpost-wrapper">
    <div class="container">
        {*<pre>{print_r($post)}</pre>*}
        {if $post.image}
        <div class="row">
            <div class="col-md-12">
                <div class="main-pic">
                    <img src="{$post.image.path}post/{$post.image.image}" class="img-responsive" alt="blogpost" />
                </div>
            </div>
        </div>
        {/if}
        <div class="row">
            <div class="col-md-10 post">
                <div class="title">
                    {$post.name}
                </div>
                <div class="author">
                    <img src="{$post.author.avatar}" class="avatar" alt="author" />
                    By {$post.author.name} {$post.author.surname}, {$post.published}
                </div>
                <div class="content">
                   {$post.content}
                </div>
                <div class="share">
                    <img src="{$theme_url}assets/images/share.png" alt="share" />
                </div>
                {if $post.tags|count}
                <div class="share">
                    {foreach $post.tags as $tag}
                        <a href="{$blog_page_id};tag={$tag.tag}">{$tag.tag}</a>
                    {/foreach}
                </div>
                {/if}
                <div class="other-posts">
                    {if $post.prev_post}
                    <a href="{$post.prev_post.id}" class="prev">
                        ← {$post.prev_post.name}
                    </a>
                    {/if}
                    {if $post.next_post}
                        <a href="{$post.next_post.id}" class="next pull-right">
                            {$post.next_post.name} →
                        </a>
                    {/if}
                </div>
            </div>
        </div>
        {if $post.comments.enabled}
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <h3>Comments to {$post.name}.</h3>
                    <h4>Total comments {$post.comments.total}</h4>
                    {if $user}
                        <p><a href="javascript:;" class="{if $post.comments.subscribe}b-comments-un-subscribe{else}b-comments-subscribe{/if}" data-s="Subscribe" data-us="Un subscribe" data-id="{$post.id}">{if $post.comments.subscribe}b-comments-un-subscribe{else}b-comments-subscribe{/if}</a></p>
                        {include file="modules/comments/create.tpl"}
                    {else}
                        <p><a href="29">Авторизуйтесь, щоб мати можливість коментувати статті</a></p>
                    {/if}

                    {include file="modules/comments/items.tpl"}
                </div>
            </div>
        {/if}
    </div>
</div>


{include file="chunks/footer.tpl"}
</body>
</html>