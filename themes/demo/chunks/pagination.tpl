{*<pre>{print_r($pagination)}</pre>*}
{if $pagination.pages|count > 1 }
    <div class="pagination">
        <ul>
            {if $pagination.prev !=''}
                <li><a class="nav-prev" href="{$pagination.prev.url}">&laquo;</a></li>
            {/if}
            {foreach $pagination.pages as $item}
                <li class="{$item.class}"><a  {if $item.url}href="{$item.url}"{/if}>{$item.name}</a></li>
            {/foreach}
            {if $pagination.next != ''}
                <li><a class="nav-next" href="{$pagination.next.url}">&raquo;</a></li>
            {/if}
        </ul>
    </div>
{/if}