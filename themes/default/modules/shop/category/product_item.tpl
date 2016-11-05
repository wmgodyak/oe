{assign var='sa_action' value=$app->contentMeta->get($product.id, 'sa_action', true)}
<div class="product__item" data-id="{$product.id}">
    <span class="product__link">
        <span class="m_product-item">
           <a  href="{$product.id}" title="{$product.title}" class="product-item__img-row">
                <img class="product-item__img lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-original="{$app->images->cover($product.id, 'thumbs')}" alt="{$product.title}">
           </a>
           <div class="product-item_wrap-info">
               {assign var='ct' value=$mod->comments->getTotal($product.id)}
               {if $ct > 0}
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
                            {$ct} відгуків
                        </span>
                  </span>
               {/if}

               <a  href="{$product.id}" title="{$product.title}" class="product-item__name">
                   {shortText($product.name, 60)}
               </a>
               <span class="product-item__price">
                   <span id="p-price-{$product.id}">{$product.price}</span> {$product.symbol}
                   {if $product.price_old > 0 && $product.price_old > $product.price}
                    <span title="Стара ціна" class="price-old">{$product.price_old} {$product.symbol}</span>
                   {/if}
               </span>

               {if $smarty.session.display_bonus && $sa_action != 1}
                <span class="product-item__bonus">
                   {$t.shop.bonus}: <span>+{$product.bonus} {$product.symbol}</span>
               </span>
               {/if}
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
                       <button title="{$t.order.one_click.hint}" class="btn sm red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">{$t.order.one_click.buy}</button>
                       <span class="m_cart-indicator m_cart-indicator--out to-cart cart-product-{$product.id} {if isset($smarty.session.cart.products[$product.id])}m_cart-indicator__in{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" title="{if isset($smarty.session.cart.products[$product.id])}{$t.order.cart.in}{else}{$t.order.cart.add}{/if}"></span>
                    {else}
                        <button class="btn sm  to-wait-list" data-has-variants="{$product.has_variants}" data-id="{$product.id}" title="{$t.waitlist.title}">{$t.waitlist.link}</button>
                    {/if}
                   <span class="m_hearth-like">
                       <span title="{$t.wishlist.hint}" class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$product.id])}hearth-like__link--liked{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}" ></span>
                   </span>
               </span>

                <span class="comparison-link">
                    <a title="{$t.shop.comparison.add}" href="15;?cat={$product.categories_id}" class=" to-comparison {if isset($smarty.session.comparison[$product.id])}in{/if}" data-in="{$t.shop.comparison.in}" data-cat="{$product.categories_id}" data-id="{$product.id}">{if isset($smarty.session.comparison[$product.id])}{$t.shop.comparison.in}{else}{$t.shop.comparison.add}{/if}</a>
                </span>

                <span class="product-item_description">
                    {foreach $product.features as $n=>$item}
                        {if $item.type != 'file' && ( ($item.values|count) || !empty($item.value) )}
                            {$item.name}:
                            {if $item.values|count}
                                {foreach $item.values as $i=>$v}
                                    {$v.name} {if isset($item.values[$i + 1])},{/if}
                                {/foreach}
                            {elseif $item.value != ''}
                                {$item.value}
                            {/if}
                            {if isset($product.features[$n + 1]) && ((isset($product.features[$n + 1].value) && $product.features[$n + 1].value != '') || isset($product.features[$n + 1].values) && $product.features[$n + 1].values != '')}/{/if}
                        {/if}
                    {/foreach}
                </span>
           </div>
            {if $product.in_stock == 1}
                <span class="wrap-label">
                    {if $app->contentMeta->get($product.id, 'hit', true) == 1}<span class="m_hit"></span>{/if}
                    {*{if $app->contentMeta->get($product.id, 'bestseller', true) == 1}<span class="m_special-offer"></span>{/if}*}
                    {if $app->contentMeta->get($product.id, 'bestseller', true) == 1}<span class="m_bestseller"></span>{/if}

                    {if $sa_action == 1}<span class="m_sa_action" title="Акція"></span>{/if}
                </span>
            {/if}
       </span>
    </span>

    {if isset($custom_actions)}{$custom_actions}{/if}
</div>