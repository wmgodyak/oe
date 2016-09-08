{*{if !$app->cache->exists('shop.main.actions')}*}
{*{$app->cache->begin('shop.main.actions', 60*60)}*}
{assign var='products' value=$mod->shop->viewed()}
{if $products|count}
<div class="viewed-products m_goods-multiple-carousel" {if $page.id != 1} style="padding: 0"{/if}>
    <div class="goods-multiple-carousel__wrap">
        <div class="goods-multiple-slider__name">{$t.shop.viewed}</div>
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