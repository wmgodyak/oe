{function name=renderComments}
    <ul class="comments__list {if $offset > 0}comments__sublist{/if}">
        {foreach $items as $item}
        <li class="comments__item">
            <div class="row clearfix">
                <div class="comments__avatar-block">
                    <div class="comments__avatar-img" style="background-image: url('{$theme_url}/assets/img/user/avatar2.jpg');"></div>
                </div>
                <div class="comments__content">
                    <div class="row clearfix">
                        <div class="comments__name">{$item.user.name} {$item.user.surname}</div>
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
                        <a class="comments__answer comment-reply" href="javascript:void(0);" data-id="{$item.id}">Відповісти</a>
                    </div>
                </div>
            </div>
            {if $item.isfolder}
                {call renderComments items=$item.items offset=$offset+1}
            {/if}
        </li>
        {/foreach}
    </ul>
{/function}
<div class="m_comments">
    <div class="comments__counter">
        <span>{$comments.total} коментарі {if $user.id}<a href="javascript:void(0);" data-id="{$page.id}" class="b-comments-subscribe" data-s="Слідкувати" data-us="Відписатись">Слідкувати</a>{/if}</span>
    </div>
    {include file="modules/comments/form.tpl"}
    {call renderComments items=$comments.items offset=0}
</div>