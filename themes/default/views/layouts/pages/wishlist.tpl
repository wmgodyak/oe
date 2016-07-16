{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-15T17:21:49+03:00
 * @name Wish List
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin cart-page -->
    <div class="cart-page">

        {include file="modules/breadcrumbs.tpl"}



        <div class="container clearfix">
            <div class="cart-page__content">
                <div class="heading">{$page.name}</div>
                {if !isset($user.id)}
                    <p>Авійдіть або зареєструйтесь і отримайте більше можливостей</p>
                    {else}
                    {assign var='wishlist' value=$mod->wishlist->get()}
                    {if $wishlist|count}
                        {foreach $wishlist as $list}
                            <h3 class="head-red">{$list.name}</h3>
                            {if $list.products|count}
                                {foreach $list.products as $product}
                                    {include file="modules/shop/category/product_item.tpl"}
                                {/foreach}
                            {/if}
                        {/foreach}
                    {else}
                    {/if}
                {/if}
            </div>

            <aside class="aside">{include file="chunks/sidebar.tpl"}</aside>
        </div>

    </div>
    <!-- end cart-page -->
</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}