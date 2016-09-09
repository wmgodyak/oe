<form action="module/run/productsSimilar/process/{$products_id}" method="post" id="productsSimilarForm" class="form-horizontal">
    <div class="form-group">
        <div class="col-md-12">
            <select name="features[]" multiple class="form-control s-similar-features" required data-placeholder="Виберіть властивості">
                {foreach $features as $item}
                    <option value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>