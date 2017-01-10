<!--heading-->
{*<pre>{print_r($breadcrumb)}</pre>*}
<div class="dashboard-heading">
    <div class="dashboard-title">
        {*<h1><a href="dashboard"><i class="fa fa-home"></i></a> / <a href="content/{$controller}">{$t[$controller].action_index}</a> / Про нас</h1>*}
        <h1 class="breadcrumb">
            <a href="dashboard"><i class="fa fa-home"></i></a>
            {foreach $breadcrumb as $k=>$b}
                {if $b.url}
                   / <a href="{$b.url}">{$b.name}</a>
                {else}
                    <span class="item-{$k} current">/ {$b.name}</span>
                {/if}
            {/foreach}
        </h1>
    </div>

    <div class="user-panel">
        <div class="user-panel_avatar admin-avatar">
            {if $admin.avatar != ''}<img src="{$admin.avatar}" alt="">{/if}
        </div>
        <div class="user-panel_arrow">
            <i class="fa fa-angle-down" aria-hidden="true"></i>
        </div>
        <div class="user-panel_dropdown">
            <ul>
                <li><a href="javascript:;" onclick="return false;" class="b-admin-profile">{$t.admin.profile}</a></li>
                <li><a href="admin/logout">{$t.admin.logout}</a></li>
            </ul>
        </div>
    </div>
    {if !empty($panel_nav)}
        <div class="btn-group">
            {foreach $panel_nav as $k=>$item}
                {$item}
            {/foreach}
        </div>
    {/if}
</div>
<!--end-->