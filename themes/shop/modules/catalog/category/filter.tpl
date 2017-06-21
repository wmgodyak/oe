<div id="layered-filter-block" class="block-sidebar block-filter no-hide">
    <div class="close-filter-products"><i class="fa fa-times" aria-hidden="true"></i></div>
    <div class="block-title">
        <strong>SHOP BY</strong>
    </div>
    <div class="block-content">
        {*{d($filter->selectedFeatures())}*}
        {*{assign var='selected' value=$filter->selectedFeatures()}*}
        {*{if $selected|count}*}
            {*<h3>Selected features</h3>*}
            {*<ul>*}
                {*{foreach $selected as $item}*}
                    {*<li><a href="{$category.id}{$item.url}">{$item.name}</a></li>*}
                {*{/foreach}*}
            {*</ul>*}

        {*{/if}*}
        <form action="{$filter_url}">
        <!-- filter price -->
        <div class="filter-options-item filter-options-price">
            <div class="filter-options-title">Price</div>
            <div class="filter-options-content">
                <div class="slider-range">
                    <div class="action">
                        <span class="price">
                            <input id="amount-left" name="minp" style="width: 30%;" required onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = '';">
                            <input id="amount-right" name="maxp" style="width: 30%;" required onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = ''; ">
                        </span>

                        <button class="btn default"><span>Search</span></button>
                        <a class="btn default" href="{$page.id}"><span>Reset</span></a>
                    </div>
                    <div id="slider-range" ></div>
                    <span class="amount-min">{$currency.symbol} {$filter->minPrice()}</span>
                    <span class="amount-max">{$currency.symbol} {$filter->maxPrice()}</span>
                </div>
            </div>
        </div><!-- filter price -->

            {foreach $filter->features() as $feature}
        <!-- filter Manufacture-->
        <div class="filter-options-item filter-options-manufacture" data-id="{$feature.id}">
            <div class="filter-options-title">{$feature.name}</div>
            <div class="filter-options-content">
                <ol class="items">
                    {foreach $feature.values as $value}
                    <li class="item ">
                        <label {if $value.active}class="active"{/if} data-id="{$value.id}">
                            <a {if $value.active} style="color:red" {/if} href="{$value.url}">{$value.name} ({$value.total})</a>
                        </label>
                    </li>
                    {/foreach}
                </ol>
            </div>
        </div><!-- Filter Item -->
        {/foreach}

        <div class="filter-options-item filter-options-manufacture">
            <div class="filter-options-title">Manufacturers</div>
            <div class="filter-options-content">
                <ol class="items">
                    {foreach $filter->manufacturers() as $m}
                        <li class="item ">
                            <label {if $m.active}class="active"{/if} data-id="{$m.id}">
                                <a {if $m.active} style="color:red" {/if} href="{$m.url}">{$m.name} ({$m.total})</a>
                            </label>
                        </li>
                    {/foreach}
                </ol>
            </div>
        </div>
        </form>
    </div>
</div>