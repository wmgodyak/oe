<fieldset>
    <legend>
        {$t.common.legend_params}
        <a href="javascript:;" class="hide-fieldset-content">
            <i class="fa fa-angle-down" aria-hidden="true"></i>
        </a>
    </legend>
    <div class="fieldset-wrapper">
        {if count($subtypes)>1}
            <div class="form-group">
                <label for="content_subtypes_id" class="col-md-4 control-label">{$t.content.subtypes}</label>
                <div class="col-md-8">
                    <select name="content[subtypes_id]" id="content_subtypes_id" class="form-control">
                        {foreach $subtypes as $item}
                            <option {if $content.subtypes_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        {/if}
        <div class="form-group">
            <div class="col-md-12">
                <label for="content_status" class="">
                    <input type="hidden" name="content[status]" value="hidden">
                    <input class="switch" type="checkbox" name="content[status]" id="content_status" value="published" {if $content.status=='published'}checked{/if}>
                    <span class="l-check">{$t.common.published}</span>
                </label>
            </div>
        </div>
        {if $form_display_params.owner}
        <div class="form-group">
            <label for="content_owner_id" class="col-md-4 control-label">{$t.common.owner}</label>
            <div class="col-md-8">
                <select name="content[owner_id]" id="content_owner_id" class="form-control">
                    {foreach $content.owners as $item}
                        <option {if $content.owner_id==$item.id}selected{/if} value="{$item.id}">{$item.name} {$item.surname}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        {/if}
        {if $form_display_params.parent}
        <div class="form-group">
            <label for="content_parent_id" class="col-md-4 control-label">{$t.common.parent_id}</label>
            <div class="col-md-8">
                <input name="content[parent_id]" id="content_parent_id" class="form-control" value="{$content.parent_id}">
            </div>
        </div>
        {/if}
        {if $form_display_params.position}
        <div class="form-group">
            <label for="content_position" class="col-md-4 control-label">Позиція</label>
            <div class="col-md-8">
                <input name="content[position]" id="content_position"  class="form-control" value="{$content.position}">
            </div>
        </div>
        {/if}
        {if $form_display_params.pub_date}
        <div class="form-group">
            <label for="content_published" class="col-md-4 control-label">{$t.common.pub_date}</label>
            <div class="col-md-8">
                <div class="date-select">
                    <input name="content[published]" id="content_published" class="form-control datepicker" value="{$content.published}">
                    <i class="fa fa-calendar b-change-date"></i>
                </div>
            </div>
        </div>
        {/if}
    </div>
    {$events->call('content.params', $content)}
</fieldset>