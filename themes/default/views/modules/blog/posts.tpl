{if $page.id == 5}{$page.id=0}{/if}
{assign var='posts' value= $mod->blog->posts($page.id)}
{if $mod->blog->hasError()}
    <div style="height: 30px;"></div>
    <p style="text-align: center;">{implode('<br>', $mod->blog->getError())}</p>
{elseif $posts|count}
    <div class="m_news">
        <ul class="news__list">
            {foreach $posts as $post}
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
                                {$post.views * 1} {$t.blog.post_views}
                            </span>
                            {if $mod->blog->commentsEnabled}
                            <span class="article-info__comments">
                                {$post.comments.total} {$t.blog.post_comments}
                            </span>
                            {/if}
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
    {$mod->blog->pagination()}
    {else}
    <div class="no-records"><p>{$t.blog.no_records}</p></div>
{/if}
