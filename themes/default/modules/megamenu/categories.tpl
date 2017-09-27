
<div class="block block-categori-blog">
    <div class="block-title">
        {t('blog.categories')}
    </div>
    <div class="block-content">
        <ul>
            {foreach $app->module->blog->categories($blog.id) as $cat}
                <li><a href="{$cat.id}" title="{$cat.title}">{$cat.name} <span class="count">({$cat.count})</span></a></li>
            {/foreach}
        </ul>
    </div>
</div>