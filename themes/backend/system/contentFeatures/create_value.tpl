<form action="contentFeatures/createValue" method="post" id="formContentFeaturesValues" class="form-horizontal" >
    {foreach $languages->get() as $lang}
        <div class="form-group">
            <label for="f_info_{$lang.id}" class="col-sm-3 control-label">{$t.features.value} ({$lang.code})</label>
            <div class="col-sm-9">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="f_info_{$lang.id}"  class="form-control f-info-name" data-lang="{$lang.code}">
            </div>
        </div>
    {/foreach}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[status]" value="published">
    <input type="hidden" name="data[type]" value="value">
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
    <input type="hidden" name="action" value="create">
</form>