<!--side navigation-->
<div class="main-navigation">
    <nav class="side-nav">
        {*<div class="wrap-first-level"></div>*}
        <ul class="first-level">
            {foreach $nav_items as $item}
            <li {if $item.isfolder}class="has-child"{/if}>
                <a href="./{$item.url}" {if $item.isfolder}onclick="return false;" {/if}>
                    {if $item.isfolder}<div class="toggle-child"><i class="fa fa-plus"></i></div>{/if}
                    <i class="fa {$item.icon}"></i>
                    <span>{$item.name}</span>
                </a>
                {if isset($item.items)}
                <ul class="second-level">
                    {foreach $item.items as $subitem}
                        <li><a href="./{$subitem.url}">{$subitem.name}</a></li>
                    {/foreach}
                </ul>
                {/if}
            </li>
            {/foreach}
            {*<li class="exit">*}
                {*<a href="admin/logout">*}
                    {*<i class="fa fa-power-off"></i>*}
                    {*<span>{$t.admin.logout}</span>*}
                {*</a>*}
            {*</li>*}
        </ul>
        <a href="admin/logout" class="exit">
            <i class="fa fa-power-off"></i>
            <span>{$t.admin.logout}</span>
        </a>
    </nav>
</div>
<!--end-->