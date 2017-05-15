{extends 'layouts/pages/sb-sr.tpl'}
{block name="content"}
    <div class="blog-post wow fadeInUp animated" style="visibility: visible; animation-name: fadeInUp;">
        {assign var="img" value=$app->images->cover($page.id, 'post')}
        {if $img}
        <img class="img-responsive" src="{$img}" alt="">
        {/if}
        <h1>{$page.h1}</h1>
        {$page.content}
    </div>
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}