{if $nav.top}
<header class="navbar navbar-inverse {if $page.id==1}hero{else}normal{/if}" role="banner">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="1" class="navbar-brand">OYi.Engine7</a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
            <ul class="nav navbar-nav navbar-right">
                {foreach $nav.top as $item}
                <li {if $item.isfolder}class="dropdown"{/if}>
                    <a href="{$item.id}" title="{$item.title}" {if $item.isfolder}class="dropdown-toggle" data-toggle="dropdown"{/if}>
                        {$item.name} {if $item.isfolder}<b class="caret"></b>{/if}
                    </a>
                    {if $item.isfolder}
                    <ul class="dropdown-menu">
                        <li><a href="1">Home 1 (Current)</a></li>
                        <li><a href="index2.html">Home 2 (Slider)</a></li>
                        <li><a href="index3.html">Home 3 (Off-canvas menu)</a></li>
                    </ul>
                    {/if}
                </li>
                {/foreach}
            </ul>
        </nav>
    </div>
</header>
{/if}