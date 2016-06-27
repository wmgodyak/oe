<div class="row">
    <div class="col-md-8 col-md-offset-2">
<fieldset><legend>{$t.banners_places[$action]}</legend>
<form action="module/run/banners/places/process/{if isset($data.id)}{$data.id}{/if}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.banners_places.name}</label>
        <div class="col-sm-9">
            <input name="data[name]" id="data_name"  class="form-control" value="{if isset($data.name)}{$data.name}{/if}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.banners_places.code}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="{if isset($data.code)}{$data.code}{/if}" placeholder="[a-z0-9_]+" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_width" class="col-sm-3 control-label">{$t.banners_places.width}</label>
        <div class="col-sm-9">
            <input name="data[width]" id="data_width"  class="form-control" value="{if isset($data.width)}{$data.width}{/if}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_height" class="col-sm-3 control-label">{$t.banners_places.height}</label>
        <div class="col-sm-9">
            <input name="data[height]" id="data_height"  class="form-control" value="{if isset($data.height)}{$data.height}{/if}" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-9">
            <button type="submit" class="btn btn-success btn-large" id="bSubmit">Зберегти</button>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>
</fieldset>
    </div>
</div>