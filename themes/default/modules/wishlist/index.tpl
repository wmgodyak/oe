{*{d($products)}*}
<div class="m_wishlist">
{if $wishlists|count}
    {foreach $wishlists as $wishlist}
        <h2 class="title">{$wishlist.name}</h2>
        {assign var='products' value= array_chunk($wishlist.products, 3)}
        <div class="product-page">
            <div class="product-page__content">
                <div class="product__list">
                    {foreach $products as $k=> $row}
                        <div class="row clearfix">
                            {foreach $row as $product}
                                {*{d($product)}*}
                                {assign var="custom_actions" value="<a title='Видалити зі списку' href='javascript:;' class='wishlist-delete-item' data-id='`$product.wp_products_id`'></a>"}
                                {include file="modules/shop/category/product_item.tpl"}
                            {/foreach}
                        </div>
                    {/foreach}
                </div>
            </div>
        </div>
    {/foreach}
{else}
    <p>Немає товарів</p>
{/if}
</div>