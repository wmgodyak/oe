<form action="module/run/shop/categories/features/{$action}" method="post" id="formContentFeatures" class="form-horizontal" >
    {foreach $languages as $lang}
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
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[type]"  value="select">
                    <input type="checkbox" name="data[type]" id="data_folder" value="folder" {if isset($data.folder) && $data.folder == 1}checked{/if}> Група
                </label>
            </div>
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
                    <input type="checkbox" name="data[hide]" id="data_hide" value="1" {if isset($data.hide) && $data.hide == 1}checked{/if}> {$t.features.hide}
                </label>
            </div>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
    <input type="hidden" name="content_id" value="{$content_id}">
    {if isset($data.id)}
        <input type="hidden" name="id" value="{$data.id}">
    {/if}
</form>