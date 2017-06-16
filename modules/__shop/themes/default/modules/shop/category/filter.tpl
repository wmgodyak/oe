{if $filter.selected|count}
    {*<pre>{print_r($filter.selected)}</pre>*}
<div class="side__header">
    <span>{$t.shop.filter.selected}</span>
</div>
<form>
    <div class="filter-group">
        <div class="filter-group__content">
            {foreach $filter.selected as $item}
                <div class="row">
                    <label>
                        <a title="Прибрати" class="clear-item" href="{$item.url}">{$item.name}</a>
                    </label>
                </div>
            {/foreach}
        </div>
    </div>
    <div class="filter-group reset">
        <a href="{$page.id}">{$t.shop.filter.reset}</a>
    </div>
</form>
{/if}
<div class="side__header">
    <span>{$t.shop.filter.title}</span>
</div>
<form>
    <div class="filter-group">
        <a class="toggle-link" href="javascript:;">
            {$t.shop.filter.price}
        </a>
        <div class="filter-group__content">
            <div class="col">
                <div class="input-group">
                    <label class="label" for="minp">{$t.shop.filter.price_from}</label>
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
        {assign var='display_feature' value="0"}
        {foreach $feature.values as $val}{if $val.total > 0}{$display_feature = 1}{break}{/if}{/foreach}
        {if $display_feature}
            <div class="filter-group">
                <a class="toggle-link" href="javascript:;">
                    {$feature.name}
                </a>
                <div class="filter-group__content">
                    <div class="input-group">
                        {foreach $feature.values as $val}
                            {if $val.total > 0}
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
                            {/if}
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}
    {/foreach}
    {*{if $filter.enabled}*}
    {*<div class="filter-group reset">*}
        {*<a href="{$page.id}">Скинути фільтр</a>*}
    {*</div>*}
    {*{/if}*}
</form>