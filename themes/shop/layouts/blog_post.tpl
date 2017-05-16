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
    <div class="blog-post wow fadeInUp">
        {assign var='img' value=$app->images->cover($blog.post.id, 'post')}
        {if !empty($img)}
            <img class="img-responsive" src="{$img}" alt="{$blog.post.title}">
        {/if}
        <h1>{$blog.post.name}</h1>
        <span class="author"><a href="{$app->page->url($blog.id)}/author/{$blog.post.author.id}">{$blog.post.author.name}</a></span>
        <span class="review">0 Comments</span>
        <span class="date-time">{date('d M, Y', $blog.post.published)}</span>
        <span class="review">
            Tags:
            {foreach $blog.post.tags as $k=>$tag}
                 <a href="{$app->page->url($blog.id)}/tag/{$tag.tag}">{$tag.tag}</a>
            {/foreach}
        </span>
        {$blog.post.content}

        <div class="social-media">
            <span>share post:</span>
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-linkedin"></i></a>
            <a href=""><i class="fa fa-rss"></i></a>
            <a href="" class="hidden-xs"><i class="fa fa-pinterest"></i></a>
        </div>
    </div>
    <div class="blog-post-author-details wow fadeInUp">
        <div class="row">
            <div class="col-md-2">
                {if $blog.post.author.avatar != ''}
                    <img src="{$blog.post.author.avatar}" alt="{$blog.post.author.name}"
                         class="img-circle img-responsive">
                {/if}
            </div>
            <div class="col-md-10">
                <h4>{$blog.post.author.name} {$blog.post.author.surname}</h4>
                <div class="btn-group author-social-network pull-right">
                    <span>Follow me on</span>
                    <button type="button" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="twitter-icon fa fa-twitter"></i>
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#"><i class="icon fa fa-facebook"></i>Facebook</a></li>
                        <li><a href="#"><i class="icon fa fa-linkedin"></i>Linkedin</a></li>
                        <li><a href=""><i class="icon fa fa-pinterest"></i>Pinterst</a></li>
                        <li><a href=""><i class="icon fa fa-rss"></i>RSS</a></li>
                    </ul>
                </div>
                <span class="author-job">Web Designer</span>
                <p>Integer sit amet commodo eros, sed dictum ipsum. Integer sit amet commodo eros. Lorem
                    ipsum dolor sit amet, consectetur adipiscing elit. Vestibul um quis convallis lorem,
                    ac volutpat magna. Suspendisse potenti.</p>
            </div>
        </div>
    </div>
    {$events->call('comments')}
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}