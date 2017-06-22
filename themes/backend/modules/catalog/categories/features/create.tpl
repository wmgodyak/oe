<form action="module/run/catalog/categoriesFeatures/{$action}" method="post" id="formContentFeatures" class="form-horizontal" >
    {foreach $languages->get() as $lang}
        <div class="form-group">
            <label for="f_info_{$lang.id}" class="col-md-2 control-label">{$t.features.name} ({$lang.code})</label>
            <div class="col-md-10">
                <input name="info[{$lang.id}][name]" {if isset($data.info[$lang.id].name)}value="{$data.info[$lang.id].name}" {/if}  placeholder="{$lang.name}" required id="f_info_{$lang.id}"  class="form-control f-info-name" data-lang="{$lang.code}">
            </div>
        </div>
    {/foreach}
    <div class="form-group">
        <label for="f_data_code" class="col-md-2 control-label">{$t.features.code}</label>
        <div class="col-md-10">
            <input name="data[code]" id="f_data_code"  class="form-control" {if isset($data.code)}value="{$data.code}" {/if}>
        </div>
    </div>
    <div class="form-group">
        <label for="f_data_type" class="col-md-2 control-label">{$t.features.type}</label>
        <div class="col-md-10">
            <select name="data[type]" id="cf_data_type" class="form-control" >
                {foreach $types as $k=>$type}
                    {if $type != 'checkbox' &&  $type != 'value'}
                    <option value="{$type}" {if isset($data.type) && $data.type == $type}selected{/if}  {if !isset($data.type) && $type == 'select'}selected{/if}>{$t.features["type_`$type`"]}</option>
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group fg-required">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[required]" value="0">
                    <input type="checkbox" name="data[required]" value="1" {if isset($data.required) && $data.required == 1}checked{/if}> {$t.common.required}
                </label>
            </div>
        </div>
    </div>

    <div class="form-group fg-multiple">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[multiple]" value="0">
                    <input type="checkbox" name="data[multiple]" id="data_multiple" value="1" {if isset($data.multiple) && $data.multiple == 1}checked{/if}> {$t.features.multiple}
                </label>
            </div>
        </div>
    </div>
    <div class="form-group fg-show-filter">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[on_filter]" value="0">
                    <input type="checkbox" name="data[on_filter]" id="data_on_filter" value="1" {if isset($data.on_filter) && $data.on_filter == 1}checked{/if}> {$t.features.on_filter}
                </label>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[hide]" value="0">
                    <input type="checkbox" name="data[hide]" id="data_hide" value="1" {if isset($data.hide) && $data.hide == 1}checked{/if}> {$t.catalog.features.hide}
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[on_list]" value="0">
                    <input type="checkbox" name="data[on_list]" value="1" {if isset($data.on_list) && $data.on_list == 1}checked{/if}> {$t.catalog.features.on_list}
                </label>
            </div>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
    <input type="hidden" name="content_id" value="{$content_id}">
    <input type="hidden" name="data[status]" value="published">
    {if isset($data.id)}
        <input type="hidden" name="id" value="{$data.id}">
    {/if}
</form>