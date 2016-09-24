<form action="route/comments/create" method="post" id="commentsForm">
    <div class="row clearfix">
        <div class="comments__avatar-block">
            <div class="comments__avatar-img" style="background-image: url('{if isset($user.avatar) && !empty($user.avatar)}{$user.avatar}{else}{$theme_url}/assets/img/user/avatar1.jpg{/if}');"></div>
        </div>

        <div class="comments__textarea-block input-group">
            {$t.comments.rate}
            <select {if !$user}disabled{/if} id="rate" name="data[rate]">
                {for $i=1;$i<=5; $i++ }
                    <option value="{$i}">{$i}</option>
                {/for}
            </select>
        </div>
        <div class="comments__textarea-block input-group">
            <textarea {if !$user}disabled{/if} id="cMessage" name="data[message]" required placeholder="{$t.comments.message_placeholder}"></textarea>
        </div>
    </div>
    <div class="row clearfix">
        {if !$user}
            <div class="social__sighin">
                <span>{$t.comments.hauth}</span>
                <div class="comments__social">
                    <a class="comments__social-link comments__social-link--vk" href="route/hybridAuth/auth/Vkontakte"></a>
                    <a class="comments__social-link comments__social-link--fb" href="route/hybridAuth/auth/Facebook"></a>
                </div>
            </div>
        {else}
            <div class="social__sighin">
                <div class="comments__social">
                    <p>{$t.comments.welcome}{$user.name}. <a href="route/users/logout">{$t.comments.logout}</a></p>
                </div>
            </div>
        {/if}
        <div class="social__submit">
            <button type="submit" class="btn md disabled-gray">{$t.comments.write}</button>
        </div>
        <input type="hidden" name="data[content_id]" value="{$page.id}">
        <input type="hidden" name="data[parent_id]" id="cParent" value="0">
        <input type="hidden" name="token" value="{$token}">
    </div>
</form>