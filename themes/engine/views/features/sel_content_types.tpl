<form action="features/content/index/{$features_id}" method="post" id="formFeaturesContent" class="form-horizontal">
    <div class="form-group">
        <label for="data_types_id" class="col-md-3 control-label">{$t.features.content_type}</label>
        <div class="col-md-9">
            <select name="content_types_id" id="data_types_id" class="form-control">
                {foreach $types as $item}
                    <option value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_subtypes_id" class="col-md-3 control-label">{$t.features.content_subtype}</label>
        <div class="col-md-9">
            <select name="content_subtypes_id" id="data_subtypes_id" class="form-control" disabled></select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_content_id" class="col-md-3 control-label">{$t.features.content_page}</label>
        <div class="col-md-9">
            <select name="content_id[]" id="data_content_id" class="form-control" multiple disabled></select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="process">
</form>