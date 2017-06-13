{assign var='products' value=$mod->shop->viewed()}
{if $products|count}
<div class="viewed-products m_goods-multiple-carousel" {if $page.id != 1} style="padding:0 0 0 15px"{/if}>
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