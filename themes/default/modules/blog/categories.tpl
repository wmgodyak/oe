Example:
{foreach $mod->blog->categories($blog.id) as $k=> $item}
    {*<li class="cat-item cat-item-{$k}"><a href="{$item.id}" title="{$item.title}">{$item.name}</a></li>*}
{/foreach}