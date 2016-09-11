{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}


    <!-- begin article-page -->
    <div class="article-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container">

            <!-- begin article-page__content -->
            <div class="article-page__content" style="width: 100%;">
                <h1>{$page.name}</h1>
                <div class="comparison">
                    {assign var='products' value=$mod->shop->comparison->getProducts({$smarty.get.cat})}
                    {if $products|count}
                        <div class="categories">
                            Категорії:
                            {foreach $mod->shop->comparison->getCategories() as $cat}
                                <a href="15;?cat={$cat.id}" {if $cat.id == $smarty.get.cat}class="active"{/if} title="{$cat.title}">{$cat.name}</a>
                            {/foreach}
                        </div>
                        <table class="table">
                            <tr>
                                <th>Товар</th>
                                {foreach $products as $product}
                                    <td>
                                        <div class="item">
                                            <img  src="{$app->images->cover($product.id, 'product')}" alt="">
                                            <a href="{$product.id}" target="_blank">{$product.name}</a>
                                            <span class="price">{$product.price} грн.</span>
                                        </div>
                                    </td>
                                {/foreach}
                            </tr>
                            <tr>
                                <th>Наявність</th>
                                {foreach $products as $product}
                                    <td>
                                        {if $product.in_stock == 1}
                                            {$t.shop.product.in_stock_1}
                                        {elseif $product.in_stock == 2}
                                            {$t.shop.product.in_stock_2}
                                        {else}
                                            {$t.shop.product.in_stock_0}
                                        {/if}
                                    </td>
                                {/foreach}
                            </tr>
                            {foreach $mod->shop->comparison->getFeatures({$smarty.get.cat}) as $feature}
                                <tr>
                                    <th>{$feature.name}</th>
                                    {foreach $products as $product}
                                        <td>
                                            {assign var='has_values' value="0"}
                                            {foreach $product.features as $f}
                                                {if $f.id == $feature.id}
                                                    {foreach $f.values as $i=>$val}
                                                        {$val.name}
                                                        {assign var='has_values' value="1"}
                                                    {/foreach}
                                                {/if}
                                            {/foreach}
                                            {if !$has_values}-{/if}
                                        </td>
                                    {/foreach}
                                </tr>
                            {/foreach}
                            <tr>
                                <th>&nbsp;</th>
                                {foreach $products as $product}
                                    <td>
                                        {if $product.in_stock == 1}
                                            <div class="bnt-row">
                                                <button class="btn sm white-red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">Купити в 1 клік</button>
                                                <div class="clear" style="height: 10px;"></div>
                                                <button class="btn sm red buy-btn to-cart cart-product-{$product.id} {if isset($smarty.session.cart[$product.id])}in{/if}"
                                                        data-id="{$product.id}"
                                                        data-has-variants="{$product.has_variants}"
                                                        data-in="В кошику"
                                                        data-bye="Купити"
                                                >{if isset($smarty.session.cart[$product.id])}В кошику{else}Купити{/if}</button>
                                                <div class="clear" style="height: 10px;"></div>
                                                <a href="javascript:;" class="b-comparison-del" data-id="{$product.id}">Видалити</a>
                                            </div>
                                        {/if}
                                    </td>
                                {/foreach}
                            </tr>
                        </table>
                    {else}
                        <div class="bs-callout bs-callout-danger">
                            <p>Нічого порівнювати</p>
                        </div>
                    {/if}
                </div>
            </div>
            <!-- end article-page__content -->
        </div>

    </div>
    <!-- end article-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}