<div class="sidebar-widget product-tag wow fadeInUp">
    <h3 class="section-title">Tags</h3>
    <div class="sidebar-widget-body outer-top-xs">
        <div class="tag-list">
            {foreach $app->module->blog->tags(12) as $tag}
                <a href="{$app->page->url($blog.id)}/tag/{$tag.tag}" class='item' title='{$tag.tag}' style='font-size: 11.4054054054pt;'>{$tag.tag}</a>
            {/foreach}
        </div><!-- /.tag-list -->
    </div><!-- /.sidebar-widget-body -->
</div><!-- /.sidebar-widget -->