<form action="{$form_action}" method="post" id="form" class="form-horizontal" {if $form_success}data-success = '{$form_success}'{/if}>
    {$events->call('form.top', array($content))}
    <div class="row">
        <div class="col-md-8">
            {include "content/blocks/main.tpl"}
            {$events->call('content.main.after', array($content))}
            {include "content/blocks/content.tpl"}
            {$events->call('content.content.after', array($content))}
            {include "content/blocks/intro.tpl"}
            {$events->call('content.intro.after', array($content))}
            {include "content/blocks/meta.tpl"}
            {$events->call('content.meta.after', array($content))}
        </div>
        <div class="col-md-4">
            {include "content/blocks/params.tpl"}
            {$events->call('content.params.after', array($content))}
            {include "content/blocks/features.tpl"}
            {$events->call('content.features.after', array($content))}
        </div>
    </div>
    {$events->call('form.bottom', array($content))}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" id="content_id" value="{$content.id}">
</form>