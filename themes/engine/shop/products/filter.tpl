<fieldset>
    <form action="module/run/shop/products{if $categories_id > 0}/index/{$categories_id}{/if}">
        <div class="row">
            <div class="col-md-2">
                <div class="form-group">
                    <label for="sku">Артикул</label>
                    <input name="sku" id="sku" class="form-control" value="{$smarty.get.sku}">
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="minp" >Ціна</label>
                    <div class="row">
                        <div class="col-md-6"><input name="minp" id="minp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=0" placeholder="від" value="{$smarty.get.minp}"></div>
                        <div class="col-md-6"><input name="maxp" id="maxp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=''" placeholder="до" value="{$smarty.get.maxp}"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label for="minp" >Валюта</label>
                    <select name="currency_id" id="currency_id">
                        {foreach $currency as $c}
                            <option {if $smarty.get.currency_id == $c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <label for="minp" >Група</label>
                    <select name="group_id" id="group_id">
                        {foreach $groups as $group}
                            <option {if $smarty.get.group_id == $group.id}{/if} value="{$group.id}">{$group.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            <div class="col-md-2">
                <div class="form-group">
                    <label for="status">Статус</label>
                    <select name="status" id="status" class="form-control">
                        <option value="">Всі</option>
                        <option value="published" {if $smarty.get.status == 'published'}selected{/if}>Опубліковані</option>
                        <option value="hidden" {if $smarty.get.status == 'hidden'}selected{/if}>Приховані</option>
                    </select>
                </div>
            </div>
        </div>
        {if $features|count}
            <div class="row">
                {foreach $features as $feature}
                    <div class="col-md-2">
                        <label for="f{$feature.id}">{$feature.name}</label>
                        <select name="f[{$feature.id}][]" id="f{$feature.id}" multiple>
                            {foreach $feature.values as $v}
                                <option {if in_array($v.id, $smarty.get.f[$feature.id])}selected{/if} value="{$v.id}">{$v.name}</option>
                            {/foreach}
                        </select>
                    </div>
                {/foreach}
            </div>
        {/if}
        <div class="row">
            <div class="col-md-3 col-md-offset-9">
                <button class="btn btn-primary" type="submit">Фільтр</button>
                <a href="module/run/shop/products{if $categories_id > 0}/index/{$categories_id}{/if}" class="btn" type="reset">Скинути</a>
            </div>
        </div>
    </form>
</fieldset>