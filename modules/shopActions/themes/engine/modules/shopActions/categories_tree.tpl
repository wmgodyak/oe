<form action="module/run/shopActions/saveCategories" id="sa_cat_form" method="post">
    <div id="sa_cat_tree" style="text-align: left; max-height: 500px; overflow-y: auto;"></div>
    <input type="hidden" name="selected" id="selected_nodes">
    <input type="hidden" name="old" {if !empty($old_categories)}value="{implode(',', $old_categories)}" {/if}>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="content_id" value="{$content_id}">
</form>