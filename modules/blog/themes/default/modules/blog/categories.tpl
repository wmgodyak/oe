<div class="widget widget_categories">
    <h3>Категорії</h3>
    <div class="widget-line"></div>
    <ul>
        {foreach $mod->blog->categories(2) as $k=> $item}
        <li class="cat-item cat-item-{$k}"><a href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
        {/foreach}
    </ul>
</div>