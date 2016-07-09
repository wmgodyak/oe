{assign var='products' value= $mod->shop->products($page.id)}
{assign var='products' value= array_chunk($products, 3)}
<!-- begin product__list -->
<div class="product__list">
    {if $products|count}
        {foreach $products as $k=> $row}
        <div class="row clearfix">
            {foreach $row as $product}
                <div class="product__item">
                <a class="product__link" href="{$product.id}" title="{$product.title}">
                    <span class="m_product-item">
                       <span class="product-item__img-row">
                            <img class="product-item__img" src="{$app->images->cover($product.id, 'psm')}" alt="{$product.title}">
                       </span>
                        <span class="row float-row clearfix">
                            <span class="m_star-rating">
                               <select class="star-rating read-only">
                                   <option value="1">1</option>
                                   <option value="2">2</option>
                                   <option value="3">3</option>
                                   <option value="4">4</option>
                                   <option value="5">5</option>
                               </select>
                           </span>
                            <span class="product-item__coment-counter">
                                3 відгуки
                            </span>
                        </span>

                       <span class="product-item__name">
                           {$product.name}
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
            {/foreach}
        </div>
        {/foreach}
    {else}
        <p>Немає товарів</p>
    {/if}
</div>
<!-- end product__list -->