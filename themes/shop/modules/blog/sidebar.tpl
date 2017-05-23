<div class="sidebar-blog">
    {include file="modules/blog/categories.tpl" cache_lifetime="3600" cache_id="blog_categories_sb_{$page.languages_id}"}
    {include file="modules/blog/popular.tpl" cache_lifetime="3600" cache_id="blog_popular_sb_{$page.languages_id}"}
    {include file="modules/blog/tags.tpl" cache_lifetime="3600" cache_id="blog_tags_sb_{$page.languages_id}"}
</div>