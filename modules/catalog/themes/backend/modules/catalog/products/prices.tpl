<fieldset>
    <legend>{$t.catalog.prices.index}</legend>
    <div class="form-group">
        <label for="product_code" class="col-md-4 control-label">{$t.catalog.prices.sku}</label>
        <div class="col-md-8">
            <input name="product[sku]" id="product_code" class="form-control" value="{if $product.sku == ''}{$content.id}{else}{$product.sku}{/if}">
        </div>
    </div>
    <div class="form-group">
        <label for="product_units" class="col-md-4 control-label">{$t.catalog.prices.unit}</label>
        <div class="col-md-8">
            <select name="product[unit_id]" id="product_units" class="form-control">
                {foreach $units.items as $unit}
                    <option {if isset($product.unit_id) && $product.unit_id==$unit.id}selected{/if} value="{$unit.id}">{$unit.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="product_in_stock" class="col-md-4 control-label">{$t.catalog.prices.availability}</label>
        <div class="col-md-8">
            <select name="product[in_stock]" id="product_in_stock" class="form-control">
                <option {if $product.in_stock==1}selected{/if} value="1">in stock</option>
                <option {if $product.in_stock==2}selected{/if} value="2">under the order</option>
                <option {if $product.in_stock==0}selected{/if} value="0">none</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="product_in_stock" class="col-md-4 control-label">{$t.catalog.prices.currency}</label>
        <div class="col-md-8">
            <select name="product[currency_id]" id="product_currency" class="form-control">
                {foreach $currency as $c}
                    <option {if $product.currency_id==$c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                {/foreach}
            </select>
        </div>
    </div>
    {foreach $groups as $g}
    <div class="form-group">
        <label for="product_code" class="col-md-4 control-label">{t('catalog.prices.price_per_group')}{$g.name}</label>
        <div class="col-md-8">
            <input type="text" name="prices[{$g.id}]" required class="form-control" onchange="this.value = parseFloat(this.value); if(this.value == 'NaN') this.value = '';" value="{if isset($prices[$g.id])}{$prices[$g.id]}{/if}">
        </div>
    </div>
    {/foreach}
</fieldset>