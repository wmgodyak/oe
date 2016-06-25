<form action="{$form_action}" method="post" id="form" class="form-horizontal" {if $form_success}data-success = '{$form_success}'{/if}>
    {$events->call('form.top', array($content))}
    <div class="row">
        <div class="col-md-8">
            {if $form_display_blocks.main}
                {include "content/blocks/main.tpl"}
                {$events->call('content.main.after', array($content))}
            {/if}
            {if $form_display_blocks.content}
                {include "content/blocks/content.tpl"}
                {$events->call('content.content.after', array($content))}
            {/if}
            {if $form_display_blocks.intro}
                {include "content/blocks/intro.tpl"}
                {$events->call('content.intro.after', array($content))}
            {/if}
            {if $form_display_blocks.meta}
                {include "content/blocks/meta.tpl"}
                {$events->call('content.meta.after', array($content))}
            {/if}
        </div>
        <div class="col-md-4">
            {if $form_display_blocks.params}
                {include "content/blocks/params.tpl"}
                {$events->call('content.params.after', array($content))}
            {/if}
            {if $form_display_blocks.features}
                {include "content/blocks/features.tpl"}
                {$events->call('content.features.after', array($content))}
            {/if}
        </div>
    </div>
    {$events->call('form.bottom', array($content))}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" id="content_id" value="{$content.id}">
</form>