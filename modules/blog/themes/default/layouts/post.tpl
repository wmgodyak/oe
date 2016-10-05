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

                <h1>{$post.name}{if $smarty.session.engine.admin.id > 0}&nbsp;<a title="Редагувати в адмінстративній частині" target="_blank" href="/engine/module/run/blog/edit/{$page.id}">
                        <img src="{$theme_url}/assets/img/pencil.png" alt=""></a>{/if}</h1>

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

            {include file="modules/blog/sidebar.tpl"}

        </div>

    </div>
    <!-- end article-page -->

</div>
<script src="route/blog/setViewed/{$post.id}"></script>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}