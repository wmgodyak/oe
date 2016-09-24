{function name=renderComments}
    <ul class="comments__list {if $offset > 0}comments__sublist{/if}">
        {foreach $items as $item}
        <li class="comments__item">
            <div class="row clearfix">
                <div class="comments__avatar-block">
                    <div class="comments__avatar-img"
                         style="background-image: url('{if isset($user.avatar) && !empty($user.avatar)}{$user.avatar}{else}{$theme_url}/assets/img/user/avatar1.jpg{/if}');"></div>
                </div>
                <div class="comments__content">
                    <div class="row clearfix">
                        <div class="comments__name">
                            {$item.user.name} {$item.user.surname}
                            <span class="m_star-rating">
                               <select class="star-rating read-only">
                                   {for $i=1;$i<=5; $i++ }
                                   <option {if $item.rate == $i}selected{/if} value="{$i}">{$i}</option>
                                   {/for}
                               </select>
                           </span>
                        </div>
                        <div class="comments__date">{date('d.m.Y H:i', $item.created)}</div>
                    </div>
                    <div class="row">
                        <div class="comments__text">{$item.message}</div>
                    </div>
                    <div class="row">
                        <div class="comments__like-dislike">
                            <a class="comments__like comment-like" href="javascript:void(0);" data-id="{$item.skey}">{$item.likes}</a>
                            <a class="comments__dislike comment-dislike" href="javascript:void(0);" data-id="{$item.skey}">{$item.dislikes}</a>
                        </div>
                        {if isset($user.id)}
                        <a class="comments__answer comment-reply" href="javascript:void(0);" data-id="{$item.id}">{$t.comemnts.reply}</a>
                        {/if}
                    </div>
                </div>
            </div>
            <div class="clearfix"><br></div>
            {if $item.isfolder}
                {call renderComments items=$item.items offset=$offset+1}
            {/if}
        </li>
        {/foreach}
    </ul>
    <div class="clearfix"></div>
{/function}
<div class="m_comments">
    <div class="comments__counter">
        <span>{sprintf($t.comments.totalc,$comments.total)} {if $user.id}<a href="javascript:void(0);" data-id="{$page.id}" class="b-comments-subscribe" data-s="Слідкувати" data-us="Відписатись">Слідкувати</a>{/if}</span>
    </div>
    {include file="modules/comments/form.tpl"}
    {call renderComments items=$comments.items offset=0}
    {*<pre>{print_r($comments)}</pre>*}
</div>