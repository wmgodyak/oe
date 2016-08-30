{function name=renderSimilarSelect}
    {foreach $items as $item}
        {if $item.isfolder}
            <optgroup label="{$item.name}">
                {call renderSelect items=$item.items parent=$item.name selected=$selected_categories}
            </optgroup>
        {else}
            <option {if in_array($item.id, $selected_similar)}selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {/if}
    {/foreach}
{/function}
<fieldset>
    <legend>Схожі товари</legend>
    <div class="form-group">
        <label for="categories" class="col-md-3 control-label">Виберіть властивості</label>
        <div class="col-md-9">
            <select name="similar_products[]" multiple id="similar_products" class="form-control">
                {call renderSimilarSelect items=$features selected=$selected_similar}
            </select>
            <p class="help-block">Виберіть властивості, на основі яких будуть відображатись схожі товари</p>
        </div>
    </div>
</fieldset>
{literal}
<script>
    $(document).ready(function(){
        $('#similar_products').select2();
    });
</script>
{/literal}