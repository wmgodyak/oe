<div class="blog-post">
    <h2 class="blog-post-title"><a href="{$post.id}" rel="bookmark" title="{$post.title}">{$post.name}</a></h2>
    <p class="blog-post-meta">{date('d M, Y', $post.published)} by <a href="{$app->page->url($blog_id)}/author/{$post.author.id}">{$post.author.name}</a></p>
    {if $post.categories|count}
        <div class="blog-post-category">
            <em>
                {foreach $post.categories as $cat}
                    <a href="{$cat.id}" title="{$cat.title}">{$cat.name}</a>
                {/foreach}
            </em>
        </div>
    {/if}

    {if $post.tags|count}
        <div class="blog-post-category">
            <em>
                {foreach $post.tags as $tag}
                    <a href="{$app->page->url($blog_id)}/tag/{$tag.tag}" title="{$tag.tag}">{$tag.tag}</a>
                {/foreach}
            </em>
        </div>
    {/if}
    {assign var='img' value=$app->images->cover($post.id, 'post')}
    {if !empty($img)}
        <div class="blogimage">
            <div class="loading"></div>
            <a href="{$post.id}" rel="bookmark" title="{$post.title}">
                <img width="1080" height="580" src="{$img}" class="attachment-blog wp-post-image"  alt="{$post.name}"/>
            </a>
        </div>
    {/if}
    {$post.intro}
</div><!-- /.blog-post -->