{function name=renderComment}
    <div class="col-md-{(12 - $offset)} col-md-offset-{$offset}">
        <p><small>Додано: {$item.created}</small></p>
        <p>{$item.message}</p>
        <p><small>Автор: {$item.user.name} {$item.user.surname}</small></p>
        <hr>
    </div>
    {if $item.isfolder}
        {foreach $item.items as $c}
            {call renderComment item=$c offset=$offset+1}
        {/foreach}
    {/if}
{/function}

{if $comments|count}
    <fieldset>
        <legend>Коментарі ({$comments_total})</legend>

        <div class="row">
            {foreach $comments as $item}
                {call renderComment item=$item offset=0}
            {/foreach}
        </div>
    </fieldset>
{/if}