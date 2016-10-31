{function name=renderComments}
    <ul class="comments__list {if $offset > 0}child_list{/if}">
        {foreach $items as $item}
            <li class="comment_list">
                <div class="comment_author_avatar">
                    <img src="{if isset($user.avatar) && !empty($user.avatar)}{$user.avatar}{else}{$theme_url}assets/images/populat-post-img-4.jpg{/if}" alt="image">
                </div>
                <div class="comment_content">
                    <div class="comment_info">
                        <h6 class="comment_author">{$item.user.name} {$item.user.surname}<a name="comment-{$item.id}"></a></h6>
                        <span class="comment_date">{date('M d, Y', $item.created)}</span>
                        <span class="comment_time">{date('H:i', $item.created)}</span>
                    </div>
                    <div class="comment_text_wrap">
                        <div class="comment_text"><p>{$item.message}</p></div>
                    </div>
                    <div class="comment_reply"><a href="11" class="btn"><i class="fa fa-reply"></i> Reply</a></div>
                </div>
                {if $item.isfolder}
                    {call renderComments items=$item.items offset=$offset+1}
                {/if}
            </li>
        {/foreach}
    </ul>
    <div class="clearfix"></div>
{/function}
{call renderComments items=$comments.items offset=0}