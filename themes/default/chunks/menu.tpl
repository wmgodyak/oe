<div class="block-nav-menu">
    <ul class="ui-menu">
        {foreach $app->nav->get('main') as $nav}
        <li class="{if $nav.isfolder}parent{/if}">
            <a href="{$nav.url}" title="{$nav.title}">{$nav.name}</a>
            {if $nav.isfolder}
                <span class="toggle-submenu"></span>
                <ul class="submenu">
                    {foreach $nav.items as $item}
                    <li><a href="{$item.url}" title="{$item.title}">{$item.name}</a></li>
                    {/foreach}
                </ul>
            {/if}
        </li>
        {/foreach}
    </ul>
</div>