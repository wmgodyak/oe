<div class="m_news">
    <ul class="news__list">
        {foreach $mod->blog->posts($page.id) as $post}
        <li class="news__item">
            <a href="{$post.id}" title="{$post.title}" class="news__link">
                <span class="news__img-block">
                    <span class="news__img" style="background-image: url('{$app->images->cover($post.id, 'post')}');"></span>
                </span>

                <span class="news__content">
                    <span class="news__heading">{$post.name}</span>
                    <span class="m_article-info">
                        <span class="article-info__date">
                            {strftime('%d', $post.created)} {$t.month[date('n', $post.created)]} {strftime('%Y', $post.created)}
                        </span>
                        <span class="article-info__views">
                            32 {$t.blog.post_views}
                        </span>
                        <span class="article-info__comments">
                            4 {$t.blog.post_comments}
                        </span>
                    </span>
                    <span class="news__text">
                        {strip_tags($post.intro)}... <span class="news__read-more">{$t.blog.post_readmore}</span>
                    </span>
                </span>
            </a>
        </li>
        {/foreach}
    </ul>
</div>