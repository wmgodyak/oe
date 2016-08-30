<form action="module/run/shop/products/features/addValue/{$features_id}/{$products_id}"  method="post" id="formProductsFeaturesValues" class="form-horizontal" >
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="f_info_{$lang.id}" class="col-md-2 control-label">{$t.features.name} ({$lang.code})</label>
            <div class="col-md-10">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="f_info_value_{$lang.id}"  class="form-control f-info-value" data-lang="{$lang.code}">
            </div>
        </div>
    {/foreach}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[status]" value="published">
    <input type="hidden" name="data[type]" value="value">
    <input type="hidden" name="data[parent_id]" value="{$features_id}">
</form>