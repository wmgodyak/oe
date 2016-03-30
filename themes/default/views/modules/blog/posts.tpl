{foreach $blog.posts as $post}
    <div class="post">
        {if $post.image}
            <a href="{$post.id}" class="pic">
                <img src="{$post.image}" class="img-responsive" alt="blogpost" />
            </a>
        {/if}

        <div class="title">
            <a title="{$post.title}" href="{$post.id}">{$post.name}</a>
        </div>
        <div class="author">
            <img src="{$post.author_avatar}" class="avatar" alt="author" />
            {$post.author_name}, {$post.published}
        </div>
        <p class="intro">
            {$post.description}
        </p>
        <a href="{$post.id}" class="continue-reading">{$t.blog.readmore}</a>
    </div>
{/foreach}