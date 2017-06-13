{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T14:05:04+03:00
 * @name Магазин категорії
 *}

{include file="chunks/head.tpl"}

<div class="wrapper">

    {include file="chunks/header.tpl"}

    <div class="product-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container clearfix">


            <aside class="aside">
                {include file="modules/shop/nav.tpl"}
                <div class="clear"><br></div>
                {$mod->shop->filter()}
                {$events->call('shop.categories.sidebar', $page)}
                {include file="modules/newsletter/subscribe.tpl"}
                {include file="chunks/widgets/fb.tpl"}
                {include file="chunks/widgets/vk.tpl"}

            </aside>



            <div class="product-page__content">


                <div class="product-page__top-line">
                    <div class="title">{$page.name}</div>
                    {include file="modules/shop/category/sorting.tpl"}
                </div>

                {include file="modules/shop/subnav.tpl"}
                {assign var='products' value= $mod->shop->products($page.id)}
                {*{assign var='total' value= $mod->shop->foundTotal()}*}

                <div class="product__list {if $smarty.session.display_mode !=''}{$smarty.session.display_mode}{/if}">
                    {if !empty($products)}
                        {assign var='products' value= array_chunk($products, 3)}
                        {* {if isset($smarty.get.q) && !empty($smarty.get.q)}
                            <h3>По запиту <strong>{$smarty.get.q}</strong> знайдено {$total} товарів</h3>
                        {/if} *}
                        {foreach $products as $k=> $row}
                            <div class="row clearfix">
                                {foreach $row as $product}
                                    {include file="modules/shop/category/product_item.tpl"}
                                {/foreach}
                            </div>
                        {/foreach}
                    {else}
                        <div class="bs-callout bs-callout-danger"><p>{$t.shop.no_products}</p></div>
                    {/if}
                </div>


                {$mod->shop->pagination()}

                <div class="row cms-content">
                    {$page.content}
                </div>
            </div>


        </div>

    </div>


</div>

{include file="chunks/footer.tpl"}