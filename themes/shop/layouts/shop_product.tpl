{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}

{extends 'layouts/pages/sb-sl.tpl'}
{block name="body.class"}index-opt-6 catalog-product-view catalog-view_op1{/block}
{block name="main" prepend}
    {include file="chunks/breadcrumb.tpl"}
{/block}
{block name="content"}
    <div class="row">

        <div class="col-sm-6 col-md-6 col-lg-6">

            <div class="product-media media-horizontal">

                <div class="image_preview_container images-large">

                    <img id="img_zoom" data-zoom-image="{$theme_url}assets/images/media/detail/thumb-lag1.jpg" src="{$theme_url}assets/images/media/detail/thumb-img1.jpg" alt="">

                    <button class="btn-zoom open_qv"><span>zoom</span></button>

                </div>

                <div class="product_preview images-small">

                    <div class="owl-carousel thumbnails_carousel" id="thumbnails"  data-nav="true" data-dots="false" data-margin="10" {literal}data-responsive='{"0":{"items":3},"480":{"items":4},"600":{"items":5},"768":{"items":3}}'{/literal}>

                        <a href="Product_detail---Main.html#" data-image="{$theme_url}assets/images/media/detail/thumb-img1.jpg" data-zoom-image="{$theme_url}assets/images/media/detail/thumb-lag1.jpg">

                            <img src="{$theme_url}assets/images/media/detail/thumb1.jpg" data-large-image="{$theme_url}assets/images/media/detail/thumb-img1.jpg" alt="">

                        </a>

                        <a href="Product_detail---Main.html#" data-image="{$theme_url}assets/images/media/detail/thumb-img2.jpg" data-zoom-image="{$theme_url}assets/images/media/detail/thumb-lag2.jpg">

                            <img src="{$theme_url}assets/images/media/detail/thumb2.jpg" data-large-image="{$theme_url}assets/images/media/detail/thumb-img2.jpg" alt="">

                        </a>
                        <a href="Product_detail---Main.html#" data-image="{$theme_url}assets/images/media/detail/thumb-img3.jpg" data-zoom-image="{$theme_url}assets/images/media/detail/thumb-lag3.jpg">

                            <img src="{$theme_url}assets/images/media/detail/thumb3.jpg" data-large-image="{$theme_url}assets/images/media/detail/thumb-img3.jpg" alt="">

                        </a>
                        <a href="Product_detail---Main.html#" data-image="{$theme_url}assets/images/media/detail/thumb-img1.jpg" data-zoom-image="{$theme_url}assets/images/media/detail/thumb-lag1.jpg">

                            <img src="{$theme_url}assets/images/media/detail/thumb1.jpg" data-large-image="{$theme_url}assets/images/media/detail/thumb-img1.jpg" alt="">

                        </a>

                    </div><!--/ .owl-carousel-->

                </div><!--/ .product_preview-->

            </div><!-- image product -->
        </div>

        <div class="col-sm-6 col-md-6 col-lg-6">

            <div class="product-info-main">

                <h1 class="page-title">
                    Advanced Dark Blue Coast
                </h1>
                <div class="product-reviews-summary">
                    <div class="rating-summary">
                        <div class="rating-result" title="70%">
                                                <span style="width:70%">
                                                    <span><span>70</span>% of <span>100</span></span>
                                                </span>
                        </div>
                    </div>
                    <div class="reviews-actions">
                        <a href="Product_detail---Main.html" class="action view">Based  on 3 ratings</a>
                        <a href="Product_detail---Main.html" class="action add"><img alt="img" src="{$theme_url}assets/images/icon/write.png">&#160;&#160;write a review</a>
                    </div>
                </div>

                <div class="product-info-price">
                    <div class="price-box">
                        <span class="price">$38.95   </span>
                        <span class="old-price">$52.00</span>
                        <span class="label-sale">-30%</span>
                    </div>
                </div>
                <div class="product-code">
                    Item Code: #453217907 :
                </div>
                <div class="product-info-stock">
                    <div class="stock available">
                        <span class="label">Availability: </span>In stock
                    </div>
                </div>
                <div class="product-condition">
                    Condition: New
                </div>
                <div class="product-overview">
                    <div class="overview-content">
                        Vestibulum eu odio. Suspendisse potenti. Morbi mollis tellus ac sapien. Praesent egestas tristique nibh. Nullam dictum felis eu pede mollis pretium. Fusce egestas elit eget lorem.
                    </div>
                </div>

                <div class="product-add-form">
                    <p>Available Options:</p>
                    <form>

                        <div class="product-options-wrapper">

                            <div class="swatch-opt">
                                <div class="swatch-attribute color" >
                                    <span class="swatch-attribute-label">Color:</span>
                                    <div class="swatch-attribute-options clearfix">
                                        <div class="swatch-option color selected" style="background-color: #0c3b90 ;"></div>
                                        <div class="swatch-option color" style="background-color: #036c5d ;"></div>
                                        <div class="swatch-option color" style="background-color: #5f2363 ;"></div>
                                        <div class="swatch-option color " style="background-color: #ffc000 ;"></div>
                                        <div class="swatch-option color" style="background-color: #36a93c ;"></div>
                                        <div class="swatch-option color" style="background-color: #ff0000 ;"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-qty">
                                <label class="label">Qty: </label>
                                <div class="control">
                                    <input type="text" class="form-control input-qty" value='1' id="qty1" name="qty1"  maxlength="12"  minlength="1">
                                    <button class="btn-number  qtyminus" data-type="minus" data-field="qty1"><span>-</span></button>
                                    <button class="btn-number  qtyplus" data-type="plus" data-field="qty1"><span>+</span></button>
                                </div>
                            </div>
                            <div class="form-configurable">
                                <label for="forSize" class="label">Size: </label>
                                <div class="control">
                                    <select  id="forSize" class="form-control attribute-select">
                                        <option value="1">XXXL</option>
                                        <option value="4">X</option>
                                        <option value="5">L</option>
                                    </select>
                                </div>
                                <a href="Product_detail---Main.html" class="size-chart">Size chart</a>
                            </div>
                        </div>



                        <div class="product-options-bottom clearfix">

                            <div class="actions">

                                <button type="submit" title="Add to Cart" class="action btn-cart">
                                    <span>Add to Cart</span>
                                </button>
                                <div class="product-addto-links">

                                    <a href="Product_detail---Main.html#" class="action btn-wishlist" title="Wish List">
                                        <span>Wishlist</span>
                                    </a>
                                    <a href="Product_detail---Main.html#" class="action btn-compare" title="Compare">
                                        <span>Compare</span>
                                    </a>
                                </div>
                            </div>

                        </div>

                    </form>
                </div>
                <div class="product-addto-links-second">
                    <a href="Product_detail---Main.html" class="action action-print">Print</a>
                    <a href="Product_detail---Main.html" class="action action-friend">Send to a friend</a>
                </div>
                <div class="share">
                    <img src="{$theme_url}assets/images/media/index1/share.png" alt="share">
                </div>
            </div><!-- detail- product -->

        </div><!-- Main detail -->

    </div>

    <!-- product tab info -->

    <div class="product-info-detailed ">

        <!-- Nav tabs -->
        <ul class="nav nav-pills" role="tablist">
            <li role="presentation" class="active"><a href="Product_detail---Main.html#description"  role="tab" data-toggle="tab">Product Details   </a></li>
            <li role="presentation"><a href="Product_detail---Main.html#tags"  role="tab" data-toggle="tab">information </a></li>
            <li role="presentation"><a href="Product_detail---Main.html#reviews"  role="tab" data-toggle="tab">reviews</a></li>
            <li role="presentation"><a href="Product_detail---Main.html#additional"  role="tab" data-toggle="tab">Extra Tabs</a></li>
            <li role="presentation"><a href="Product_detail---Main.html#tab-cust"  role="tab" data-toggle="tab">Guarantees</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="description">
                <div class="block-title">Product Details</div>
                <div class="block-content">
                    <p>Morbi mollis tellus ac sapien. Nunc nec neque. Praesent nec nisl a purus blandit viverra. Nunc nec neque. Pellentesque auctor neque nec urna.</p>
                    <br>
                    <p>Curabitur suscipit suscipit tellus. Cras id dui. Nam ipsum risus, rutrum vitae, vestibulum eu, molestie vel, lacus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Maecenas vestibulum mollis diam.</p>
                    <br>
                    <p>Vestibulum facilisis, purus nec pulvinar iaculis, ligula mi congue nunc, vitae euismod ligula urna in dolor. Sed lectus. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. Nam at tortor in tellus interdum sagittis. Pellentesque egestas, neque sit amet convallis pulvinar, justo nulla eleifend augue, ac auctor orci leo non est.</p>
                    <br>
                    <p>Morbi mollis tellus ac sapien. Nunc nec neque. Praesent nec nisl a purus blandit viverra. Nunc nec neque. Pellentesque auctor neque nec urna.</p>

                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="tags">
                <div class="block-title">information</div>
                <div class="block-content">
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>


                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="reviews">
                <div class="block-title">reviews</div>
                <div class="block-content">
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>

                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="additional">
                <div class="block-title">Extra Tabs</div>
                <div class="block-content">
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>

                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="tab-cust">
                <div class="block-title">Guarantees</div>
                <div class="block-content">
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>

                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>
                    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also Aldus PageMaker including versions of Lorem Ipsum</p>

                </div>
            </div>
        </div>
    </div>
    <!-- product tab info -->

    <!-- block-related product -->
    <div class="block-related ">
        <div class="block-title">
            <strong class="title">RELATED products</strong>
        </div>
        <div class="block-content ">
            <ol class="product-items owl-carousel " data-nav="true" data-dots="false" data-margin="30" {literal}data-responsive='{"0":{"items":1},"480":{"items":2},"600":{"items":3},"992":{"items":3}}'{/literal}>


                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/related2-1.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Brown Short 100% Cotton</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>

                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/related2-2.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Summer T-Shirt</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/related2-3.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Blue Short 50% Cotton</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/related2-1.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Brown Short 100% Cotton</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>

            </ol>
        </div>
    </div><!-- block-related product -->

    <!-- block-Upsell Products -->
    <div class="block-upsell ">
        <div class="block-title">
            <strong class="title">You might also like</strong>
        </div>
        <div class="block-content ">
            <ol class="product-items owl-carousel " data-nav="true" data-dots="false" data-margin="30" {literal}data-responsive='{"0":{"items":1},"480":{"items":2},"600":{"items":3},"992":{"items":3}}'{/literal}>


                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/Upsell2-1.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>
                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Leather Swiss Watch</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>

                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/Upsell2-2.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Sport T-Shirt For Men</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/Upsell2-3.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Fashion Leather Handbag</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="product-item product-item-opt-2">
                    <div class="product-item-info">
                        <div class="product-item-photo">
                            <a href="Product_detail---Main.html" class="product-item-img"><img src="{$theme_url}assets/images/media/detail/Upsell2-3.jpg" alt="product name"></a>
                            <div class="product-item-actions">
                                <a href="Product_detail---Main.html" class="btn btn-wishlist"><span>wishlist</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-compare"><span>compare</span></a>
                                <a href="Product_detail---Main.html" class="btn btn-quickview"><span>quickview</span></a>
                            </div>
                            <button class="btn btn-cart" type="button"><span>Add to Cart</span></button>

                        </div>
                        <div class="product-item-detail">
                            <strong class="product-item-name"><a href="Product_detail---Main.html">Fashion Leather Handbag</a></strong>
                            <div class="clearfix">
                                <div class="product-item-price">
                                    <span class="price">$45.00</span>
                                    <span class="old-price">$52.00</span>
                                </div>
                                <div class="product-reviews-summary">
                                    <div class="rating-summary">
                                        <div class="rating-result" title="70%">
                                                                <span style="width:70%">
                                                                    <span><span>70</span>% of <span>100</span></span>
                                                                </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>

            </ol>
        </div>
    </div><!-- block-Upsell Products -->

