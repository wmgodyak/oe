<form action="{$form_action}" method="post" id="form" class="form-horizontal" {if $form_success}data-success = '{$form_success}'{/if}>
    <div class="row">
        <div class="col-md-8">
            {include "content/blocks/main.tpl"}
            {include "content/blocks/meta.tpl"}
            {include "content/blocks/content.tpl"}
            {$plugins.content_main}
        </div>
        <div class="col-md-4">
            {include "content/blocks/params.tpl"}
            ----  plugins.content_params -----
            {$plugins.content_params}
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            ----  plugins.bottom -----
            {$plugins.bottom}
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>