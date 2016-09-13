<form action="{$form_action}" method="post" id="form" class="form-horizontal" {if $form_success}data-success = '{$form_success}'{/if}>
    {$events->call('form.top', $content)}
    <div class="row">
        <div class="col-md-8">
            {if $form_display_blocks.main}
                {$events->call('content.main.before', $content)}
                {include "content/blocks/main.tpl"}
                {$events->call('content.main.after', $content)}
            {/if}
            {if $form_display_blocks.content}
                {$events->call('content.content.before', $content)}
                {include "content/blocks/content.tpl"}
                {$events->call('content.content.after', $content)}
            {/if}
            {if $form_display_blocks.intro}
                {$events->call('content.intro.before', $content)}
                {include "content/blocks/intro.tpl"}
                {$events->call('content.intro.after', $content)}
            {/if}
            {if $form_display_blocks.meta}
                {$events->call('content.meta.before', $content)}
                {include "content/blocks/meta.tpl"}
                {$events->call('content.meta.after', $content)}
            {/if}
        </div>
        <div class="col-md-4">
            {$events->call('content.sidebar.before', $content)}
            {if $form_display_blocks.params}
                {$events->call('content.params.before', $content)}
                {include "content/blocks/params.tpl"}
                {$events->call('content.params.after', $content)}
            {/if}
            {if $form_display_blocks.features}
                {include "content/blocks/features.tpl"}
                {$events->call('content.features.after', $content)}
            {/if}
            {$events->call('content.sidebar.after', $content)}
        </div>
    </div>
    {$events->call('form.bottom', $content)}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" id="content_id" value="{$content.id}">
</form>