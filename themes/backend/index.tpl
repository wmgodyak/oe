<!DOCTYPE html>
<html data-controller="{$controller}" data-action="{$action}">

{include file="chunks/head.tpl"}

<body class="ct-{$controller} ac-{$action}">
    {block name=body}
        {if $controller == 'admin' && $action == 'login'}
            {$body}
        {else}
            <div class="dashboard">
                {$nav}
                <div class="page">
                    {block name="sidebar"}
                        {if isset($sidebar)}
                        <div class="sidebar sidebar-open">
                            <div class="toggle-btn">
                                <i class="fa fa-chevron-left"></i>
                            </div>
                            <div class="sidebar-heading">
                                <img src="{$theme_url}assets/img/logo/logo-black.png">
                            </div>
                            {if isset($sidebar)}{$sidebar}{/if}
                        </div>
                        {/if}
                    {/block}
                    <div class="dashboard-content {if isset($sidebar)} sidebar-open{/if}">
                        <div class="content-wrapper"> <!--dashboard-->
                            {block name="panel"}{$heading_panel}{/block}
                            {block name="notifications"}<div class="inline-notifications">{if isset($global_notifications)}{$global_notifications}{/if}</div>{/block}
                            {$events->call('global.top')}
                            {block name="content"}{$body}{/block}
                            {$events->call('global.bottom')}
                        </div> <!--end-->
                        <footer>
                            <div class="copyright">
                                {$t.system.copyright}
                            </div>
                        </footer>
                    </div>
                </div>
            </div>
        {/if}
    {/block}

    {include file="chunks/scripts.tpl"}
</body>
</html>