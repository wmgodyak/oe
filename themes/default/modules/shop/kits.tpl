{$kits = $mod->shop->kits($product.id)}
{if $kits|count && $product.in_stock == 1}
<div class="promotion-banner">
    <div class="heading">
        Разом дешевше!
    </div>
    {foreach $kits as $kit}
    <div class="promotion-banner-wrap">
        <div class="content">
            <div class="item item1">
                <div class="img-block">
                    <div class="img" style="background-image: url('{$product.image.path}thumbs/{$product.image.image}');"></div>
                </div>
                <div class="name">{$product.name}</div>
                <div class="price-row">
                    <div class="price">{$product.price}{$smarty.session.currency.symbol}</div>
                </div>
            </div>
            {foreach $kit.products as $item}
            <div class="item item2">
                <div class="img-block">
                    <div class="img" style="background-image: url('{$item.img.path}thumbs/{$item.img.image}');"></div>
                </div>
                <div class="name">{$item.name}</div>
                <div class="price-row">
                    <div class="old-price">{$item.original_price} {$smarty.session.currency.symbol}</div>
                    <div class="price">{$item.price} {$smarty.session.currency.symbol}</div>
                </div>
            </div>
            {/foreach}
            <div class="equals">
                <div class="row">
                    <div class="new-price">
                        {$kit.amount + $product.price} {$smarty.session.currency.symbol}
                    </div>
                </div>
                <div class="row">
                    <div class="old-price">
                        {$kit.original_amount + $product.price} {$smarty.session.currency.symbol}
                    </div>
                </div>
            </div>
            <div class="result-block">
                <div class="wrap">
                    <span>Ви економите {$kit.save_amount}{$smarty.session.currency.symbol}</span>
                    <div class="text">
                        Замовляйте комплекти
                        та платіть дешевше
                    </div>
                    <div class="btn-row">
                        <button class="btn md red to-cart-kit {if isset($smarty.session.cart.kits[$kit.id])}in{/if}" data-id="{$kit.id}" data-in="В кошику">{if isset($smarty.session.cart.kits[$kit.id])}В кошику{else}Купити комплект{/if}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div class=""><br></div>
    {/foreach}
</div>
{/if}