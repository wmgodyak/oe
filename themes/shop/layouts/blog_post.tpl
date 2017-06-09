{extends 'layouts/pages/sb-sr.tpl'}
{block name="container" prepend}
    <div class="breadcrumb">
        <div class="container">
            <div class="breadcrumb-inner">
                <ul class="list-inline list-unstyled">
                    <li><a href="#">Home</a></li>
                    <li class='active'>Blog</li>
                </ul>
            </div><!-- /.breadcrumb-inner -->
        </div><!-- /.container -->
    </div>
    <!-- /.breadcrumb -->
{/block}
{block name="content"}
    <div class="post-detail">
        <div class="post-item-info">
            {assign var='img' value=$app->images->cover($post.id, 'post')}
            {if !empty($img)}
                <div class="post-item-photo">
                    <img class="img-responsive" src="{$img}" alt="{$post.title}">
                </div>  
            {/if}
            <div class="post-item-detail">
                <strong class="post-item-name">
                    <h1>{$post.name}</h1>
                </strong>
                <div class="post-item-athur">
                    By <a href="{$app->page->url($id)}/author/{$post.author.id}">{$post.author.name}</a> - {date('d M, Y', $post.published)}
                </div>
                <div class="post-item-des">{$post.content}</div>
                <div class="clearfix">
                    <div class="post-item-tag">
                        <label for="">Tags:</label>
                        {foreach $post.tags as $k=>$tag}
                            <a href="{$app->page->url($id)}/tag/{$tag.tag}">{$tag.tag}</a>
                        {/foreach}
                    </div>
                    <div class="post-item-share">
                        <label>Share:</label>
                        <a href="{$post.url}"><i aria-hidden="true" class="fa fa-facebook"></i></a>
                        <a href="{$post.url}"><i aria-hidden="true" class="fa fa-twitter"></i></a>
                        <a href="{$post.url}"><i aria-hidden="true" class="fa fa-google-plus"></i></a>
                        <a href="{$post.url}"><i aria-hidden="true" class="fa fa-pinterest"></i></a>
                        <a href="{$post.url}"><i aria-hidden="true" class="fa fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {$events->call('comments')}
    <script src="blog/post/collect/{$post.id}"></script>
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}