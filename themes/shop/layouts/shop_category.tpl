{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{extends 'layouts/pages/sb-sl.tpl'}
{block name="body.class"}index-opt-1 catalog-category-view{/block}

{block name="content"}

    {block name='catalog.category.top'}
        <div class="category-view">
            <div class="category-image">
                <img alt="category-images" src="{$theme_url}assets/images/media/index1/category-images.jpg" >
            </div>
        </div>
    {/block}

    {include file="modules/catalog/category/toolbar.tpl" cls="top"}

    <!-- List Products -->
    <div class="products  products-grid">
        <ol class="product-items row">
            {foreach $category.products as $product}
                {include file="modules/catalog/category/product.tpl"}
            {/foreach}
        </ol><!-- list product -->
    </div> <!-- List Products -->


    {include file="modules/catalog/category/toolbar.tpl" cls="bottom"}

    {block name='catalog.category.bottom'}
        <div class="category-view">
            <div class="category-image">
                <img alt="category-images" src="{$theme_url}assets/images/media/index1/category-images.jpg" >
            </div>
        </div>
    {/block}

{/block}
{block name="sidebar.content"}

    {include file="chunks/breadcrumb.tpl"}
    {include file="modules/catalog/category/filter.tpl"}



    <!-- Block  Compare-->
    <div class="block-sidebar block-sidebar-compare">
        <div class="block-title">
            <strong>compare products</strong>
        </div>
        <div class="block-content">
            You have no product to compare
        </div>
    </div><!-- Block  Compare-->

    <!-- Block  bestseller products-->
    <div class="block-sidebar block-sidebar-products">
        <div class="block-title">
            <strong>bestseller products</strong>
        </div>
        <div class="block-content">
            <div class="product-item">
                <div class="product-item-info">
                    <div class="product-item-photo">
                        <a href="Grid_Products.html" class="product-item-img"><img src="{$theme_url}assets/images/media/index1/sidebar-bestseller1.jpg" alt="product name"></a>
                    </div>
                    <div class="product-item-detail">
                        <strong class="product-item-name"><a href="Grid_Products.html">Washing Machine Pro</a></strong>
                        <div class="product-item-price">
                            <span class="price">$45.00</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-item-info">
                    <div class="product-item-photo">
                        <a href="Grid_Products.html" class="product-item-img"><img src="{$theme_url}assets/images/media/index1/sidebar-bestseller2.jpg" alt="product name"></a>
                    </div>
                    <div class="product-item-detail">
                        <strong class="product-item-name"><a href="Grid_Products.html">Washing Machine Pro</a></strong>
                        <div class="product-item-price">
                            <span class="price">$45.00</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-item">
                <div class="product-item-info">
                    <div class="product-item-photo">
                        <a href="Grid_Products.html" class="product-item-img"><img src="{$theme_url}assets/images/media/index1/sidebar-bestseller3.jpg" alt="product name"></a>
                    </div>
                    <div class="product-item-detail">
                        <strong class="product-item-name"><a href="Grid_Products.html">Washing Machine Pro </a></strong>
                        <div class="product-item-price">
                            <span class="price">$45.00</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- Block  bestseller products-->
{/block}

{block name='footer.scripts' append}

    <script>

        (function($) {

            "use strict";

            $(document).ready(function() {

                /*  [ Filter by price ]

                 - - - - - - - - - - - - - - - - - - - - */

                $('#slider-range').slider({

                    range: true,

                    min: {$filter->minPrice()},

                    max: {$filter->maxPrice()},

                    values: [{if $smarty.get.minp > 0}{$smarty.get.minp}{else}{$filter->minPrice()}{/if}, {if $smarty.get.maxp > 0}{$smarty.get.maxp}{else}{$filter->maxPrice()}{/if}],

                    slide: function (event, ui) {

                        $('#amount-left').val(ui.values[0] );
                        $('#amount-right').val(ui.values[1] );

                    }

                });

                $('#amount-left').val($('#slider-range').slider('values', 0));

                $('#amount-right').val($('#slider-range').slider('values', 1));
            });

        })(jQuery);

    </script>
{/block}