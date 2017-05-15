<div class="blog-post {if $i > 0}outer-top-bd{/if} wow fadeInUp">
    {assign var='img' value=$app->images->cover($post.id, 'post')}
    {if !empty($img)}
        <a href="{$post.url}" title="{$post.title}">
            <img class="img-responsive" src="{$img}" alt="{$post.title}">
        </a>
    {/if}
    <h1><a href="{$post.url}" title="{$post.title}">{$post.name}</a></h1>
    <span class="author"><a href="{$app->page->url($blog.id)}/author/{$post.author.id}">{$post.author.name}</a></span>
    <span class="review">6 Comments</span>
    <span class="date-time">{date('d M, Y', $post.published)}</span>
    <span class="review">
            Tags:
        {foreach $post.tags as $k=>$tag}
            <a href="{$app->page->url($blog.id)}/tag/{$tag.tag}">{$tag.tag}</a>
        {/foreach}
        </span>
    {$post.intro}
    <a href="{$post.url}" class="btn btn-upper btn-primary read-more">read more</a>
</div>