{*<pre>{print_r($pagination)}</pre>*}
{*

{if $pagination.pages|count}
<div class="pages">
    <ul class="pagination">
        {if $pagination.prev !=''}
        <li><a href="{$pagination.prev}">&laquo;</a></li>
        {/if}
        {foreach $pagination.pages as $item}
            <li class="{$item.class}"><a href="{$item.url}">{$item.name}</a></li>
        {/foreach}
        {if $pagination.next != ''}
            <li><a href="{$pagination.next}">&raquo;</a></li>
        {/if}
    </ul>
</div>
{/if}

*}
<div class="m_pagination">
    <ul class="pagination__list">
        <li class="pagination__item pagination__item--active">
            <a href="#" class="pagination__link">
                1
            </a>
        </li>
        <li class="pagination__item">
            <a href="#" class="pagination__link">
                2
            </a>
        </li>
        <li class="pagination__item">
            <a href="#" class="pagination__link">
                3
            </a>
        </li>
        <li class="pagination__item pagination__item--dots">
            <a href="javascript:void(0)" class="pagination__link">
                ...
            </a>
        </li>
        <li class="pagination__item">
            <a href="#" class="pagination__link">
                10
            </a>
        </li>
    </ul>
</div>