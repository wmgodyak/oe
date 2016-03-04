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
            {include "content/blocks/meta.tpl"}
            {include "content/blocks/content.tpl"}
            {if isset($plugins.main)}{implode("\r\n", $plugins.main)}{/if}
        </div>
        <div class="col-md-4">
            {include "content/blocks/params.tpl"}
            {if isset($plugins.params)}{implode("\r\n", $plugins.params)}{/if}
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
</form>