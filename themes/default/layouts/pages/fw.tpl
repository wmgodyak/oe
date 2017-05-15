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

    <div class="{block name="body.class"}body-content outer-top-xs{/block}" id="{block name="body.id"}top-banner-and-menu{/block}">
        <div class="container">
            {block name="container"}
                <p>Block name: container</p>
            {/block}
        </div><!-- /.container -->
    </div><!-- /#top-banner-and-menu -->

    {include file="chunks/footer.tpl"}
{/block}
