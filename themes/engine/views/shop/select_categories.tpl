{function name=renderSelectMultiple}
    {foreach $items as $item}
        {if $item.isfolder}
            <optgroup label="{$item.name}">
                {call renderSelectMultiple items=$item.items parent=$item.name selected=$selected}
            </optgroup>
        {else}
            <option {if in_array($item.id, $selected)}selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {/if}
    {/foreach}
{/function}
{function name=renderSelect}
    {foreach $items as $item}
        {if $item.isfolder}
            <optgroup label="{$item.name}">
                {call renderSelect items=$item.items parent=$item.name selected=$selected_categories}
            </optgroup>
        {else}
            <option {if $item.id ==$selected }selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {/if}
    {/foreach}
{/function}
<div class="form-group">
    <label for="main_categories_id" class="col-md-3 control-label">{$t.shop.main_category}</label>
    <div class="col-md-9">
        <select name="main_categories_id" id="main_categories_id" class="form-control" required>
            {call renderSelect items=$categories selected=$main_categories_id parent=''}
        </select>
    </div>
</div>

<div class="form-group">
    <label for="categories" class="col-md-3 control-label">{$t.common.categories}</label>
    <div class="col-md-9">
        <select name="categories[]" multiple id="categories" class="form-control" required>
            {call renderSelectMultiple items=$categories selected=$selected_categories parent=''}
        </select>
    </div>
</div>
