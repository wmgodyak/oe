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
<<<<<<< HEAD
    {if !empty($panel_nav)}
        <div class="user-panel">
            <div class="user-panel_avatar">
                <!--<img src="" alt="">-->
            </div>
            <div class="user-panel_arrow">
                <i class="fa fa-angle-down" aria-hidden="true"></i>
            </div>
            <div class="user-panel_dropdown">
                <ul>
                    <li><a href="#">Повідомлення</a></li>
                    <li><a href="#">Налаштування</a></li>
                    <li><a href="#">Вихід</a></li>
                </ul>
            </div>
        </div>
=======

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
>>>>>>> 7fa771e0b506f991de2db29d75d140e55dfc7847
        <div class="btn-group">
            {foreach $panel_nav as $k=>$item}
                {$item}
            {/foreach}
        </div>
    {/if}
</div>
<!--end-->