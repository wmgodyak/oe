{*<pre>{print_r($user)}</pre>*}
<form role="form" action="ajax/comments/create" method="post" class="comments-reply-form" id="commentsCreate">
    <div class="response"></div>
    <div class="form-group">
        <label for="message">Message</label>
        <textarea class="form-control" name="data[message]" cols="30" rows="10" required></textarea>
    </div>
    <div class="submit">
        <button type="submit" class="button-clear">
            <span>Add</span>
        </button>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[content_id]" value="{$post.id}">
    <input type="hidden" name="data[parent_id]" value="0" id="commentsParentId">
    <input type="hidden" name="post_name" value="{$post.name}">
</form>