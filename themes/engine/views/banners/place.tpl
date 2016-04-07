<form action="./banners/plProcess/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.banners_places.name}</label>
        <div class="col-sm-9">
            <input name="data[name]" id="data_name"  class="form-control" value="{$data.name}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.banners_places.code}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="{$data.code}" placeholder="[a-z0-9_]+" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_width" class="col-sm-3 control-label">{$t.banners_places.width}</label>
        <div class="col-sm-9">
            <input name="data[width]" id="data_width"  class="form-control" value="{$data.width}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_height" class="col-sm-3 control-label">{$t.banners_places.height}</label>
        <div class="col-sm-9">
            <input name="data[height]" id="data_height"  class="form-control" value="{$data.height}" required>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>