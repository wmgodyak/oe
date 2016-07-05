{if $pagination.pages|count}
<div class="m_pagination">
    <ul class="pagination__list">
        {if $pagination.prev !=''}
            <li class="pagination__item"><a class="pagination__link" href="{$pagination.prev}">&laquo;</a></li>
        {/if}
        {foreach $pagination.pages as $item}
            <li class="pagination__item pagination__item--{$item.class}"><a class="pagination__link" href="{$item.url}">{$item.name}</a></li>
        {/foreach}
        <li class="pagination__item ">
            <a href="javascript:void(0)" class="pagination__link">
                ...
            </a>
        </li>
        {if $pagination.next != ''}
            <li class="pagination__item"><a class="pagination__link" href="{$pagination.next}">&raquo;</a></li>
        {/if}
    </ul>
</div>
{/if}