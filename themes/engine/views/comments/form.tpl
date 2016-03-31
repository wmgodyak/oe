<form action="./comments/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label class="col-sm-3 control-label">{$t.comments.pib}</label>
        <div class="col-md-9">
            {$data.user.name} {$data.user.surname}
        </div>
    </div>
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.comments.message}</label>
        <div class="col-md-9">
            <textarea name="data[message]" id="data_message" required  class="form-control" style="height: 250px;">{$data.message}</textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.comments.reply_message}</label>
        <div class="col-md-9">
            <textarea name="reply[message]" id="reply_message" class="form-control" style="height: 150px;" placeholder="{$t.comments.reply_message_not_r}"></textarea>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[status]" value="approved">
    <input type="hidden" name="reply[parent_id]" value="{$data.id}">
    <input type="hidden" name="reply[status]" value="approved">
    <input type="hidden" name="reply[content_id]" value="{$data.content_id}">
    <input type="hidden" name="reply[users_id]" value="{$admin.id}">
</form>