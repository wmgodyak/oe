<form action="features/values/process" method="post" id="formFeaturesValue" class="form-horizontal">
    {foreach $languages->get() as $lang}
        <div class="form-group">
            <label for="name_{$lang.id}" class="col-sm-3 control-label">{$t.features.name} ({$lang.code})</label>
            <div class="col-sm-9">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="info_{$lang.id}"  class="form-control info-name" value="{if isset($data.info[$lang.id].name)}{$data.info[$lang.id].name}{/if}">
            </div>
        </div>
    {/foreach}
    {* <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.features.code}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="{$data.code}">
        </div>
    </div> *}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    {if isset($data.id)}
    <input type="hidden" name="id" value="{$data.id}">
    {/if}
    {if isset($data.parent_id)}
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
    {/if}
    <input type="hidden" name="data[type]" value="value">
    <input type="hidden" name="data[status]" value="published">
</form>