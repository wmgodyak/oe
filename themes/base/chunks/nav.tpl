<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Oyi.Engine</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                {foreach $app->nav->get('main') as $item}
                    <li{if $page.id == $item.content_id} class="active"{/if}><a href="{$item.url}" title="{$item.title}">{$item.name}</a></li>
                {/foreach}
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>