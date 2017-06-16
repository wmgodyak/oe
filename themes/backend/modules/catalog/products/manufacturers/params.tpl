<div class="form-group">
    <label for="manufacturers_id" class="col-md-2 control-label">{t('catalog.products.manufacturers')}</label>
    <div class="col-md-10">
        <select required class="form-control" name="product[manufacturers_id]" id="manufacturers_id">
            {foreach $manufacturers as $m}
                <option {if $product.manufacturers_id = $m.id}selected{/if} value="{$m.id}">{$m.name}</option>
            {/foreach}
        </select>
    </div>
</div>