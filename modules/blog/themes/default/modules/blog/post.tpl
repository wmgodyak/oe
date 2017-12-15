<div class="col-sm-6 post-item">
    <div class="post-item-info">
        {assign var='img' value=$app->module->images->cover($post.id, 'post')}
        {if !empty($img)}
            <div class="post-item-photo">
                <a href="{$post.url}" title="{$post.title}">
                    <img class="img-responsive" src="{$img}" alt="{$post.title}">
                </a>
            </div>
        {/if}
        <div class="post-item-detail">
            <strong class="post-item-name">
                <a href="{$post.url}" title="{$post.title}">{$post.name}</a>
            </strong>
            <div class="post-item-athur">
               By <a href="{$app->page->url($blog.id)}/author/{$post.author.id}">{$post.author.name}</a>, on {date('d M, Y', $post.published)}
            </div>

            {$post.intro}
        </div>
    </div>
</div>