<fieldset>
    <form action="module/run/catalog/products{if $categories_id > 0}/index/{$categories_id}{/if}" >{* class="row-filter" *}
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="sku">SKU</label>
                    <input name="sku" id="sku" class="form-control" value="{$smarty.get.sku}">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group wrap-price">
                    <label for="minp" >Price</label><br>
                    <input style="width: 40%;" name="minp" id="minp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=0" placeholder="від" value="{$smarty.get.minp}">
                    <input style="width: 40%" name="maxp" id="maxp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=''" placeholder="до" value="{$smarty.get.maxp}">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="minp" >Currency</label>
                    <select name="currency_id" id="currency_id">
                        {foreach $currency as $c}
                            <option {if $smarty.get.currency_id == $c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="minp" >Group</label>
                    <select name="group_id" id="group_id">
                        {foreach $groups as $group}
                            <option {if $smarty.get.group_id == $group.id}{/if} value="{$group.id}">{$group.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>
        {if $features|count}
            <div class="row">
                {foreach $features as $feature}
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="f{$feature.id}">{$feature.name}</label>
                            <select name="f[{$feature.id}][]" id="f{$feature.id}" multiple>
                                {foreach $feature.values as $v}
                                    <option {if isset($smarty.get.f[$feature.id]) && in_array($v.id, $smarty.get.f[$feature.id])}selected{/if} value="{$v.id}">{$v.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                {/foreach}
            </div>
        {/if}
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <label for="status">Availability</label>
                    <select name="in_stock" id="in_stock" class="form-control">
                        <option value="">Select</option>
                        <option value="1" {if $smarty.get.in_stock == '1'}selected{/if}>In</option>
                        <option value="2" {if $smarty.get.in_stock == '2'}selected{/if}>Under the order</option>
                        <option value="0" {if $smarty.get.in_stock == '0'}selected{/if}>none</option>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="status">Extra</label>
                    <select name="extra[]" multiple id="extra" class="form-control">
                        <option value="published" {if isset($smarty.get.extra) && in_array('published', $smarty.get.extra)}selected{/if}>Published</option>
                        <option value="hidden" {if isset($smarty.get.extra) && in_array('hidden', $smarty.get.extra)}selected{/if}>hidden</option>
                        <option value="noimage" {if isset($smarty.get.extra) && in_array('noimage', $smarty.get.extra)}selected{/if}>Without a photo</option>
                        <option value="vsimage" {if isset($smarty.get.extra) && in_array('vsimage', $smarty.get.extra)}selected{/if}>With photo</option>
                        <option value="nocat" {if isset($smarty.get.extra) && in_array('nocat', $smarty.get.extra)}selected{/if}>Without category</option>
                        <option value="hit" {if isset($smarty.get.extra) && in_array('hit', $smarty.get.extra)}selected{/if}>Bestseller</option>
                        <option value="bestseller" {if isset($smarty.get.extra) && in_array('bestseller', $smarty.get.extra)}selected{/if}>Best price</option>
                    </select>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group btn-group" style="padding-top: 20px;">
                    <button class="btn btn-primary" type="submit">Go</button>
                    <a href="module/run/catalog/products{if $categories_id > 0}/index/{$categories_id}{/if}" class="btn" type="reset">Reset</a>
                </div>
            </div>
        </div>
    </form>
</fieldset>