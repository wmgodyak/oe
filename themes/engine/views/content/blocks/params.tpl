<fieldset>
    <legend>{$t.common.legend_params}</legend>
    {if count($subtypes)>1}
        <div class="form-group">
            <label for="content_subtypes_id" class="col-md-3 control-label">{$t.content.subtypes}</label>
            <div class="col-md-9">
                <select name="content[subtypes_id]" id="content_subtypes_id" class="form-control">
                    {foreach $subtypes as $item}
                        <option {if $content.subtypes_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    {/if}

    <div class="form-group">
        <label for="content_status" class="col-md-3 control-label">{$t.common.status}</label>
        <div class="col-md-9">
            <select name="content[status]" id="content_status" class="form-control">
                {foreach $content.statuses as $i=>$item}
                    <option {if $content.status==$item}selected{/if} value="{$item}">{$item}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="content_owner_id" class="col-md-3 control-label">{$t.common.owner}</label>
        <div class="col-md-9">
            <select name="content[owner_id]" id="content_owner_id" class="form-control">
                {foreach $content.owners as $item}
                    <option {if $content.owner_id==$item.id}selected{/if} value="{$item.id}">{$item.name} {$item.surname}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="content_parent_id" class="col-md-3 control-label">{$t.common.parent_id}</label>
        <div class="col-md-9">
            <input name="content[parent_id]" id="content_parent_id" class="form-control" value="{$content.parent_id}">
        </div>
    </div>
    <div class="form-group">
        <label for="content_published" class="col-md-3 control-label">{$t.common.pub_date}</label>
        <div class="col-md-9">
            <input name="content[published]" id="content_published" class="form-control datepicker" value="{$content.published}">
        </div>
    </div>
    {if isset($plugins.params)}{implode("\r\n", $plugins.params)}{/if}
</fieldset>