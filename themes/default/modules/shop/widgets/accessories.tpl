{*{if !$app->cache->exists('shop.main.actions')}*}
{*{$app->cache->begin('shop.main.actions', 60*60)}*}
{assign var='products' value=$mod->shop->accessories($product.id)}
{if $products|count}
<div class="m_goods-multiple-carousel" style="padding: 0 0 40px 0">
    <div class="goods-multiple-carousel__wrap">
        <div class="goods-multiple-slider__name">{$t.shop.accessories}</div>
        <div class="goods-multiple-slider goods-multiple-slider--5">
            {foreach $products as $item}
                {include file="modules/shop/widgets/product.tpl"}
            {/foreach}
        </div>
    </div>
</div>
{/if}
    {*{$app->cache->end()}*}
{*{else}*}
    {*{$app->cache->get('shop.main.actions')}*}
{*{/if}*}