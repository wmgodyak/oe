<form action="module/run/comments/reply/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label class="col-sm-3 control-label">{$t.comments.pib}</label>
        <div class="col-md-9">
            {$data.user.name} {$data.user.surname}
        </div>
    </div>
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.comments.message}</label>
        <div class="col-md-9">
            <textarea name="data[message]" id="data_message" required  class="form-control" style="height: 250px;"></textarea>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[parent_id]" value="{$data.id}">
    <input type="hidden" name="data[status]" value="approved">
    <input type="hidden" name="data[content_id]" value="{$data.content_id}">
    <input type="hidden" name="data[users_id]" value="{$admin.id}">
    <input type="hidden" name="action" value="process">
</form>