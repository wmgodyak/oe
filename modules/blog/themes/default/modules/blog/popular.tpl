<div class="block block-recent-post">
    <div class="block-title">
        {t('blog.popular_posts')}
    </div>
    <div class="block-content">
        <ul>
            {foreach $app->module->blog->posts->popular(3) as $post}
                <li class="clearfix">{assign var='img' value=$app->module->images->cover($post.id, 'post')}
                    {if $img}
                        <a href="{$post.url}" class="item-photo">
                            <img class="img-responsive" src="{$img}" alt="">
                        </a>
                    {/if}
                    <div class="item-detail">
                        <a href="{$post.url}" class="item-name">{$post.name}</a>
                        <div class="item-athur">
                            By <a href="{$app->page->url($blog.id)}/author/{$post.author.id}">{$post.author.name}</a>, on {date('d M, Y', $post.published)}
                        </div>
                    </div>
                </li>
            {/foreach}
        </ul>
    </div>
</div>