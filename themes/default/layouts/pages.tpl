{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{extends 'layouts/index.tpl'}
{block name="body"}
    <div class="blog-header">
        <h1 class="blog-title">{$page.h1}</h1>
        <p class="lead blog-description">{$page.content}</p>
    </div>

    <div class="row">
        <div class="col-sm-8 blog-main">
            {assign var='posts' value=$app->module->blog->posts(0, 4)}
            {foreach $posts as $post}
                {include file="modules/blog/post_item.tpl"}
            {/foreach}
            <div class="row blog-main-more">
                <div class="col md-12 text-center">
                    <button class="btn btn-primary blog-more">More</button>
                </div>
            </div>
        </div><!-- /.blog-main -->

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <div class="sidebar-module sidebar-module-inset">
                <h4>{$app->page->name(2)}</h4>
                {$app->page->intro(2)}
            </div>
            {include file="modules/blog/sidebar.tpl"}
        </div><!-- /.blog-sidebar -->
    </div><!-- /.row -->
{/block}