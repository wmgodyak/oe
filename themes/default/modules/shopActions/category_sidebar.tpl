{if $items|count}
    <div class="actions-sidebar">
    {foreach $items as $item}
        <div class="item" style="margin-bottom: 10px;;">
            <a target="_blank" href="{$item.url}">
                <img src="{$item.image}" alt="{$item.name}">
            </a>
        </div>
    {/foreach}
    </div>
{/if}