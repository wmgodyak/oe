<!-- begin main-articles -->
<div class="main-articles">

    <div class="container">

        <div class="heading">{$t.blog.widget_title}</div>
        <a class="show-all-news" href="5">{$t.blog.widget_more}</a>
        <ul class="main-news__list">
            {foreach $mod->blog->latestPosts(0, 0, 3) as $post}
            <li class="main-news__item">
                <a class="main-news__link" href="{$post.id}" title="{$post.title}">
                        <span class="main-news__img-block">
                            <img style="max-width: 132px;" class="main-news__img" src="{$app->images->cover($post.id, 'post')}" alt="{$post.title}">
                        </span>
                        <span class="main-news__text-block">
                            <span class="main-news__heading">
                                {$post.name}
                            </span>
                            <span class="main-news__content-text">
                                {$post.intro}
                            </span>
                            <span class="main-news__date">
                                18 березня 2016
                            </span>
                        </span>
                </a>
            </li>
            {/foreach}
        </ul>

        <a class="show-all-news xs" href="5">{$t.blog.widget_more}</a>

        <div class="main-about-us">

            <div class="about-us__left-banner">
                <div class="wrap">
                    <div class="left-block">
                        <div class="img-block">
                            <img src="{$theme_url}/assets/img/seo_logo.png" alt="">
                            <span>Завжди обирай краще!</span>
                        </div>
                    </div>

                    <div class="right-block">
                        <div class="benefits__list">
                            <div class="benefits__item">
                                <div class="benefits__icon i1"></div>
                                <div class="benefits__text">Доступно</div>
                            </div>
                            <div class="benefits__item">
                                <div class="benefits__icon i2"></div>
                                <div class="benefits__text">Сучасно</div>
                            </div>
                            <div class="benefits__item">
                                <div class="benefits__icon i3"></div>
                                <div class="benefits__text">Якісно</div>
                            </div>
                            <div class="benefits__item">
                                <div class="benefits__icon i4"></div>
                                <div class="benefits__text">Швидко</div>
                            </div>
                        </div>
                        <div class="description">
                            Купуючи продукцію в СМА, Ви стаєте для нас важливим
                            клієнтом та маєте шанс отримати знижки і бути учасником
                            наших акцій. Обирайте саме те, що вам потрібно.
                        </div>
                    </div>
                </div>
            </div>
            <div class="about-us__right-banner">

                <div class="heading">
                    Інтернет-магазин «Світ Мобільних Аксесуарів»
                </div>

                <div class="content">
                    У інтернет-магазині СМА ви завжди можете замовити аксесуари та запчастини для вашого
                    телефону чи планшету. Також ми пропонуємо вам якісний ремонт телефонів, планшетів та
                    цифрових фотоапаратів із гарантією якості. Ми доставимо ваші замовлення у будь-яку точку
                    України (Львів, Тернопіль, Рівне, Івано-Франківськ, Житомир, Київ, Одеса, Полтава, Чернігів,
                    Суми, Хмельницький, Вінниця, Чернівці,). Звертайтесь у Світ Мобільних Аксесуарів і Вам
                    завжди радо допоможуть та нанадуть необхідні консультації.
                </div>

                <div class="address-row">
                    Вул. Наукова 7а, Офіс №124. <a href="#">Детальніше про нас</a>
                </div>
            </div>
        </div>

    </div>

</div>
<!-- end main-articles -->