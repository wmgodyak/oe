<div class="widget site-sidebar">
    <h2 class="widget-title">Мітки</h2>
    <ul class="widget-recent-tags clearfix">
        {foreach $app->module->blog->tags(12) as $tag}
           <li><a href="{$app->page->url($blog.id)}/tag/{$tag.tag}" title="{$tag.tag}">{$tag.tag}</a></li>
        {/foreach}
    </ul>
</div>