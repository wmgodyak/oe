{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-11T18:02:59+03:00
 * @name Пошук
 *}

{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin product-page -->
    <div class="product-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container clearfix">

            <!-- begin aside -->
            <aside class="aside">
                {assign var='categories' value=$mod->shop->search->categories()}
                {if $categories|count}
                <form>
                    <div class="filter-group">
                        <a class="toggle-link">
                            Знайдено в категоріях
                        </a>
                        <div class="filter-group__content">
                            <div class="input-group">
                                {foreach $categories as $row}
                                    <div class="row">
                                        <label for="cf-15" >
                                            <span {* href="{$row.cat.id};?q={urlencode($smarty.get.q)}" *} >{$row.cat.name}</span>
                                        </label>
                                    </div>
                                    {if $row.items|count}
                                        {foreach $row.items as $item}
                                            <div class="row sub-cat" style="padding-left: 15px;">
                                                <label for="cf-15" >
                                                    <a href="{$item.id};?q={urlencode($smarty.get.q)}" style=" font-size: 14px;">{$item.name}</a>
                                                </label>
                                            </div>
                                        {/foreach}
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </form>
                {/if}
                <div class="m_discount-widget">
                    <div class="discount__heading1">
                        Ви у нас вперше?
                    </div>
                    <div class="discount__content">
                        <div class="discount__img-block">
                            <div class="discount__img" style="background-image: url('{$theme_url}assets/img/discount-widget/img1.png');"></div>
                        </div>
                        <div class="discount__heading2">
                            Отримайте знижку!
                        </div>
                        <div class="discount__text">
                            Введіть свою електронну скриньку
                            та отримайте знижку у нашому
                            інтернет магазині, а також будьте
                            завжди в курсі наших новин.
                        </div>
                        <form action="#">
                            <div class="input-group">
                                <input type="email" placeholder="Введіть свій e-mail">
                            </div>
                            <div class="btn-row">
                                <button class="btn md red">Хочу знижку</button>
                            </div>
                        </form>
                    </div>
                </div>
            </aside>
            <!-- end aside -->

            <!-- begin product-page__content -->
            <div class="product-page__content">

                <!-- begin product-page__top-line -->
                <div class="product-page__top-line">
                    <div class="title">{$page.title}</div>

                    {include file="modules/shop/category/sorting.tpl"}

                </div>
                {*{print_r($mod->shop->search->categories())}*}
                <!-- end product-page__top-line -->
                {assign var='products' value= $mod->shop->search->results()}
                {assign var='error' value=$mod->shop->search->getError()}
                <!-- begin product__list -->
                <div class="product__list">
                    {if $products && $products|count}
                        <h3>Знайдено {$mod->shop->search->total()} товарів</h3>
                        {assign var='products' value= array_chunk($products, 3)}
                        {foreach $products as $k=> $row}
                            <div class="row clearfix">
                                {foreach $row as $product}
                                    {include file="modules/shop/category/product_item.tpl"}
                                {/foreach}
                            </div>
                        {/foreach}
                    {else}
                        {if $error}
                            <p>{implode('<br>', $error)}</p>
                        {else}
                            <p>Немає результатів</p>
                        {/if}

                    {/if}
                </div>
                <!-- end product__list -->
                {if !$error}
                {$mod->shop->search->pagination()}
                {/if}
                <script src="route/shop/saveSearchQuery/{$smarty.get.q}"></script>
            </div>
            <!-- end product-page__content -->

        </div>

    </div>
    <!-- end product-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}