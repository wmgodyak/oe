<div class="blog-header">
    <h1 class="blog-title">{$post.h1}</h1>
    <p class="lead blog-description">{$post.description}</p>
</div>

<div class="row">
    <div class="col-sm-8 blog-main">
        <p class="blog-post-meta">{date('d M, Y', $post.published)} by <a href="{$app->page->url($blog_id)}/author/{$post.author.id}">{$post.author.name}</a></p>
        <p class="blog-post-meta">{$app->contentMeta->get($post.id, 'views', true) * 1} views</p>
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
                    <img  src="{$img}" class="attachment-blog wp-post-image"  alt="{$post.name}"/>
                </a>
            </div>
        {/if}
        {$post.content}
    </div><!-- /.blog-main -->

    {include file="chunks/sidebar.right.tpl"}
</div><!-- /.row -->
<script src="route/blog/collect/{$post.id}"></script>