<div class="sidebar-widget outer-bottom-xs wow fadeInUp">
    <h3 class="section-title">Popular posts</h3>
    {foreach $app->module->blog->posts->popular(2) as $post}
        <div class="blog-post inner-bottom-30 ">
            {assign var='img' value=$app->images->cover($post.id, 'post')}
            {if $img}
                <img class="img-responsive" src="{$img}" alt="">
            {/if}
            <h4><a href="{$post.url}">{$post.name}</a></h4>
            <span class="author">{$post.author.name}</span>
            <span class="review">6 Comments</span>
            <span class="date-time">{date('d M, Y', $post.published)}</span>
            {$post.intro}
        </div>
    {/foreach}
</div>