<!--heading-->
<div class="dashboard-heading">
    <div class="dashboard-title">
        <i class="fa fa-file-o"></i>
        <h1>{$name}</h1>
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