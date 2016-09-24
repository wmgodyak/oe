{assign var='posts' value=$mod->blog->latestPosts(0, 0, 3)}
{if $posts|count}
<!-- begin main-articles -->
<div class="main-articles">

    <div class="container">

        <div class="heading">{$t.blog.widget_title}</div>
        <a class="show-all-news" href="5">{$t.blog.widget_more}</a>
        <ul class="main-news__list">
            {foreach $posts as $post}
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
                                {assign var='m' value={date('n', $post.created)}}
                                {date('d', $post.created)} {$t.month[$m]} {date('Y', $post.created)}
                            </span>
                        </span>
                </a>
            </li>
            {/foreach}
        </ul>

        <a class="show-all-news xs" href="5">{$t.blog.widget_more}</a>

        {include file="chunks/main_about.tpl"}

    </div>

</div>
<!-- end main-articles -->
{/if}