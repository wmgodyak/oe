<div class="side__header">
    <span>Підбір за характеристиками</span>
</div>
<form>
    <div class="filter-group">
        <a class="toggle-link" href="#">
            ЦІНА
        </a>
        <div class="filter-group__content">
            <div class="col">
                <div class="input-group">
                    <label class="label" for="minp">Від</label>
                    <input id="minp" name="minp" required value="{$filter.prices.minp}" type="number" onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = ''; if(this.value !== '') submit();">
                </div>
            </div>
            <div class="col">
                <div class="input-group">
                    <label class="label" for="maxp">До</label>
                    <input id="maxp" name="maxp" required type="number" value="{$filter.prices.maxp}" onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = ''; if(this.value !== '') submit();">
                </div>
            </div>
        </div>
    </div>
    {*<pre>{print_r($filter.prices)}</pre>*}
    {foreach $filter.features as $feature}
    <div class="filter-group">
        <a class="toggle-link" href="#">
            {$feature.name}
        </a>
        <div class="filter-group__content">
            <div class="input-group">
                {foreach $feature.values as $val}
                <div class="row">
                    <input id="f_{$val.id}" class="sf-chb" {if $val.active}checked{/if} type="checkbox">
                    <label for="f_{$val.id}" {if $val.active}class="active"{/if}>
                        {if $val.total > 0}
                        <a href="{$val.url}" id="fa-{$val.id}">{$val.name} ({$val.total})</a>
                            {else}
                            {$val.name} ({$val.total})
                        {/if}
                    </label>
                </div>
                {/foreach}
            </div>
        </div>
    </div>
    {/foreach}
    {if $filter.enabled}
    <div class="filter-group reset">
        <a href="{$page.id}">Скинути фільтр</a>
    </div>
    {/if}
</form>