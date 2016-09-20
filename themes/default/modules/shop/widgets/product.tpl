
<div class="goods-multiple-slider__item">
    <div href="{$item.id}" title="{$item.title}" class="goods-multiple-slider__link">
       <span class="m_product-item">
           <a  href="{$item.id}"  class="product-item__img-row">
               <img class="product-item__img" src="{$app->images->cover($item.id, 'thumbs')}" alt="{$item.title}">
           </a>

           {assign var='avRate' value=$mod->comments->getAverageRating($item.id)|ceil}
           <span class="m_star-rating">
               <select class="star-rating read-only">
                   {for $i=1;$i<=5; $i++ }
                       <option value=""></option>
                       <option {if $avRate == $i}selected{/if} value="{$i}">{$i}</option>
                   {/for}
               </select>
           </span>

           <a  href="{$item.id}"  class="product-item__name">
               {shortText($item.name, 60)}
           </a>

           <span class="product-item__price">
               {$item.price} {$item.symbol}
           </span>

           <span class="product-item__bonus">
               Ваш СМА бонус: <span>+{$item.bonus} грн</span>
           </span>

           <span class="product-item__activities">
                {if $item.in_stock == 1}
                    <button title="Введіть ім'я і телефон, деталі уточнимо по телефону" class="btn sm red buy-one-click" data-id="{$item.id}">Купити в 1 клік</button>

                    <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$item.id} {if isset($smarty.session.cart.products[$item.id])}m_cart-indicator__in{/if}"  data-in="В кошику" data-id="{$item.id}" data-has-variants="{$item.has_variants}" title="{if isset($smarty.session.cart.products[$item.id])}Вже в кошику{else}Додати в кошик{/if}"></span>
                {else}
                   <button class="btn sm to-wait-list" data-has-variants="{$item.has_variants}" data-id="{$item.id}" title="Повідомте про появу">Повідомте</button>
                {/if}
               <span class="m_hearth-like">
                   <span title="Додати в список улюблених" class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$item.id])}hearth-like__link--liked{/if}" data-id="{$item.id}" data-has-variants="{$item.has_variants}"></span>
               </span>

                <span class="comparison-link">
                    <a title="Додайте товар до порівняння" href="15;?cat={$item.categories_id}" class=" to-comparison {if isset($smarty.session.comparison[$item.id])}in{/if}" data-in="У порівнянні" data-cat="{$item.categories_id}" data-id="{$item.id}">{if isset($smarty.session.comparison[$item.id])}У порівнянні{else}Додати в порівняння{/if}</a>
                </span>
           </span>

           {if $item.in_stock == 1}
               <span class="wrap-label">
                   {if $item.new} <span class="m_novelty"></span>{/if}
                   {if $app->contentMeta->get($item.id, 'bestseller', true) == 1}<span title="Супер ціна" class="m_bestseller"></span>{/if}
                   {if $app->contentMeta->get($item.id, 'hit', true) == 1}<span class="m_hit" title="Хіт продажів"></span>{/if}
                   {if $app->contentMeta->get($item.id, 'sa_action', true) == 1}<span class="m_sa_action" title="Акція"></span>{/if}
                   {*{if $app->contentMeta->get($item.id, 'bestseller', true) == 1}<span title="Супер ціна" class="m_special-offer"></span>{/if}*}
               </span>
           {/if}
       </span>
    </div>
</div>