{/block}
{block name="sidebar.content"}
    <!-- block filter products -->
    <div id="layered-filter-block" class="block-sidebar block-filter no-hide">
        <div class="close-filter-products"><i class="fa fa-times" aria-hidden="true"></i></div>
        <div class="block-title">
            <strong>SHOP BY</strong>
        </div>
        <div class="block-content">

            <!-- Filter Item  categori-->
            <div class="filter-options-item filter-options-categori">
                <div class="filter-options-title">Categories</div>
                <div class="filter-options-content">
                    <ol class="items">
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Smartphone & Mp3 Player  </span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Network & Computer</span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Batteries & Chargers</span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Headphone & Headset</span>
                            </label>
                        </li>
                    </ol>
                </div>
            </div><!-- Filter Item  categori-->

            <!-- filter price -->
            <div class="filter-options-item filter-options-price">
                <div class="filter-options-title">Price</div>
                <div class="filter-options-content">
                    <div class="slider-range">
                        <div class="action">
                                                <span class="price">
                                                    <span id="amount-left"></span>
                                                    <span id="amount-right"></span>
                                                </span>

                            <button type="button" class="btn default"><span>Search</span></button>
                        </div>
                        <div id="slider-range" ></div>
                        <span class="amount-min">$3</span>
                        <span class="amount-max">$6789</span>
                    </div>
                </div>
            </div><!-- filter price -->

            <!-- filter Manufacture-->
            <div class="filter-options-item filter-options-manufacture">
                <div class="filter-options-title">Manufacture</div>
                <div class="filter-options-content">
                    <ol class="items">
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Ercol  </span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Duresta</span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>G Plan</span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Parker Knoll</span>
                            </label>
                        </li>
                        <li class="item ">
                            <label>
                                <input type="checkbox"><span>Collins & Hayes</span>
                            </label>
                        </li>

                    </ol>
                </div>
            </div><!-- Filter Item -->

            <!-- filter color-->
            <div class="filter-options-item filter-options-color">
                <div class="filter-options-title">COLOR</div>
                <div class="filter-options-content">
                    <ol class="items">
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="img" style="background-color: #fca53c;"></span>
                                                        <span class="count">(30)</span>
                                                    </span>

                            </label>
                        </li>
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="img" style="background-color: #6b5a5c;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                            </label>
                        </li>
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="img" style="background-color: #000000;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                            </label>
                        </li>
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="img" style="background-color: #3063f2;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                            </label>
                        </li>
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="text" >CYal</span>
                                                        <span class="count">(20)</span>
                                                    </span>

                            </label>
                        </li>
                        <li class="item">
                            <label>
                                <input type="checkbox">
                                <span>
                                                        <span class="img" style="background-color: #f9334a;"></span>
                                                        <span class="count">(20)</span>
                                                    </span>

                            </label>
                        </li>


                    </ol>
                </div>
            </div><!-- Filter Item -->

        </div>
    </div><!-- Filter -->

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