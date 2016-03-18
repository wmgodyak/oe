{function name=renderSelect}
    {foreach $items as $item}
        {if $item.isfolder}
            <optgroup label="{$item.name}">
                {call renderSelect items=$item.items parent=$item.name selected=$selected_categories}
            </optgroup>
        {else}
            <option {if in_array($item.id, $selected_categories)}selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {/if}
    {/foreach}
{/function}

<div class="form-group">
    <label for="content_published" class="col-md-3 control-label">Категорії</label>
    <div class="col-md-9">
        <select name="categories[]" multiple id="categories" class="form-control" required>
            {call renderSelect items=$categories selected=$selected_categories}
        </select>
    </div>
</div>
