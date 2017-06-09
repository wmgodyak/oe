{extends 'layouts/pages/sb-sr.tpl'}
{block name="body.class"}index-opt-1 cms-page cms-blog{/block}
{block name="main" prepend}
    <!-- breadcrumb -->
    <div class="container breadcrumb-page">
        <ol class="breadcrumb">
            <li><a href="Blog_Grid.html#">Home </a></li>
            <li class="active">Authentication</li>
        </ol>
    </div> <!-- breadcrumb -->
{/block}
{block name="content"}

    {if $errors|count}
        <div class="alert alert-error">
            {implode('<br>', $errors)}
        </div>
    {/if}
    {if $blog.search}
        {if $blog.category.total > 0}
            <p>We found {$category.total} results for query {$search.query}</p>
        {/if}
    {/if}

    <div class="post-grid">
        <div class="row post-items">
            {foreach $category.posts as $i=>$post}
                {include file="modules/blog/post.tpl"}
            {/foreach}
        </div>
    </div>
    {if $category.pagination}{$category.pagination->display()}{/if}
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}