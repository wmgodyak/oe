{*
 * OYiEngine 7
 * @author admin mailto:vh@otakoyi.com
 * @copyright Copyright (c) 2017
 * Date: 2017-05-13T10:49:29+03:00
 * @name Sidebar left
 *}

{extends 'layouts/pages/fw.tpl'}
{block name=container}
    <div class="row">
        <div class="col-sm-8 col-sm-push-4 col-md-9 col-md-push-3">
            {block name="content"}
                {$page.content}
            {/block}
        </div><!-- main -->
        <div class="col-sm-4 col-sm-pull-8 col-md-3 col-md-pull-9">
            {block name="sidebar.content"}
                <p>Block: sidebar.content</p>
            {/block}
        </div>
    </div>
{/block}
