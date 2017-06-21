<li class="{block name='catalog.category.product.class'}col-sm-4 product-item product-item-opt-0{/block}">
    <div class="product-item-info">
        {block name='catalog.category.product'}
            <div class="product-item-photo">
                {block name='catalog.category.product.photo '}
                    {assign var='img' value=$app->images->cover($product->id, 'product')}
                    <a href="{$product->id}" title="{$product->title}" class="product-item-img">
                        <img src="{$img}" alt="product name">
                    </a>
                {/block}
            </div>
            <div class="product-item-detail">
                {block name='catalog.category.product.detail'}
                    <strong class="product-item-name">
                        <a href="{$product->id}" title="{$product->title}">{$product->name}</a>
                    </strong>

                    <div class="product-item-price">
                        {block name='catalog.category.product.price'}
                            <span class="price">{$product->currency.symbol} {$product->price}</span>
                            {if $product->price_old}
                                <span class="price-old">{$product->currency->code}{$product->price_old}</span>
                            {/if}
                        {/block}
                    </div>

                    <div class="product-item-actions">
                        {block name='catalog.category.product.actions'}
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>
                            <a href="javascript:;" class="btn btn-wishlist"><span>wishlist</span></a>
                            <a href="javascript:;" class="btn btn-compare"><span>compare</span></a>
                        {/block}
                    </div>
                {/block}
            </div>
        {/block}
    </div>
</li>