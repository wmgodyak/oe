<div class="row">
    <div class="col-md-8">
        {include "com/main.tpl"}
        {include "com/meta.tpl"}
        {include "com/content.tpl"}
        {$plugins.content_main}
    </div>
    <div class="col-md-6">
        {include "com/params.tpl"}
        {$plugins.content_params}
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        {$plugins.bottom}
    </div>
</div>