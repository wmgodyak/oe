{assign var="posts" value=$app->module->mainPosts->get()}
{if $posts|count}
<!--post-slider-->
<section id="myCarousel" class="carousel slide post-slider">
    <div class="container">
        <div class="carousel-inner">
            {foreach $posts as $k=>$post}
            <div class="item {if $k == 0}active{/if}">
                <div class="post-slider-image"><img alt="car1" src="{$app->images->cover($post.id, 'post')}"></div>
                <div class="post-slider-text">
                    <div class="post-slider-title">
                        <h2><a href="{$post.id}">{$post.name}</a></h2>
                    </div>
                    <div class="post-meta-elements">
                        <div class="meta-post-author">
                            <i class="fa fa-user"></i><a href="11?author={$post.author.id}">{$post.author.name}</a>
                        </div>
                        <div class="meta-post-cat">
                            <i class="fa fa-tags"></i>
                            {foreach $post.categories as $i=>$category}
                                <a href="{$category.id}">{$category.name}</a>{if isset($post.categories[$i+1])}, {/if}
                            {/foreach}
                        </div>
                        <div class="meta-post-date">
                            <i class="fa fa-clock-o"></i>{date('M d, Y', $post.created)}
                        </div>
                    </div>
                    <div class="post-slider-content">
                        {$post.intro}
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </div>
</section>
<!--post-slider-end-->
{/if}