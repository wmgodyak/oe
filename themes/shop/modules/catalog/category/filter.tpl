<div id="layered-filter-block" class="block-sidebar block-filter no-hide">
    <div class="close-filter-products"><i class="fa fa-times" aria-hidden="true"></i></div>
    <div class="block-title">
        <strong>SHOP BY</strong>
    </div>
    <div class="block-content">
        <form action="">
        <!-- filter price -->
        <div class="filter-options-item filter-options-price">
            <div class="filter-options-title">Price</div>
            <div class="filter-options-content">
                {*{d($category.filter)}*}
                <div class="slider-range">
                    <div class="action">
                        <span class="price">
                            <input id="amount-left" name="minp" style="width: 30%;" required onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = '';">
                            <input id="amount-right" name="maxp" style="width: 30%;" required onchange="this.value = parseFloat(this.value); if (this.value == 'NaN') this.value = ''; ">
                        </span>

                        <button class="btn default"><span>Search</span></button>
                    </div>
                    <div id="slider-range" ></div>
                    <span class="amount-min">{$currency.symbol} {$category.filter.minp}</span>
                    <span class="amount-max">{$currency.symbol} {$category.filter.maxp}</span>
                </div>
            </div>
        </div><!-- filter price -->

            {foreach $category.filter.features as $feature}
        <!-- filter Manufacture-->
        <div class="filter-options-item filter-options-manufacture">
            <div class="filter-options-title">{$feature.name}</div>
            <div class="filter-options-content">
                <ol class="items">
                    {foreach $feature.values as $value}
                    <li class="item ">
                        <label>
                            <a href="{$value.url}">{$value.name}</a>
                        </label>
                    </li>
                    {/foreach}
                </ol>
            </div>
        </div><!-- Filter Item -->
        {/foreach}
        <!-- filter color-->
        <div class="filter-options-item filter-options-color">
            <div class="filter-options-title">COLOR</div>
            <div class="filter-options-content">
                <ol class="items">
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="img" style="background-color: #fca53c;"></span>
                                                        <span class="count">(30)</span>
                                                    </span>

                        </label>
                    </li>
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="img" style="background-color: #6b5a5c;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                        </label>
                    </li>
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="img" style="background-color: #000000;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                        </label>
                    </li>
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="img" style="background-color: #3063f2;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                        </label>
                    </li>
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="text" >CYal</span>
                                                        <span class="count">(20)</span>
                                                    </span>

                        </label>
                    </li>
                    <li class="item">
                        <label>
                            <input type="checkbox">
                            <span>
                                                        <span class="img" style="background-color: #f9334a;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                        </label>
                    </li>


                </ol>
            </div>
        </div><!-- Filter Item -->
        </form>
    </div>
</div>