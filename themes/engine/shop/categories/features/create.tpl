<form action="module/run/shop/categories/features/create" method="post" id="formContentFeatures" class="form-horizontal" >
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="f_info_{$lang.id}" class="col-md-2 control-label">{$t.features.name} ({$lang.code})</label>
            <div class="col-md-10">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="f_info_{$lang.id}"  class="form-control f-info-name" data-lang="{$lang.code}">
            </div>
        </div>
    {/foreach}
    <div class="form-group">
        <label for="f_data_code" class="col-md-2 control-label">{$t.features.code}</label>
        <div class="col-md-10">
            <input name="data[code]" id="f_data_code"  class="form-control">
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[type]"  value="select">
                    <input type="checkbox" name="data[type]" id="data_folder" value="folder"> Група
                </label>
            </div>
        </div>
    </div>

    <div class="form-group fg-required">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[required]" value="0">
                    <input type="checkbox" name="data[required]" value="1"> {$t.common.required}
                </label>
            </div>
        </div>
    </div>

    <div class="form-group fg-multiple">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[multiple]" value="0">
                    <input type="checkbox" name="data[multiple]" id="data_multiple" value="1"> {$t.features.multiple}
                </label>
            </div>
        </div>
    </div>
    <div class="form-group fg-show-filter">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[on_filter]" value="0">
                    <input type="checkbox" name="data[on_filter]" id="data_on_filter" value="1"> {$t.features.on_filter}
                </label>
            </div>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="create">
    <input type="hidden" name="data[status]" value="published">
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
    <input type="hidden" name="content_id" value="{$content_id}">
</form>