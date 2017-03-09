<div class="widget widget_tag_cloud"><h3>Мітки</h3>
    <div class="widget-line"></div>

    <div class="tagcloud">
        {foreach $app->module->blog->popularTags(12) as $tag}
        <a href="{$app->page->url(2)}/tag/{$tag.tag}" class='tag-link-9' title='{$tag.tag}' style='font-size: 11.4054054054pt;'>{$tag.tag}</a>
        {/foreach}
    </div>
</div>