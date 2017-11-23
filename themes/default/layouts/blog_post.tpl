{extends 'layouts/index.tpl'}
{block name='container'}

    {include file="modules/breadcrumbs.tpl"}

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-12">

                    {block name="blog.post.content"}

                        <article class="post single-post-inner">

                            <div class="single-post-inner-title">
                                <h2>{$post.name}</h2>
                                <p class="single-post-meta">
                                    <i class="fa fa-user"></i>&nbsp; <a href="{$app->page->url($blog.id)}/author/{$post.author.id}">{$post.author.name}</a>
                                    &nbsp;<i class="fa fa-book"></i>
                                    &nbsp;
                                    {if $post.categories|count}
                                        {foreach $post.categories as $cat}
                                            <a href="{$cat.id}" title="{$cat.title}">{$cat.name}</a>
                                        {/foreach}
                                    {/if}
                                    &nbsp;<i class="fa fa-calendar"></i>
                                    &nbsp;{date('d M, Y', $post.published)}
                                    &nbsp;<i class="fa fa-eye"></i>
                                    &nbsp;{$post.views}
                                </p>
                            </div>

                            {assign var='img' value=$app->images->cover($post.id, 'post')}
                            {if !empty($img)}
                                <div class="post-inner-featured-content">
                                    <img alt="{$post.title}" src="{$img}">
                                </div>
                            {/if}


                            <div class="single-post-inner-content">
                                {$post.content}
                            </div>

                            <div class="single-post-inner-meta">
                                <div class="tag-list">
                                    {foreach $post.tags as $k=>$tag}
                                        <a href="blog/tag/{$tag.tag}">{$tag.tag}</a>
                                    {/foreach}
                                </div>
                            </div>

                        </article> <!--  end single-post-container -->

                        <div class="article-author clearfix">

                            <div class="topic-bold-header clearfix">
                                <h4>Написав <a href="blog/author/{$post.author.id}">{$post.author.name}</a></h4>
                            </div> <!-- end .topic-bold-header  -->

                            <figure class="author-avatar">
                                <a href="blog/author/{$post.author.id}">
                                    <img src="{$post.author.avatar}" alt="Avatar">
                                </a>
                            </figure>

                            <div class="about_author">
                                {$app->usersMeta->get($post.author.id, "blog_author_info_`$post.languages_id`", true)}
                            </div>

                        </div> <!-- end .article-author  -->

                        <div class="post-nav-section clearfix">

                            {if $post.next}
                                <a class="btn btn-primary fr" href="{$post.next.id}" title="{$post.next.title}">Наступна <i class="fa fa-angle-double-right"></i></a>
                            {/if}
                            {if $post.prev}
                                <a class="btn btn-primary" href="{$post.prev.id}" title="{$post.prev.title}"><i class="fa fa-angle-double-left"></i> Попередня</a>
                            {/if}

                        </div>

                        <div class="related-post">

                            <div class="topic-bold-header clearfix">
                                <h4>Схожі записи</h4>
                            </div> <!-- end .topic-bold-header  -->

                            <ul>
                                {foreach $post.related as $item}
                                <li><a href="{$item.id}" title="{$item.title}"> - {$item.name}</a></li>
                                {/foreach}
                            </ul>

                        </div> <!-- end .related-post  -->

                        {include file="modules/disqus.tpl"}

                    {/block}

                </div> <!--  end col-sm-8 -->

                <div class="col-md-4 col-sm-12">

                    {include file="modules/blog/sidebar/search.tpl"}
                    {include file="modules/blog/sidebar/categories.tpl"}
                    {include file="modules/blog/sidebar/tags.tpl"}

                </div> <!-- end .col-sm-4  -->

            </div> <!--  end row  -->

        </div> <!--  end container -->

    </section> <!-- end .main-content  -->
    <!-- START FOOTER  -->
    <a id="backTop">Вгору</a>
    <script src="blog/post/collect/{$post.id}"></script>
{/block}