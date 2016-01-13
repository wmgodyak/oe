<!--heading-->
<div class="dashboard-heading">
    <div class="dashboard-title">
        <i class="fa fa-file-o"></i>
        <h1>{$name}</h1>
    </div>
    {if !empty($panel_nav)}
        <div class="btn-group">
            {foreach $panel_nav as $item}
                {if $item.type == 'button'}
                    <button type="button" {$item.args}>{if $item.icon}<i class="fa {$item.icon}"></i> {/if}{$item.name}</button>
                {elseif $item.type == 'link'}
                    <a {$item.args}>{if $item.icon}<i class="fa {$item.icon}"></i> {/if}{$item.name}</a>
                {/if}
            {/foreach}
        </div>
    {/if}
</div>
<!--end-->