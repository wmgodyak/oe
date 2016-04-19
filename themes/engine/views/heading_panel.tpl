{*{assign var="name" value="title_`$a.name`"}*}
<!--heading-->
<div class="dashboard-heading">
    <div class="dashboard-title">
        {*<h1><a href="dashboard"><i class="fa fa-home"></i></a> / <a href="content/{$controller}">{$t[$controller].action_index}</a> / Про нас</h1>*}
        <h1 class="breadcrumb">
            <a href="dashboard"><i class="fa fa-home"></i></a>
            {foreach $breadcrumb as $k=>$b}
                {if $b.url}
                   / <a href="{$b.url}">{$b.name}</a>
                {else}
                    <span class="item-{$k}">/ {$b.name}</span>
                {/if}
            {/foreach}
        </h1>
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