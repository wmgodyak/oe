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
    {if $errors|count}
        <div class="alert alert-error">
            {implode('<br>', $errors)}
        </div>
    {/if}
    {if $blog.search}
        {if $blog.category.total > 0}
            <p>We found {$blog.category.total} results for query {$blog.search.query}</p>
        {/if}
    {/if}
    {foreach $blog.category.posts as $i=>$post}
        {include file="modules/blog/post.tpl"}
    {/foreach}
    {if $blog.pagination}{$blog.pagination->display()}{/if}
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}