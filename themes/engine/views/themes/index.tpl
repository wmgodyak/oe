<div class="themes row">
    {foreach $items as $item}
    <div class="col-md-4 theme {$item.current} ">
        <section class="panel panel-default panel-block">
            <div class="panel-heading text-overflow-hidden">
                <div class="screenshot">
                    <img src="{$item.urlpath}screenshot.png"/>
                    <div class="description">
                        <div class="author">{$t.themes.author} {$item.author}</div>
                        <div class="version">{$t.themes.version} {$item.version}</div>
                        <div class="info">{$item.description}</div>
                    </div>
                </div>
                <h3 class="name">{$item.name}</h3>
                {if $item.current == ''}
                    <div class="actions">
                        <a onclick="return false;"
                           data-theme="{$item.theme}"
                           class="btn btn-success b-themes-activate"
                           href="javascript:void(0);"
                        ><i class="fa fa-download"></i> {$t.themes.activate}</a>
                    </div>
                    {else}
                    <div class="actions">
                        <a
                           title="{$t.themes.edit}"
                           class="btn btn-primary"
                           href="themes/edit/{$item.theme}"
                        ><i class="fa fa-code"></i> {$t.themes.edit}</a>
                    </div>
                {/if}
            </div>
        </section>
    </div>
    {/foreach}
</div>