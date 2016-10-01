{if $items|count}
    <div class="actions-sidebar">
        <div class="m_discount-widget">
    {foreach $items as $item}
        <div class="discount__heading1"><a style="color: #fff;" target="_blank" href="{$item.url}" title="{$item.title}">{$item.name}</a></div>
        <div style="height: 10px;"></div>
        <div class="item" style="margin-bottom: 10px;;">
            <a target="_blank" href="{$item.url}" title="{$item.title}">
                <img src="{$item.image}" alt="{$item.name}">
            </a>
        </div>
    {/foreach}
        </div>
    </div>
{/if}