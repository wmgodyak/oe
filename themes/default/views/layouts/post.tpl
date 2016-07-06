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
                        {$post.views} {$t.blog.post_views}
                    </span>
                    <span class="article-info__comments">
                        {$post.comments.total} {$t.blog.post_comments}
                    </span>
                </span>

                <div class="text cms-content">{$post.content}</div>

                <div class="autor-row">
                    {$t.blog.author}: <span>{$post.author.name}</span>
                </div>

                {$mod->comments->display($post.id)}

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