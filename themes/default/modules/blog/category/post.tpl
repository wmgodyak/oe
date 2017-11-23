<article class="post single-post">
    <div class="single-post-title">
        <h2><a href="{$post.url}" title="{$post.title}">{$post.name}</a></h2>
        <p class="single-post-meta">
            <i class="fa fa-user"></i>&nbsp; <a href="{$app->page->url($blog.id)}/author/{$post.author.id}">{$post.author.name}</a>
            &nbsp;<i class="fa fa-book"></i>
            &nbsp;
            {if $post.categories|count}
                {foreach $post.categories as $cat}
                    <a href="{$cat.id}" title="{$cat.title}">{$cat.name}</a>
                {/foreach}
            {/if}
            &nbsp;<i class="fa fa-calendar"></i>
            &nbsp;{date('d M, Y', $post.published)}
            &nbsp;<i class="fa fa-eye"></i>
            &nbsp;{$post.views}
        </p>

        {assign var='img' value=$app->images->cover($post.id, 'post')}
        {if !empty($img)}
            <a href="{$post.url}" rel="bookmark" title="{$post.title}">
                <img style="max-width:100%;" alt="{$post.title}" src="{$img}" />
            </a>
        {/if}
        {$post.intro}
    </div>
</article>