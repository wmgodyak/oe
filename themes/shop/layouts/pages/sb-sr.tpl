{*
 * OYiEngine 7
 * @author admin mailto:vh@otakoyi.com
 * @copyright Copyright (c) 2017
 * Date: 2017-05-13T10:49:45+03:00
 * @name Sidebar right
 *}

{extends 'layouts/pages/fw.tpl'}
{block name=container}
    <div class="col-sm-8 col-md-9">
        {block name="content"}
            {$page.content}
        {/block}
    </div>
    <div class="col-sm-4 col-md-3">
        {block name="sidebar.content"}
            <p>Block: sidebar.content</p>
        {/block}
    </div>
{/block}
