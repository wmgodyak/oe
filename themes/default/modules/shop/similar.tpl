{assign var='similar' value=$mod->shop->products->similar($product)}
{if $similar|count > 1}
    {assign var='similar' value=array_chunk($similar, 3)}
    <div class="m_products-similar">
    <div class="m_goods-multiple-carousel">
    <div class="goods-multiple-carousel__wrap">
        <div class="goods-multiple-slider__name">Доступні інші варіанти:</div>
        <div class="goods-multiple-slider products-actions-slider">
            {foreach $similar as $a}
                {foreach $a as $item}
                    <a class="item {if $item.id==$product.id}active{/if}" href="{$item.id}" title="{$item.name}">
                        <img src="{$app->images->cover($item.id, 'thumbs')}" style="height:65px;" alt="">
                        <span>{$item.name}</span>
                    </a>
                {/foreach}
            {/foreach}
        </div>
    </div>
    </div>
    </div>
{/if}