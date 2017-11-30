<div class="widget site-sidebar">
    <h2 class="widget-title">Рубрики</h2>
    <ul class="widget-post-category clearfix">
        {foreach $app->module->blog->categories($blog.id) as $cat}
            <li><a href="{$cat.id}" title="{$cat.title}">{$cat.name} <span class="pull-right badge">({$cat.count})</span></a></li>
        {/foreach}
    </ul>
</div>