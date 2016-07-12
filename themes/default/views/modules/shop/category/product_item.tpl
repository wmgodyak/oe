<div class="product__item">
    <a class="product__link" href="{$product.id}" title="{$product.title}">
                    <span class="m_product-item">
                       <span class="product-item__img-row">
                            <img class="product-item__img" src="{$app->images->cover($product.id, 'psm')}" alt="{$product.title}">
                       </span>
                        <span class="row float-row clearfix">
                            {assign var='avRate' value=$mod->comments->getAverageRating($product.id)|ceil}
                            <span class="m_star-rating">
                               <select class="star-rating read-only">
                                   {for $i=1;$i<=5; $i++ }
                                       <option {if $avRate == $i}selected{/if} value="{$i}">{$i}</option>
                                   {/for}
                               </select>
                            </span>
                            <span class="product-item__coment-counter">
                                {$mod->comments->getTotal($product.id)} відгуки
                            </span>
                        </span>

                       <span class="product-item__name">
                           {$product.name} {$product.pprice}
                       </span>

                       <span class="product-item__price">
                           {$product.price} {$product.symbol}
                       </span>

                       <span class="product-item__bonus">
                           Ваш СМА бонус: <span>+0 грн</span>
                       </span>

                       <span class="product-item__activities">

                           <button class="btn sm red">Купити в 1 клік</button>

                           <span class="m_cart-indicator m_cart-indicator--out">
                           </span>

                           <span class="m_hearth-like">
                               <span class="hearth-like__link"></span>
                           </span>

                       </span>
                   </span>
    </a>
</div>