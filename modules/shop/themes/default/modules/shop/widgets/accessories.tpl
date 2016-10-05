{assign var="nav_key" value="shop.products.accessories"}
{if !$app->cache->exists($nav_key)}
    {$app->cache->begin($nav_key, 3*60)}
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
    {$app->cache->end()}
{else}
    {$app->cache->get($nav_key)}
{/if}