<div class="sidebar_widget grid-box widgetbox">
    <h6 class="sidebar-title"><span>Categories</span></h6>
    <div class="psot_categories">
        <ul>
            {foreach $mod->blog->categories(11) as $k=> $item}
            <li><a href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
            {/foreach}
        </ul>
    </div>
</div>