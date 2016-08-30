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
                        <div class="product-slider1">
                            {if $product.images|count > 0}
                                {foreach $product.images as $k=>$img}
                                    <div class="slider1-item" style="background-image: url('/{$img.path}source/{$img.image}');"></div>
                                {/foreach}
                                {else}
                                <div class="slider1-item" style="background-image: url('/uploads/noimage.jpg');"></div>
                            {/if}
                        </div>

                        {if $product.images|count > 1}
                        <div class="product-slider2">
                            {foreach $product.images as $k=>$img}
                                <div class="slider2-item" style="background-image: url('/{$img.path}thumbs/{$img.image}');"></div>
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
                            <button class="btn sm white-red buy-one-click" data-has-variants="{$product.has_variants}" data-id="{$product.id}">Купити в 1 клік</button>
                        </div>
                        {else}
                        <div class="bnt-row">
                            <button class="btn sm to-wait-list"
                                    data-id="{$product.id}"
                                    data-has-variants="{$product.has_variants}"
                                    title="Повідомте про появу">Повідомте про появу</button>
                            </div>
                        {/if}
                        {$events->call('shop.product.buy.after', array($product))}
                        {assign var='avRate' value=$mod->comments->getAverageRating($product.id)|ceil}
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
                        {if $product.description !=''}
                        <div class="row">
                            <div class="short">
                                <div class="wrap">
                                    <span>{$t.shop.product.description}:</span>
                                    {$product.description}
                                </div>
                            </div>
                        </div>
                        {/if}
                    </div>
                </div>

                <div class="item-info-tabs">
                    <div class="info-tabs__top">
                        <ul>
                            <li class="active">
                                <a href="javascript:;">{$t.shop.product.tab_description}</a>
                            </li>
                            <li>
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
                        <div class="tab active tab1 cms-content clearfix">
                            {$product.content}
                            {$events->call('shop.product.content', array($product))}

                            {include file="chunks/product_preferences.tpl"}
                        </div>
                        <div class="tab tab2 cms-content">
                            {*<pre>{print_r($product.features)}</pre>*}
                            <table class="table">
                                {foreach $product.features as $item}
                                <tr>
                                    <td>{$item.name}</td>
                                    <td>
                                        {if $item.values|count}
                                            {foreach $item.values as $v}
                                                {$v.name}
                                            {/foreach}
                                        {/if}
                                    </td>
                                </tr>
                                {/foreach}
                            </table>
                        </div>
                        <div class="tab tab3 cms-content">
                            {$mod->comments->display($product.id)}
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

                    <div class="content">
                        <div class="heading">
                            Доставка, оплата, гарантії
                        </div>

                        <div class="info-block">
                            <div class="block-heading">
                                Доставка, оплата, гарантії
                            </div>
                            <div class="text">
                                <ul>
                                    <li>Кур’єром по місту — 40 грн</li>
                                    <li>Від 250 — безкоштовно</li>
                                    <li>Пункт видачі — м. Львів,
                                        вул. Наукова 7а, офіс №124</li>
                                    <li>Поштовими службами
                                        «Нова Пошта» та «Укрпошта»</li>
                                </ul>
                            </div>
                        </div>

                        <div class="info-block">
                            <div class="block-heading">
                                Оплата:
                            </div>
                            <div class="text cms-content">
                                <ul>
                                    <li>Кур’єру при доставці товару</li>
                                    <li>Продавцю при самовивезенні</li>
                                    <li>На картку ПриватБанку</li>
                                    <li>При отриманні товару у
                                        відділеннях «Нової Пошти»</li>
                                </ul>
                            </div>
                        </div>

                        <div class="info-block">
                            <div class="block-heading">
                                Гарантії:
                            </div>
                            <div class="text">
                               <span class="span1">
                                   У випадку помилки і доставки
                                   товару що не відповідає
                                   замовленому (пересорт, недостача
                                   тощо), покупець повинен
                                   повідомити про це продавця
                                   протягом 2 робочих днів!
                               </span>
                                <span class="span2">
                                    Дізнатись більше можна <a href="#">ТУТ</a>
                                </span>
                            </div>
                        </div>

                    </div>

                </div>

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