<form action="module/run/shop/products/variants/create/{$content_id}" method="post" id="productsVariantsForm" class="form-horizontal">
    {$t.shop.variants.info}
    <div class="form-group">
        <div class="col-md-12">
            <select name="features[]" multiple class="form-control variants-feature" required data-placeholder="{$t.shop.variants.select_features}">
                {foreach $features as $item}
                    <option value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="add">
</form>