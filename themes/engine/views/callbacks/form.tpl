<form action="./callbacks/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label class="col-sm-3 control-label">{$t.callbacks.pib}</label>
        <div class="col-md-9">
            {$data.name}, тел:{$data.phone}
        </div>
    </div>
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.callbacks.message}</label>
        <div class="col-md-9">
            {$data.message}
        </div>
    </div>
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.callbacks.comment}</label>
        <div class="col-md-9">
            <textarea name="data[comment]" id="data_comment" class="form-control" style="height: 150px;" placeholder="{$t.callbacks.comment_not_r}"></textarea>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[status]" value="processed">
    <input type="hidden" name="data[manager_id]" value="{$admin.id}">
</form>