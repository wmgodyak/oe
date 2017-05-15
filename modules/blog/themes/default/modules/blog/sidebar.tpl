<div class="sidebar-module-container">
    <div class="search-area outer-bottom-small">
        <form action="{$blog.id}">
            <div class="control-group">
                <input value="{$smarty.get.q}" name="q" required placeholder="Type to search" class="search-field">
                <a href="javascript:;" class="search-button"></a>
            </div>
        </form>
    </div>
    <div class="sidebar-widget outer-bottom-xs wow fadeInUp">
        <h3 class="section-title">Category</h3>
        <div class="sidebar-widget-body m-t-10">
            <div class="accordion">
                <div class="accordion-group">
                    {foreach $app->module->blog->categories($blog.id) as $k=> $item}
                        <div class="accordion-heading">
                            <a class="accordion-toggle" href="{$item.id}" title="{$item.title}">{$item.name}</a>
                        </div>
                    {/foreach}
                </div><!-- /.accordion-group -->
            </div><!-- /.accordion -->
        </div><!-- /.sidebar-widget-body -->
    </div><!-- /.sidebar-widget -->
    {include file="modules/blog/popular.tpl" cache_id="blog_popual_posts_`{$page.languages_id}`"}
    {include file="modules/blog/tags.tpl" cache_id="blog_tags"}

</div>