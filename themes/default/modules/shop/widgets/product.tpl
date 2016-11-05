{assign  var='sa_action' value=$app->contentMeta->get($item.id, 'sa_action', true)}
<div class="goods-multiple-slider__item">
    <div class="goods-multiple-slider__link">{* href="{$item.id}" title="{$item.title}"  *}
       <span class="m_product-item">
           <a  href="{$item.id}"  class="product-item__img-row">
               <img class="product-item__img lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-original="{$app->images->cover($item.id, 'thumbs')}" alt="{$item.title}">
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
               {shortText($item.name, 40)}
           </a>

           <span class="product-item__price">
               {$item.price} {$item.symbol}
               {if isset($item.price_old) && $item.price_old > 0 && $item.price_old > $item.price}
                   <span title="Стара ціна" class="price-old">{$item.price_old} {$item.symbol}</span>
               {/if}
           </span>

           {if $smarty.session.display_bonus && $sa_action != 1}
           <span class="product-item__bonus">
               Our bonus: <span>+{$item.bonus} {$item.symbol}</span>
           </span>
           {/if}

           <span class="product-item__activities">
                {if $item.in_stock == 1}
                    <button title="{$t.order.one_click.hint}" class="btn sm red buy-one-click" data-has-variants="{$item.has_variants}" data-id="{$item.id}">{$t.order.one_click.buy}</button>
                    <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$item.id} {if isset($smarty.session.cart.products[$item.id])}m_cart-indicator__in{/if}" data-id="{$item.id}" data-has-variants="{$item.has_variants}" title="{if isset($smarty.session.cart.products[$item.id])}{$t.order.cart.in}{else}{$t.order.cart.add}{/if}"></span>
                {else}
                    <button class="btn sm  to-wait-list" data-has-variants="{$item.has_variants}" data-id="{$item.id}" title="{$t.waitlist.title}">{$t.waitlist.link}</button>
                {/if}
               <span class="m_hearth-like">
                   <span title="{$t.wishlist.hint}" class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$item.id])}hearth-like__link--liked{/if}" data-id="{$item.id}" data-has-variants="{$item.has_variants}"></span>
               </span>

                <span class="comparison-link">
                    <a title="{$t.shop.comparison.add}" href="15;?cat={$item.categories_id}" class=" to-comparison {if isset($smarty.session.comparison[$item.id])}in{/if}" data-in="{$t.shop.comparison.in}" data-cat="{$item.categories_id}" data-id="{$item.id}">{if isset($smarty.session.comparison[$item.id])}{$t.shop.comparison.in}{else}{$t.shop.comparison.add}{/if}</a>
                </span>
           </span>

           {if $item.in_stock == 1}
               <span class="wrap-label">
                   {if $item.new} <span class="m_novelty"></span>{/if}
                   {*{if $app->contentMeta->get($item.id, 'hit', true) == 1}<span class="m_hit" title="Хіт продажів"></span>{/if}*}
                   {if $item.hit == 1}<span class="m_hit" title="Хіт продажів"></span>{/if}
                   {if $app->contentMeta->get($item.id, 'bestseller', true) == 1}<span title="Супер ціна" class="m_bestseller"></span>{/if}
                   {if $sa_action == 1}<span class="m_sa_action" title="Акція"></span>{/if}
                   {*{if $app->contentMeta->get($item.id, 'bestseller', true) == 1}<span title="Супер ціна" class="m_special-offer"></span>{/if}*}
               </span>
           {/if}
       </span>
    </div>
</div>