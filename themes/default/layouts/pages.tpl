{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}

{extends 'layouts/pages/sb-sr.tpl'}
{block name="container" prepend}
    <div class="breadcrumb">
        <div class="container">
            <div class="breadcrumb-inner">
                <ul class="list-inline list-unstyled">
                    <li><a href="1">{$app->page->name(1)}</a></li>
                    <li class='active'>{$app->page->name($page.id)}</li>
                </ul>
            </div><!-- /.breadcrumb-inner -->
        </div><!-- /.container -->
    </div>
    <!-- /.breadcrumb -->
{/block}

{block name="content"}
    <div class="blog-post wow fadeInUp animated" style="visibility: visible; animation-name: fadeInUp;">
        {assign var="img" value=$app->images->cover($page.id, 'post')}
        {if $img}
            <img class="img-responsive" src="{$img}" alt="">
        {/if}
        <h1>{$page.name}</h1>

        {$page.content}
    </div>
{/block}
{block name="sidebar.content"}
    {include file="modules/blog/sidebar.tpl"}
{/block}