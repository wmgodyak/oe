{function name=renderMainSelect}
    {foreach $items as $item}
        {if $item.isfolder}
            <optgroup label="{$item.name}">
                {call renderSelect items=$item.items parent=$item.name selected=$selected_categories}
            </optgroup>
        {else}
            <option {if $selected==$item.id}selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
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
            <option {if in_array($item.id, $selected_categories)}selected{/if} value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {/if}
    {/foreach}
{/function}

<div class="form-group">
    <label for="main_categories_id" class="col-md-2 control-label">{$t.products.main_category}</label>
    <div class="col-md-10">
        <select name="main_categories_id" id="main_categories_id" class="form-control" required>
            {call renderMainSelect items=$categories selected=$main_categories_id}
        </select>
    </div>
</div>

<div class="form-group">
    <label for="categories" class="col-md-2 control-label">{$t.products.categories}</label>
    <div class="col-md-10">
        <select name="categories[]" multiple id="categories" class="form-control">
            {call renderSelect items=$categories selected=$selected_categories}
        </select>
    </div>
</div>
