{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name actions
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
            <div class="article-page__content">
                <h1>{$page.name}</h1>
                {if $app->contentMeta->get($page.id, 'counter', true) == 1}
                    <div class="m_actions_countdown">
                        <div class="title">
                            Залишилось:
                        </div>
                        <div id="a_timer" class="timer" data-expired='2016/09/22'></div>
                    </div>
                {/if}

                <div class="text cms-content action-content">
                    {$page.content}
                    {$events->call('layouts.actions.content')}
                </div>

                {assign var='products' value= $mod->shopActions->products(36918)}
                {*{print_r($products)}*}
                <!-- begin product__list -->
                <div class="actions-products">
                    <div style="clear: both;"><br></div>
                    <h2>Акційні товари</h2>
                    <div class="product__list {if $smarty.session.display_mode !=''}{$smarty.session.display_mode}{/if}">
                        {if $products|count}
                            {assign var='products' value= array_chunk($products, 3)}
                            {foreach $products as $k=> $row}
                                <div class="row clearfix">
                                    {foreach $row as $product}
                                        {include file="modules/shop/category/product_item.tpl"}
                                    {/foreach}
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                </div>

                <!-- end product__list -->

                {$mod->shop->pagination()}
            </div>
            <!-- end article-page__content -->
            {include file="chunks/sidebar.tpl"}
        </div>

    </div>
    <!-- end article-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}