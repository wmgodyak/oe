<div class="blog-header">
    <h1 class="blog-title">{$category.h1}</h1>
    <p class="lead blog-description">{$category.description}</p>
</div>

<div class="row">

    <div class="col-sm-8 blog-main">
        {foreach $category.posts as $post}
            {include file="modules/blog/post_item.tpl"}
        {/foreach}
        {$pagination}
    </div><!-- /.blog-main -->

    {include file="chunks/sidebar.right.tpl"}
</div><!-- /.row -->