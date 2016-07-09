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
                            {foreach $product.images as $k=>$img}
                                <div class="slider1-item" style="background-image: url('/{$img.path}source/{$img.image}');"></div>
                            {/foreach}
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
                                {$product.price} {$product.currency}
                            </div>
                        </div>
                        <div class="row">
                            <div class="bonus">
                                Ваш СМА бонус: <span>+0 {$product.currency}</span>
                            </div>
                        </div>
                        <div class="bnt-row">
                            <button class="btn sm red buy-btn">КУПИТИ</button>
                            <button class="btn sm white-red">Купити в 1 клік</button>
                        </div>
                        {$events->call('shop.product.buy.after', array($product))}
                        <span class="row comment-row">
                            <span class="m_star-rating">
                               <select class="star-rating read-only">
                                   <option value="1">1</option>
                                   <option value="2">2</option>
                                   <option value="3">3</option>
                                   <option value="4">4</option>
                                   <option value="5">5</option>
                               </select>
                           </span>
                            <span class="coment-counter">
                                3 відгуки
                            </span>
                        </span>
                        <div class="row">
                            <div class="short">
                                <div class="wrap">
                                    <span>{$t.shop.product.description}:</span>
                                    {$product.description}
                                </div>
                            </div>
                        </div>
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
                                <a href="javascript:;">{$t.shop.product.tab_comments}</a>
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

                            <img style="float: left; padding-left: 0;" src="{$theme_url}assets/img/product-article/1.jpg" alt="">
                            <h4>Чому у нас?</h4>
                            <p>
                                Це просто лише текст, який я
                                написав тут для того, щоб
                                глянути як він буде виглядати
                                і чи можливо додати до опису
                                зображення, от і все.
                            </p>
                            <p>
                                Чохол-книжка Book Cover Jeans виготовлений із якісного матеріалу та із урахуванням всіх особливостей
                                дизайну більшості телефонів Чохол щільно прилягає до корпусу смартфону та надійно захищає з усіх сторін
                                Ваш телефон від подряпин, потертостей та різноманітних забрудень, а також зменшує рівень рівня
                            </p>

                            <img style="float: left; padding-left: 0;" src="{$theme_url}assets/img/product-article/2.jpg" alt="">
                            <h4>Чому у нас?</h4>
                            <p>
                                Це просто лише текст, який я
                                написав тут для того, щоб
                                глянути як він буде виглядати
                                і чи можливо додати до опису
                                зображення, от і все
                            </p>

                        </div>
                        <div class="tab tab2 cms-content">
                            <p>slide2</p>
                        </div>
                        <div class="tab tab3 cms-content">
                            <p>slide3</p>
                        </div>
                        <div class="tab tab4 cms-content">
                            <p>slide4</p>
                        </div>
                    </div>
                </div>
                {*
                <div class="promotion-banner">
                    <div class="heading">
                        Разом дешевше!
                    </div>
                    <div class="promotion-banner-wrap">
                        <div class="content">
                            <div class="item item1">
                                <div class="img-block">
                                    <div class="img" style="background-image: url('{$theme_url}assets/img/TOVARS/1.jpg');">

                                    </div>
                                </div>
                                <div class="name">
                                    Чохол універсальний
                                    Universal Book Cover
                                    Jeans Blue
                                </div>
                                <div class="price-row">
                                    <div class="price">86,00 грн</div>
                                </div>
                            </div>
                            <div class="item item2">
                                <div class="img-block">
                                    <div class="img" style="background-image: url('{$theme_url}assets/img/TOVARS/2.jpg');">

                                    </div>
                                </div>
                                <div class="name">
                                    Захисне скло
                                    Універсальне 4,7″
                                    (132x64x0.3мм)
                                </div>
                                <div class="price-row">
                                    <div class="old-price">50,00 грн</div>
                                    <div class="price">86,00 грн</div>
                                </div>
                            </div>
                            <div class="equals">
                                <div class="row">
                                    <div class="new-price">
                                        130 грн
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="old-price">
                                        136 грн
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="result-block">
                            <div class="wrap">
                                <span>Ви економите 6 грн.</span>
                                <div class="text">
                                    Замовляйте комплекти
                                    та платіть дешевше
                                </div>
                                <div class="btn-row">
                                    <button class="btn md red">Купити комплект</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                *}
            </div>
            <!-- end single-product-page__content -->

            <!-- begin asider -->
            <aside class="asider">

                <div class="terms">

                    <div class="top-line">
                        <div class="text">АРТИКУЛ ТОВАРУ:</div>
                        <span class="number">142804</span>
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
<!-- end wrapper -->
{include file="chunks/footer.tpl"}