{if $pagination.pages|count}
<div class="m_pagination">
    <ul class="pagination__list">
        {if $pagination.prev !=''}
            <li class="pagination__item"><a class="pagination__link" href="{$pagination.prev}">&laquo;</a></li>
        {/if}
        {foreach $pagination.pages as $item}
            <li class="pagination__item pagination__item--{$item.class}"><a class="pagination__link" {if $item.url}href="{$item.url}"{/if}>{$item.name}</a></li>
        {/foreach}
        {if $pagination.next != ''}
            <li class="pagination__item"><a class="pagination__link" href="{$pagination.next}">&raquo;</a></li>
        {/if}
    </ul>
</div>
{/if}