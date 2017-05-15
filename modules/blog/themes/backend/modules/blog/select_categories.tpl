{function name=renderSelect}
    {foreach $categories->get($parent_id) as $category}
        {if $category.isfolder}
            <optgroup label="{$category.name}">
                {call renderSelect categories=$categories parent_id=$category.id parent=$category.name selected=$selected_categories}
            </optgroup>
        {else}
            <option {if in_array($category.id, $selected_categories)}selected{/if} value="{$category.id}">{if $parent}{$parent} / {/if}{$category.name}</option>
        {/if}
    {/foreach}
{/function}
<div class="form-group">
    <label for="content_published" class="col-md-3 control-label">{$t.common.categories}</label>
    <div class="col-md-9">
        <select name="categories[]" multiple id="categories" class="form-control" required>
            {call renderSelect categories=$categories parent_id=0 selected=$selected_categories parent=''}
        </select>
    </div>
</div>
