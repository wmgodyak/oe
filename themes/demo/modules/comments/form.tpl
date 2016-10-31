<div class="psot_comment">
<form action="route/comments/create" method="post" id="commentsForm">
    <h3>Leave a <em>Reply</em> </h3>
    <div class="commentform">
            <div class="form-group">
                <textarea {if !$user}disabled{/if} id="cMessage" name="data[message]" required placeholder="{$t.comments.message_placeholder}"></textarea>
            </div>
            {if !$user}
                <div class="social__sighin">
                    <span>{$t.comments.hauth}</span>
                    <div class="comments_social">
                        {$events->call('comments.social.auth')}
                    </div>
                </div>
            {else}
                <div class="social__sighin">
                    <div class="comments__social">
                        <p>{$t.comments.welcome}{$user.name}. <a href="route/users/logout">{$t.comments.logout}</a></p>
                    </div>
                </div>
            {/if}
            <div class="form-group">
                <input type="submit" {if !$user}disabled{/if} value="Post comment" class="submit btn active_btn" id="submit" name="submit">
            </div>

            <input type="hidden" name="data[content_id]" value="{$page.id}">
            <input type="hidden" name="data[parent_id]" id="cParent" value="0">
            <input type="hidden" name="token" value="{$token}">
    </div>
</form>
</div>