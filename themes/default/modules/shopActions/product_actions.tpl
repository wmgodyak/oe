{if $items|count}
    <div class="m_products-actions">
        <div class="m_goods-multiple-carousel">
            <div class="goods-multiple-carousel__wrap">
                <div class="goods-multiple-slider__name">Акції</div>
                <div class="goods-multiple-slider products-actions-slider">
                    {foreach $items as $item}
                        <div class="item {if $item.counter}have-counter{/if}">
                            <div class="title" title="{$item.name}"><nobr><a target="_blank" href="{$item.url}">{$item.name}</a></nobr></div>
                            <div>
                                <div class="banner">
                                    <a target="_blank" href="{$item.url}">
                                        <img src="{$item.image}" alt="{$item.name}">
                                    </a>
                                </div>
                                {if $item.counter}
                                    <div class="counter">
                                        <div class="title">
                                            Залишилось:
                                        </div>
                                        <div class="timer"  data-expired="{$item.expired}"></div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
    {*<div class="product-actions">*}
        {*<div class="slider">*}
            {*{foreach $items as $item}*}
                {*<div class="item" style="margin-bottom: 10px;;">*}
                    {*<a target="_blank" href="{$item.url}">*}
                        {*<img src="{$item.image}" alt="{$item.name}">*}
                    {*</a>*}
                {*</div>*}
            {*{/foreach}*}
        {*</div>*}
    {*</div>*}
{/if}