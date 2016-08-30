{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T14:05:04+03:00
 * @name Магазин категорії
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
                {$mod->shop->filter()}
                <div class="m_discount-widget">
                    <div class="discount__heading1">
                        Ви у нас вперше?
                    </div>
                    <div class="discount__content">
                        <div class="discount__img-block">
                            <div class="discount__img" style="background-image: url('assets/img/discount-widget/img1.png');"></div>
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
                <!-- end product-page__top-line -->
                {include file="modules/shop/subnav.tpl"}
                {assign var='products' value= $mod->shop->products($page.id)}
                <!-- begin product__list -->
                <div class="product__list">
                    {if $products|count}
                        {assign var='products' value= array_chunk($products, 3)}
                        {if isset($smarty.get.q) && !empty($smarty.get.q)}
                            <h3>Знайдено {$mod->shop->foundTotal()} товарів</h3>
                        {/if}
                        {foreach $products as $k=> $row}
                            <div class="row clearfix">
                                {foreach $row as $product}
                                    {include file="modules/shop/category/product_item.tpl"}
                                {/foreach}
                            </div>
                        {/foreach}
                    {else}
                        <p>Немає товарів</p>
                    {/if}
                </div>
                <!-- end product__list -->

                {$mod->shop->pagination()}

                <div class="row cms-content">
                    {$page.content}
                </div>
            </div>
            <!-- end product-page__content -->

        </div>

    </div>
    <!-- end product-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}