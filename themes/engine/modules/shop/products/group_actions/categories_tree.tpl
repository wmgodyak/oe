<form action="module/run/shop/products/groupActions/changeMainCategory/update" id="sp_cat_form" method="post">
    <div id="sp_cat_tree" style="text-align: left; max-height: 500px; overflow-y: auto;"></div>
    <input type="hidden" name="selected" id="selected_nodes">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="is_main" value="{$is_main}">
    {foreach $products as $k=>$product_id}
    <input type="hidden" name="products[]" value="{$product_id}">
    {/foreach}
</form>