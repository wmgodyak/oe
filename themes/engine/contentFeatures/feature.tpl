{function name=renderFeature}
{if $feature.type == 'text'}
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="content_features_{$lang.id}" class="col-md-3 control-label">{$feature.name}</label>
            <div class="col-md-9">
                <input name="content_features[{$feature.id}][{$lang.id}]"  placeholder="{$lang.name}" {if $feature.required}required{/if} id="content_features_{$feature.id}x{$lang.id}" class="form-control" value="{$feature.values[$lang.id]}">
            </div>
        </div>
    {/foreach}
{elseif $feature.type == 'textarea'}
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="content_features_{$feature.id}x{$lang.id}" class="col-md-3 control-label">{$feature.name}</label>
            <div class="col-md-9">
                <textarea name="content_features[{$feature.id}][{$lang.id}]"  placeholder="{$lang.name}" {if $feature.required}required{/if} id="content_features_{$feature.id}x{$lang.id}"  class="form-control">{$feature.values[$lang.id]}</textarea>
            </div>
        </div>
    {/foreach}
{elseif $feature.type == 'select'}
    <div class="form-group">
        <label for="content_features" class="col-md-3 control-label">{$feature.name} {if !$feature.disable_values}<a data-parent="{$feature.id}" title="{$t.features.add_value}" class="b-cf-add-val" href="javascript:;"><i class="fa fa-plus-circle"></i></a>{/if}</label>
        {*{if !$feature.disable_values}*}
        <div class="col-md-9">
            <select name="content_features[{$feature.id}]{if $feature.multiple}[]{/if}" {if $feature.multiple}multiple{/if} id="content_features_{$feature.id}"  class="form-control cf-feature-select">
                {foreach $feature.items as $item}
                    <option {if $item.selected}selected{/if} value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
        {*{/if}*}
    </div>
{elseif $feature.type == 'file'}
    <div class="form-group">
        <label for="content_features" class="col-md-3 control-label">{$feature.name}</label>
        <div class="col-md-7">
            <input type="text" readonly name="content_features[{$feature.id}]" id="content_features_{$feature.id}"  class="form-control"  value="{$feature.values[0]}">
        </div>
        <div class="col-md-2">
            <button class="btn cf-file-browse" type="button" data-target="content_features_{$feature.id}"><i class="fa fa-file"></i></button>
        </div>
    </div>
{elseif $feature.type == 'number'}

    {*<pre>{print_r($feature)}</pre>*}
    <div class="form-group">
        <label for="content_features" class="col-md-3 control-label">{$feature.name}</label>
        <div class="col-md-9">
            <input type="text" name="content_features[{$feature.id}]" id="content_features_{$feature.id}"  class="form-control" value="{$feature.values[0]}">
        </div>
    </div>
{elseif $feature.type == 'checkbox'}
    <div class="col-md-9 col-md-offset-3">
        <div class="checkbox">
            <label>
                <input type="hidden" name="content_features[{$feature.id}]" value="0">
                <input {if $feature.checked}checked{/if} type="checkbox" name="content_features[{$feature.id}]" id="content_features_{$feature.id}" value="1">
                 {$feature.name}
            </label>
        </div>
    </div>
{elseif $feature.type == 'folder'}
    <div class="row">
        <div class="col-md-11 col-md-offset-1">
            <div class="row">
                <div class="col-md-12">
                    <h3>{$feature.name} <a href="javascript:;" class="b-ct-features-add" data-id="{$content.id}" data-parent="{$feature.id}"><i class="fa fa-plus-circle"></i> {$t.common.create}</a></h3>
                </div>
            </div>
            <div class="row">
                <div id="content_features_{$feature.id}">
                    {foreach $feature.items as $item}
                        {$item.disable_values = $feature.disable_values}
                        {call renderFeature feature=$item}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{else}
    <p>Wrong feature type</p>
    <pre>{print_r($feature)}</pre>
{/if}
{/function}
{call renderFeature feature=$feature}