{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name post
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

                <h1>{$post.name}</h1>

                <span class="m_article-info">
                    <span class="article-info__date">
                       {strftime('%d', $post.created)} {$t.month[date('n', $post.created)]} {strftime('%Y', $post.created)}
                    </span>
                    <span class="article-info__views">
                        {$post.views} перегляди
                    </span>
                    <span class="article-info__comments">
                        4 коментарі
                    </span>
                </span>

                <div class="text cms-content">{$post.content}</div>

                <div class="autor-row">
                    Автор: <span>{$post.author.name}</span>
                </div>

                <div class="m_comments">
                    <div class="comments__counter">
                        <span>3 коментарі</span>
                    </div>
                    <form action="#">
                        <div class="row clearfix">
                            <div class="comments__avatar-block">
                                <div class="comments__avatar-img" style="background-image: url('{$theme_url}/assets/img/user/avatar1.jpg');">

                                </div>
                            </div>
                            <div class="comments__textarea-block input-group">
                                <textarea placeholder="Введіть текст повідомлення"></textarea>
                            </div>
                        </div>
                        <div class="row clearfix">
                            <div class="social__sighin">
                                <span>Увійти за допомогою:</span>
                                <div class="comments__social">
                                    <a class="comments__social-link comments__social-link--vk" href="#"></a>
                                    <a class="comments__social-link comments__social-link--fb" href="#"></a>
                                </div>
                            </div>
                            <div class="social__submit">
                                <button class="btn md disabled-gray">Коментувати</button>
                            </div>
                        </div>
                    </form>
                    <ul class="comments__list">
                        <li class="comments__item">
                            <div class="row clearfix">
                                <div class="comments__avatar-block">
                                    <div class="comments__avatar-img" style="background-image: url('{$theme_url}/assets/img/user/avatar2.jpg');">
                                    </div>
                                </div>
                                <div class="comments__content">
                                    <div class="row clearfix">
                                        <div class="comments__name">Меган Фокс</div>
                                        <div class="comments__date">два дні назад</div>
                                    </div>
                                    <div class="row">
                                        <div class="comments__text">
                                            Нічо собі новина! Круто, зробила так само, все працює. Є дві сімки + карта пам’яті. Тільки ви там
                                            обережно приклеюйте :)
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="comments__like-dislike">
                                            <a class="comments__like" href="#">3</a>
                                            <a class="comments__dislike" href="#">1</a>
                                        </div>
                                        <a class="comments__answer" href="#">Відповісти</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <ul class="comments__list comments__sublist">
                            <li class="comments__item comments__subitem ">
                                <div class="row clearfix">
                                    <div class="comments__avatar-block">
                                        <div class="comments__avatar-img" style="background-image: url('{$theme_url}/assets/img/user/avatar2.jpg');">
                                        </div>
                                    </div>
                                    <div class="comments__content">
                                        <div class="row clearfix">
                                            <div class="comments__name">Меган Фокс</div>
                                            <div class="comments__date">два дні назад</div>
                                        </div>
                                        <div class="row">
                                            <div class="comments__text">
                                                Сама собі відповіла на комент, о то я дура, нє?
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="comments__like-dislike">
                                                <a class="comments__like" href="#">10</a>
                                                <a class="comments__dislike" href="#">0</a>
                                            </div>
                                            <a class="comments__answer" href="#">Відповісти</a>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </ul>
                </div>

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
<script src="route/blog/setViewed/{$post.id}"></script>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}