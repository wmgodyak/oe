{assign var="nav_key" value="shop.main.latest"}
{if !$app->cache->exists($nav_key)}
{$app->cache->begin($nav_key, 60*60)}

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
    {$app->cache->end()}
{else}
    {$app->cache->get($nav_key)}
{/if}