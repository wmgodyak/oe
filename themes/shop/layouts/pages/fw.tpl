{*
 * OYiEngine 7
 * @author admin mailto:vh@otakoyi.com
 * @copyright Copyright (c) 2017
 * Date: 2017-05-13T10:49:29+03:00
 * @name Sidebar left
 *}

{extends 'layouts/index.tpl'}
{block name=body}
    {include file="chunks/header.tpl"}
    {block name="main"}
        <main class="{block name="main.class"}site-main{/block}">
            <div class="container">
                {block name="container"}
                    {$page.content}
                {/block}
            </div><!-- /.container -->
        </main>
    {/block}
    {include file="chunks/footer.tpl"}
{/block}
