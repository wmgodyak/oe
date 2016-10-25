<div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
</div>
<div class="navbar-collapse collapse">
    <ul class="nav navbar-nav text-right">
        {foreach $app->nav->get('main') as $item}
        <li{if $item.isfolder} class="dropdown"{/if}>
            <a href="{$item.url}" title="{$item.title}" target="{$item.target}" {if $item.isfolder}  class="dropdown-toggle" data-toggle="dropdown"{/if}>{$item.name}{if $item.isfolder}<b class="caret"></b>{/if}</a>
            <ul {if $item.isfolder}class="dropdown-menu"{/if}>
                {if $item.isfolder}
                    {foreach $item.items as $child}
                        <li><a href="{$child.url}" title="{$child.title}">{$child.name}</a></li>
                    {/foreach}
                {/if}
            </ul>
        </li>
        {/foreach}
    </ul>
</div>