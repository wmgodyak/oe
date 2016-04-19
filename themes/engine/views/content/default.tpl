<form action="{$form_action}" method="post" id="form" class="form-horizontal" {if $form_success}data-success = '{$form_success}'{/if}>
    {if isset($plugins.top)}
        <div class="row">
            <div class="col-md-12">
                {implode("\r\n", $plugins.top)}
            </div>
        </div>
    {/if}
    <div class="row">
        <div class="col-md-8">
            {include "content/blocks/main.tpl"}
            {if isset($plugins.after_main)}{implode("\r\n", $plugins.after_main)}{/if}
            {include "content/blocks/content.tpl"}
            {if isset($plugins.after_content)}{implode("\r\n", $plugins.after_content)}{/if}
            {include "content/blocks/meta.tpl"}
            {if isset($plugins.after_meta)}{implode("\r\n", $plugins.after_meta)}{/if}
        </div>
        <div class="col-md-4">
            {include "content/blocks/params.tpl"}
            {if isset($plugins.after_params)}{implode("\r\n", $plugins.after_params)}{/if}
            {include "content/blocks/features.tpl"}
            {if isset($plugins.after_features)}{implode("\r\n", $plugins.after_features)}{/if}
        </div>
    </div>
    {if isset($plugins.bottom)}
        <div class="row">
            <div class="col-md-12">
                {implode("\r\n", $plugins.bottom)}
            </div>
        </div>
    {/if}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" id="content_id" value="{$content.id}">
</form>