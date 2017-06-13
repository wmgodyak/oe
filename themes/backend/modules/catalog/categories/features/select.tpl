<form action="module/run/catalog/categories/features/select/{$content_id}" method="post" id="formContentFeatures" class="form-horizontal" >
   <div class="form-group">
        <label for="data_type" class="col-md-2 control-label">{$t.features.type}</label>
        <div class="col-md-10">
            <select name="categories_features[]" id="categories_features" required multiple class="form-control">
                {foreach $features as $item}
                    <option {$item.selected} value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="create">
</form>