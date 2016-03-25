<div class="best-hits">
    <strong>Категорії</strong>
    {foreach $blog.categories as $item}
        <a href="{$item.id}">{$item.name}</a>
        <br>
    {/foreach}
</div>