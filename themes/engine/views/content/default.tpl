<form action="" method="post" id="form" class="form-horizontal">
    <div class="row">
        <div class="col-md-8">
            {include "content/blocks/main.tpl"}
            {include "content/blocks/meta.tpl"}
            {include "content/blocks/content.tpl"}
            {$plugins.content_main}
        </div>
        <div class="col-md-6">
            {include "content/blocks/params.tpl"}
            {$plugins.content_params}
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            {$plugins.bottom}
        </div>
    </div>
</form>