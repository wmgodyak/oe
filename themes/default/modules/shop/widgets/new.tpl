{assign var='products' value=$mod->shop->lastProducts()}
{if $products|count}
    <div class="m_goods-multiple-carousel">
        <div class="goods-multiple-carousel__wrap">
            <div class="goods-multiple-slider__name">{$t.shop.last_products}</div>
            <div class="goods-multiple-slider goods-multiple-slider--5">
                {foreach $products as $item}
                    <div class="goods-multiple-slider__item">
                        <div href="{$item.id}" title="{$item.title}" class="goods-multiple-slider__link">
                   <span class="m_product-item">
                       <a  href="{$item.id}"  class="product-item__img-row">
                            <img class="product-item__img" src="{$app->images->cover($item.id, 'psm')}" alt="{$item.title}">
                       </a>

                       {assign var='avRate' value=$mod->comments->getAverageRating($item.id)|ceil}
                       <span class="m_star-rating">
                           <select class="star-rating read-only">
                               {for $i=1;$i<=5; $i++ }
                                   <option {if $avRate == $i}selected{/if} value="{$i}">{$i}</option>
                               {/for}
                           </select>
                       </span>

                       <a  href="{$item.id}"  class="product-item__name">
                           {$item.name}
                       </a>

                       <span class="product-item__price">
                           {$item.price} {$item.symbol}
                       </span>

                       <span class="product-item__bonus">
                           Ваш СМА бонус: <span>+0грн</span>
                       </span>

                       <span class="product-item__activities">

                           <button class="btn sm red  buy-one-click" data-id="{$item.id}">Купити в 1 клік</button>

                           <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$item.id} {if isset($smarty.session.cart[$item.id])}in{/if}" data-id="{$item.id}" data-has-variants="{$item.has_variants}"  data-in="В кошику"></span>

                           <span class="m_hearth-like">
                               <span class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$item.id])}hearth-like__link--liked{/if}" data-id="{$item.id}" data-has-variants="{$item.has_variants}"></span>
                           </span>

                       </span>

                       {*<span class="m_special-offer"></span>*}

                       {*<span class="m_hit"></span>*}
                   </span>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
{/if}