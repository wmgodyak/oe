{foreach $mod->blog->categories() as $k=> $item}
    <div class="filter-news">
        <a class="btn md {if $page.id == $item.id || ( $page.id == 5 && $k == 0)}red{else}white-red{/if}" href="{$item.id}" title="{$item.title}">{$item.name}</a>
    </div>
{/foreach}