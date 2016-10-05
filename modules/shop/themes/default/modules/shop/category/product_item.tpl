<div class="product__item" data-id="{$product.id}">
    <span class="product__link">
        <span class="m_product-item">
           <a  href="{$product.id}" title="{$product.title}" class="product-item__img-row">
                <img class="product-item__img" src="{$app->images->cover($product.id, 'thumbs')}" alt="{$product.title}">
           </a>
           <div class="product-item_wrap-info">
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
                   {shortText($product.name, 60)}
               </a>
               {*<span class="product-item_description">*}
                   {*Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi aperiam architecto, aspernatur deserunt dolorum excepturi facere harum illo illum incidunt laboriosam maiores nulla obcaecati quidem repellendus sequi suscipit velit voluptas.*}
               {*</span>*}
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
                       <button title="Введіть ім'я і телефон, деталі уточнимо по телефону" class="btn sm red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">Купити в 1 клік</button>
                       <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$product.id} {if isset($smarty.session.cart.products[$product.id])}m_cart-indicator__in{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" title="{if isset($smarty.session.cart.products[$product.id])}Вже в кошику{else}Додати в кошик{/if}"></span>
                    {else}
                        <button class="btn sm  to-wait-list" data-has-variants="{$product.has_variants}" data-id="{$product.id}" title="Повідомте про появу">Повідомте</button>
                    {/if}
                   <span class="m_hearth-like">
                       <span title="Додати в список улюблених" class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$product.id])}hearth-like__link--liked{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" ></span>
                   </span>
               </span>

                <span class="comparison-link">
                    <a title="Додайте товар до порівняння" href="15;?cat={$product.categories_id}" class=" to-comparison {if isset($smarty.session.comparison[$product.id])}in{/if}" data-in="У порівнянні" data-cat="{$product.categories_id}" data-id="{$product.id}">{if isset($smarty.session.comparison[$product.id])}У порівнянні{else}Додати в порівняння{/if}</a>
                </span>
           </div>
            {if $product.in_stock == 1}
                <span class="wrap-label">
                    {if $app->contentMeta->get($product.id, 'hit', true) == 1}<span class="m_hit"></span>{/if}
                    {*{if $app->contentMeta->get($product.id, 'bestseller', true) == 1}<span class="m_special-offer"></span>{/if}*}
                    {if $app->contentMeta->get($product.id, 'bestseller', true) == 1}<span class="m_bestseller"></span>{/if}

                    {if $app->contentMeta->get($product.id, 'sa_action', true) == 1}<span class="m_sa_action" title="Акція"></span>{/if}
                </span>
            {/if}
       </span>
    </span>

    {if isset($custom_actions)}{$custom_actions}{/if}
</div>