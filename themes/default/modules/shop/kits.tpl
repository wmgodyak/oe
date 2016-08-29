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
                    <div class="img" style="background-image: url('{$product.image}');"></div>
                </div>
                <div class="name">{$product.name}</div>
                <div class="price-row">
                    <div class="price">{$product.price} грн.</div>
                </div>
            </div>
            {foreach $kit.products as $item}
            <div class="item item2">
                <div class="img-block">
                    <div class="img" style="background-image: url('{$item.img}');"></div>
                </div>
                <div class="name">{$item.name}</div>
                <div class="price-row">
                    <div class="old-price">{$item.original_price} грн</div>
                    <div class="price">{$item.price} грн</div>
                </div>
            </div>
            {/foreach}
            <div class="equals">
                <div class="row">
                    <div class="new-price">
                        {$kit.amount} грн
                    </div>
                </div>
                <div class="row">
                    <div class="old-price">
                        {$kit.original_amount} грн
                    </div>
                </div>
            </div>
        </div>
        <div class="result-block">
            <div class="wrap">
                <span>Ви економите {$kit.save_amount} грн.</span>
                <div class="text">
                    Замовляйте комплекти
                    та платіть дешевше
                </div>
                <div class="btn-row">
                    <button class="btn md red">Купити комплект</button>
                </div>
            </div>
        </div>
    </div>
        <div class=""><br></div>
    {/foreach}
</div>
{/if}