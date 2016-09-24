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
                    {assign var='expired' value=$app->contentMeta->get($page.id, 'expired', true)}
                    <div class="m_actions_countdown">
                        <div class="title">
                            {$t.shopActions.counter_title}
                        </div>
                        <div id="a_timer" class="timer" data-expired='{date('Y/m/d', strtotime($expired))}'></div>
                    </div>
                {/if}

                <div class="text cms-content action-content">
                    {$page.content}
                    {$events->call('layouts.actions.content')}
                </div>

                {assign var='products' value= $mod->shopActions->products($page.id)}
                {if $products|count}
                    <!-- begin product__list -->
                    <div class="actions-products">
                        <div style="clear: both;"><br></div>
                        <h2>Акційні товари</h2>
                        <div class="product__list {if $smarty.session.display_mode !=''}{$smarty.session.display_mode}{/if}">
                            {assign var='products' value= array_chunk($products, 3)}
                            {foreach $products as $k=> $row}
                                <div class="row clearfix">
                                    {foreach $row as $product}
                                        {include file="modules/shop/category/product_item.tpl"}
                                    {/foreach}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                    <!-- end product__list -->
                    {$mod->shopActions->productsPagination()}
                    <div class="clearfix"><br></div>
                {/if}

                {assign var='old_actions' value=$mod->shopActions->old($page.id, 4)}
                {if $old_actions|count}
                    <div class="old-actions">
                        <h2>Інші акції</h2>
                        {foreach $old_actions as $a}
                            <div class="item">
                                <div class="title"><a href="{$a.url}">{$a.name}</a></div>
                                {if $a.image != ''}
                                <div class="img"><a href="{$a.url}"><img src="{$a.image}" alt=""></a></div>
                                {/if}
                            </div>
                        {/foreach}
                    </div>
                    <div class="clearfix" style="clear: both;"><br></div>
                    <div class="clearfix" style="clear: both;"><br></div>
                {/if}
            </div>
            <!-- end article-page__content -->
            {include file="chunks/sidebar.tpl"}
        </div>
    </div>
    <!-- end article-page -->
</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}