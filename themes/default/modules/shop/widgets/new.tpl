{*{if !$app->cache->exists('shop.main.new')}*}
{*{$app->cache->begin('shop.main.new', 60*60)}*}
{assign var='products' value=$mod->shop->lastProducts()}
{if $products|count}
    <div class="m_goods-multiple-carousel">
        <div class="goods-multiple-carousel__wrap">
            <div class="goods-multiple-slider__name">{$t.shop.last_products}</div>
            <div class="goods-multiple-slider goods-multiple-slider--5">
                {foreach $products as $item}
                    {$item.new = 1}
                    {include file="modules/shop/widgets/product.tpl"}
                {/foreach}
            </div>
        </div>
    </div>
{/if}
    {*{$app->cache->end()}*}
{*{else}*}
    {*{$app->cache->get('shop.main.new')}*}
{*{/if}*}