<div class="block block-tag-blog">
    <div class="block-title">
        {t('blog.popular_tags')}
    </div>
    <div class="block-content">
        {foreach $app->module->blog->tags(12) as $tag}
            <a href="{$app->page->url($blog.id)}/tag/{$tag.tag}" title="{$tag.tag}">{$tag.tag}</a>
        {/foreach}
    </div>
</div>