{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T14:05:29+03:00
 * @name Магазин / товари
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin article-page -->
    <div class="single-product-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container">

            <!-- begin single-product-page__content -->
            <div class="single-product-page__content">

                <div class="heading">
                    <h1>{$product.name}</h1>
                </div>

                <div class="item-main-info">

                    <div class="left">
                        {*<div class="product-slider1">*}
                            {*{if $product.images|count > 0}*}
                                {*{foreach $product.images as $k=>$img}*}
                                    {*<div class="slider1-item" style="background-image: url('/{$img.path}product/{$img.image}');"></div>*}
                                {*{/foreach}*}
                            {*{else}*}
                                {*<div class="slider1-item" style="background-image: url('/uploads/noimage.jpg');"></div>*}
                            {*{/if}*}
                        {*</div>*}

                        {*{if $product.images|count > 1}*}
                        {*<div class="product-slider2">*}
                            {*{foreach $product.images as $k=>$img}*}
                                {*<div class="slider2-item" style="background-image: url('/{$img.path}thumbs/{$img.image}');"></div>*}
                            {*{/foreach}*}
                        {*</div>*}
                        {*{/if}*}

                        {*{print_r($product.images)}*}
                        {*new slider*}

                        <div class="product-slider">
                            {if $product.images|count > 0}
                                {foreach $product.images as $k=>$img}
                                    <div class="product-slider-item">
                                        <div class="bl-table">
                                            <div class="wrap-img">
                                                <img src="/{$img.path}product/{$img.image}" alt="/{$img.path}product/{$img.image}">
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            {else}
                                <div class="product-slider-item">
                                    <div class="bl-table">
                                        <div class="wrap-img">
                                            <img src="/uploads/noimage.jpg" alt="">
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {if $product.images|count > 1}
                            <div class="product-thumb-slider">
                                {foreach $product.images as $k=>$img}
                                    <div class="product-thumb-item">
                                        <div class="wrap-img">
                                            <img src="/{$img.path}thumbs/{$img.image}" alt="">
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        {/if}

                    </div>

                    <div class="right">
                        <div class="row">
                            <div class="availability">
                                {$t.shop.product.availability}:
                                {if $product.in_stock == 1}
                                    <span>{$t.shop.product.in_stock_1}</span>
                                {elseif $product.in_stock == 2}
                                    <span>{$t.shop.product.in_stock_2}</span>
                                {else}
                                    <span>{$t.shop.product.in_stock_0}</span>
                                {/if}
                            </div>
                        </div>
                        <div class="row">
                            <div class="price">
                                {$product.price} грн.
                            </div>
                        </div>
                        {*<div class="row">*}
                            {*<div class="bonus">*}
                                {*Ваш СМА бонус: <span>+0 {$product.currency}</span>*}
                            {*</div>*}
                        {*</div>*}
                        {if $product.has_variants && $product.in_stock == 1}
                        <table>
                            <tr>
                                <th>Виб.</th>
                                <th>Зобр.</th>
                                <th>Назва</th>
                                <th>Ціна</th>
                            </tr>
                            {foreach $product.variants as $k=>$variant}
                                <tr>
                                    <td><input {if $k==0 || (isset($smarty.session.cart[$product.id]['variants_id']) && $smarty.session.cart[$product.id]['variants_id'] == $variant.id) }checked{/if} type="radio" name="variant" value="{$variant.id}"></td>
                                    <td>{$variant.img}</td>
                                    <td>{$variant.name}</td>
                                    <td>{$variant.price}</td>
                                </tr>
                            {/foreach}
                        </table>
                            {*<pre>{print_r($product.variants)}</pre>*}
                        {*{else}*}
                        {/if}

                        {if $product.in_stock == 1}
                            <div class="bnt-row">
                                <button class="btn sm red buy-btn to-cart cart-product-{$product.id} {if isset($smarty.session.cart[$product.id])}in{/if}"
                                        data-id="{$product.id}"
                                        data-has-variants="{$product.has_variants}"
                                        data-in="В кошику"
                                        data-bye="Купити"
                                >{if isset($smarty.session.cart[$product.id])}В кошику{else}Купити{/if}</button>
                                <button class="btn sm white-red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">Купити в 1 клік</button
                            </div>
                            <div class="comparison-link">
                                <a href="15;?cat={$product.categories_id}" style="margin-left: 5px;" class=" to-comparison {if isset($smarty.session.comparison[$product.id])}in{/if}" data-in="У порівнянні" data-cat="{$product.categories_id}" data-id="{$product.id}">{if isset($smarty.session.comparison[$product.id])}У порівнянні{else}Додати в порівняння{/if}</a>
                            </div>
                        {else}
                            <div class="bnt-row">
                                <button class="btn sm to-wait-list"
                                        data-id="{$product.id}"
                                        data-has-variants="{$product.has_variants}"
                                        title="Повідомте про появу">Повідомте про появу</button>
                            </div>
                        {/if}
                        {$events->call('shop.product.buy.after', $product)}
                        {include file="modules/shop/similar.tpl"}

                        {assign var='avRate' value=$mod->comments->getAverageRating($product.id)|ceil}
                        {if $avRate > 0}
                            {assign var='commentsTotal' value=$mod->comments->getTotal($product.id)}
                            <span class="row comment-row">
                                <span class="m_star-rating">
                                   <select class="star-rating read-only">
                                       {for $i=1;$i<=5; $i++ }
                                           <option {if $avRate == $i}selected{/if} value="{$i}">{$i}</option>
                                       {/for}
                                   </select>
                               </span>
                                <span class="coment-counter">
                                    {$commentsTotal} відгуки
                                </span>
                            </span>
                        {/if}
                        {if $app->contentMeta->get($product.id, 'en_short_desc', true) == 1}
                            {if $product.intro !=''}
                                <div class="row">
                                    <div class="short">
                                        <div class="wrap">
                                            <span>{$t.shop.product.description}:</span>
                                            {$product.intro}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {$events->call('shop.product.description.after', $product)}
                        {else}
                            {if $product.features|count}
                                <div class="row">
                                    <div class="short">
                                        <div class="wrap">
                                            <span>{$t.shop.product.description}:</span>
                                            {foreach $product.features as $item}
                                                    {$item.name}:
                                                    {if $item.values|count}
                                                        {foreach $item.values as $i=>$v}
                                                            {$v.name} {if isset($item.values[$i + 1])},{/if}
                                                        {/foreach}.
                                                    {/if}
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {$events->call('shop.product.features.after', $product)}
                        {/if}
                    </div>
                </div>
                <div class="clearfix"><br></div>
                <div class="item-info-tabs">
                    <div class="info-tabs__top">
                        <ul>
                            {if $product.content != ''}
                            <li class="active">
                                <a href="javascript:;">{$t.shop.product.tab_description}</a>
                            </li>
                            {/if}
                            <li{if $product.content == ''} class="active"{/if}>
                                <a href="javascript:;">{$t.shop.product.tab_features}</a>
                            </li>
                            <li>
                                <a href="javascript:;">{$t.shop.product.tab_comments} ({$commentsTotal})</a>
                            </li>
                            <li>
                                <a href="javascript:;">{$t.shop.product.tab_video}</a>
                            </li>
                        </ul>
                    </div>
                    <div class="info-tabs__main">
                        {if $product.content != ''}
                        <div class="tab active tab1 cms-content clearfix">
                            {$product.content}
                            {$events->call('shop.product.content', $product)}
                            {*{include file="modules/shop/product_preferences.tpl"}*}
                        </div>
                        {/if}
                        <div class="tab tab2 cms-content">
                            {*<pre>{print_r($product.features)}</pre>*}
                            <div class="sp-features">
                                {assign var='features' value=array_chunk($product.features, 4)}
                                {foreach $features as $a}
                                    <ul>
                                        {foreach $a as $i=>$item}
                                            <li {if $i == 0}class="first"{/if}>
                                                <span>{$item.name}</span>
                                                <b>
                                                    {if $item.values|count}
                                                        {foreach $item.values as $v}
                                                            {$v.name}
                                                        {/foreach}
                                                    {/if}
                                                </b>
                                            </li>
                                        {/foreach}
                                    </ul>
                                {/foreach}
                            </div>
                        </div>
                        <div class="tab tab3 cms-content">
                            <div class="sp-comments">{$mod->comments->display($product.id)}</div>
                        </div>
                        <div class="tab tab4 cms-content">
                            {assign var ='video_1' value=$app->contentMeta->get($product.id, 'video_1', true)}
                            {assign var ='video_2' value=$app->contentMeta->get($product.id, 'video_2', true)}
                            {assign var ='video_3' value=$app->contentMeta->get($product.id, 'video_3', true)}
                            {if $video_1 != ''}
                                <div style="padding: 10px 0 10px 0;"><iframe width="100%" height="500" src="https://www.youtube.com/embed/{$video_1}" frameborder="0" allowfullscreen></iframe></div>
                            {/if}
                            {if $video_2 != ''}
                                <div style="padding: 0 0 10px 0;"><iframe width="100%" height="500" src="https://www.youtube.com/embed/{$video_2}" frameborder="0" allowfullscreen></iframe></div>
                            {/if}
                            {if $video_3 != ''}
                                <div style=""><iframe width="100%" height="500" src="https://www.youtube.com/embed/{$video_3}" frameborder="0" allowfullscreen></iframe></div>
                            {/if}
                        </div>
                    </div>
                </div>
                {include file="modules/shop/kits.tpl"}
                <div class="clear" style="height: 50px;"></div>
                {include file="modules/shop/widgets/accessories.tpl"}
                {include file="modules/shop/widgets/viewed.tpl"}
            </div>
            <!-- end single-product-page__content -->

            <!-- begin asider -->
            <aside class="asider">
                <div class="terms">
                    <div class="top-line">
                        <div class="text">АРТИКУЛ ТОВАРУ:</div>
                        <span class="number">{$product.sku}</span>
                    </div>
                    {include file="chunks/delivery.tpl"}
                </div>
                {*{include file="chunks/subscribe.tpl"}*}
                {$events->call('shop.product.sidebar', $product)}
            </aside>
            <!-- end asider -->
        </div>
    </div>
    <!-- end article-page -->

</div>
{$events->call('shop.product.footer', $product)}
<!-- end wrapper -->
{include file="chunks/footer.tpl"}
<script>
    Shop.viewed({$product.id});
</script>