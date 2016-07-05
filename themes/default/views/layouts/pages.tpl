{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}


    <!-- begin article-page -->
    <div class="article-page">

        <!-- begin m_pagination -->
        <div class="m_breadcrumbs">
            <div class="container">
                <ul class="breadcrumbs__list">
                    <li class="breadcrumbs__item">
                        <a href="#" class="breadcrumbs__link">Головна</a>
                    </li>
                    <li class="breadcrumbs__item breadcrumbs__item--current">
                        <a href="#" class="breadcrumbs__link">Новини та акції</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- end m_pagination -->

        <div class="container">

            <!-- begin article-page__content -->
            <div class="article-page__content">

                <h1>{$page.name}</h1>

                <div class="text cms-content">{$page.content}</div>
            </div>
            <!-- end article-page__content -->

            <!-- begin asider -->
            <aside class="asider">
                <div class="vk-widget">

                </div>
                <div class="fb-widget">

                </div>
                <div class="m_discount-widget">
                    <div class="discount__heading1">
                        Ви у нас вперше?
                    </div>
                    <div class="discount__content">
                        <div class="discount__img-block">
                            <div class="discount__img" style="background-image: url('{$theme_url}/assets/img/discount-widget/img1.png');"></div>
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
                <div class="weather-widget"></div>
            </aside>
            <!-- end asider -->

        </div>

    </div>
    <!-- end article-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}