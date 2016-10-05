<fieldset>
    <form action="module/run/shop/products{if $categories_id > 0}/index/{$categories_id}{/if}" class="row-filter">
        <div class="row">

        <div class="form-group">
            <label for="sku">Артикул</label>
            <input name="sku" id="sku" class="form-control" value="{$smarty.get.sku}">
        </div>
        <div class="form-group wrap-price">
            <label for="minp" >Ціна</label><br>
            <input name="minp" id="minp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=0" placeholder="від" value="{$smarty.get.minp}">
            <input name="maxp" id="maxp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=''" placeholder="до" value="{$smarty.get.maxp}">
        </div>
        <div class="form-group">
            <label for="minp" >Валюта</label>
            <select name="currency_id" id="currency_id">
                {foreach $currency as $c}
                    <option {if $smarty.get.currency_id == $c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                {/foreach}
            </select>
        </div>
        <div class="form-group">
            <label for="minp" >Група</label>
            <select name="group_id" id="group_id">
                {foreach $groups as $group}
                    <option {if $smarty.get.group_id == $group.id}{/if} value="{$group.id}">{$group.name}</option>
                {/foreach}
            </select>
        </div>
        <div class="form-group">
            <label for="status">Додатково</label>
            <select name="extra" id="extra" class="form-control">
                <option value="">Виберіть</option>
                <option value="published" {if $smarty.get.extra == 'published'}selected{/if}>Опубліковані</option>
                <option value="hidden" {if $smarty.get.extra == 'hidden'}selected{/if}>Приховані</option>
                <option value="noimage" {if $smarty.get.extra == 'noimage'}selected{/if}>Без фото</option>
                <option value="vsimage" {if $smarty.get.extra == 'vsimage'}selected{/if}>З фото</option>
                <option value="nocat" {if $smarty.get.extra == 'nocat'}selected{/if}>Без кат.</option>
                {*<option value="in_stock_1" {if $smarty.get.extra == 'in_stock_1'}selected{/if}>В наявності</option>*}
                {*<option value="in_stock_2" {if $smarty.get.extra == 'in_stock_2'}selected{/if}>Під зам.</option>*}
                {*<option value="in_stock_0" {if $smarty.get.extra == 'in_stock_0'}selected{/if}>Немає в наявн.</option>*}
            </select>
        </div>
        {if $features|count}
            {foreach $features as $feature}
                <div class="form-group">
                    <label for="f{$feature.id}">{$feature.name}</label>
                    <select name="f[{$feature.id}][]" id="f{$feature.id}" multiple>
                        {foreach $feature.values as $v}
                            <option {if isset($smarty.get.f) && in_array($v.id, $smarty.get.f[$feature.id])}selected{/if} value="{$v.id}">{$v.name}</option>
                        {/foreach}
                    </select>
                </div>
            {/foreach}
        {/if}

        <div class="form-group btn-group">
            <button class="btn btn-primary" type="submit">Фільтр</button>
            <a href="module/run/shop/products{if $categories_id > 0}/index/{$categories_id}{/if}" class="btn" type="reset">Скинути</a>
        </div>
    </div>
        <div class="row">
            <div class="form-group">
                <label for="status">Наявність</label>
                <select name="in_stock" id="in_stock" class="form-control">
                    <option value="">Виберіть</option>
                    <option value="1" {if $smarty.get.in_stock == '1'}selected{/if}>В наявності</option>
                    <option value="2" {if $smarty.get.in_stock == '2'}selected{/if}>Під зам.</option>
                    <option value="0" {if $smarty.get.in_stock == '0'}selected{/if}>Немає в наявн.</option>
                </select>
            </div>
        </div>
    </form>
</fieldset>