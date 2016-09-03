<div class="product__item">
    <span class="product__link">
        <span class="m_product-item">
           <a  href="{$product.id}" title="{$product.title}" class="product-item__img-row">
                <img class="product-item__img" src="{$app->images->cover($product.id, 'psm')}" alt="{$product.title}">
           </a>
            <span class="row float-row clearfix">
                {assign var='avRate' value=$mod->comments->getAverageRating($product.id)}
                <span class="m_star-rating">
                   <select class="star-rating read-only">
                       {for $i=1;$i<=5; $i++ }
                           <option value=""></option>
                           <option {if $avRate == $i}selected{/if} value="{$i}">{$i}</option>
                       {/for}
                   </select>
                </span>
                <span class="product-item__coment-counter">
                    {assign var='ct' value=$mod->comments->getTotal($product.id)}
                    {if $ct > 0}{$ct} відгуків{/if}
                </span>
            </span>

           <a  href="{$product.id}" title="{$product.title}" class="product-item__name">
               {$product.name} {$product.pprice}
           </a>

           <span class="product-item__price">
               <span id="p-price-{$product.id}">{$product.price}</span> {$product.symbol}
           </span>

            <span class="product-item__bonus">
               Ваш СМА бонус: <span>+{$product.bonus} грн</span>
           </span>
            {if $product.has_variants}
                Виберіть варіант:
                <select id="variants_{$product.id}" data-id="{$product.id}" class="product-variant">
                    {foreach $mod->shop->getProductsVariants($product.id) as $variant}
                        <option value="{$variant.id}" data-img="{$variant.img}" data-price="{$variant.price}">{$variant.name}</option>
                    {/foreach}
                </select>
            {/if}
           <span class="product-item__activities">
                {if $product.in_stock == 1}
                   <button class="btn sm red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">Купити в 1 клік</button>
                   <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$product.id} {if isset($smarty.session.cart.products[$product.id])}m_cart-indicator__in{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" title="В кошик"></span>
                {else}
                    <button class="btn sm  to-wait-list" data-has-variants="{$product.has_variants}" data-id="{$product.id}" title="Повідомте про появу">Повідомте</button>
                {/if}

               <span class="m_hearth-like">
                   <span class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$product.id])}hearth-like__link--liked{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" ></span>
               </span>
           </span>
       </span>
    </span>
</div>