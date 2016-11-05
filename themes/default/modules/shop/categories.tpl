{assign var='categories' value=$mod->shop->categories()}
{assign var='categories' value=array_chunk($categories, 3)}

<div class="product-page__content">
    <div class="product__list">
        {foreach $categories as $row}
            <div class="row">
                {foreach $row as $cat}
                    <div class="product__item" style="height:255px;">
                        <div class="product__link">
                            <div class="m_product-item"  style="text-align: center;">
                                <a href="{$cat.id}" title="{$cat.title}" class="product-item__img-row" style="height: 210px;">
                                    <img class="product-item__img lazy" data-original="{$app->images->cover($cat.id, 'cat')}" alt="{$cat.title}">
                                </a>
                                <div class="product-item_wrap-info1">
                                    <a href="{$cat.id}" title="{$cat.title}" class="product-item__name">
                                        {$cat.name}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        {/foreach}
    </div>
</div>