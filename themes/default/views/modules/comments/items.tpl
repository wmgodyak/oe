{if $post.comments.total > 0}
    {*<pre>{print_r($post.comments)}</pre>*}
    {function name=renderComment}

        <div class="com-md-12 col-md-offset-{$offset}">
            <div class="date">
                <div class="day">{$item.pubdate} {$item.user.name} {$item.user.surname}</div>
                <p class="ok">
                    {$item.message}
                </p>
                <p><button class="btn btn-link comment-reply" data-parent="{$item.id}">Reply</button></p>
            </div>
            {if $item.isfolder}
                    {foreach $item.items as $c}
                        {call renderComment item=$c offset=$offset+1}
                    {/foreach}
            {/if}
        </div>
    {/function}
<div class="row">
    <div class="col-md-12">
        <div class="messages">
            <h3>Messages</h3>
            <div class="com-md-12">
                {foreach $post.comments.items as $item}
                    {call renderComment item=$item offset=0}
                {/foreach}
            </div>
        </div>
    </div>
</div>
{/if}