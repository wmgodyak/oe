{*<pre>{print_r($pagination)}</pre>*}
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