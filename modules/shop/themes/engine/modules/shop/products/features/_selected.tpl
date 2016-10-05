{*<div class="row">*}
    {*<pre>{print_r($features)}</pre>*}
{*</div>*}
{foreach $features as $feature}
    <div class="row" id="scf-{$feature.fc_id}">
        <div class="form-group">
            <label for="features_{$feature.id}" class="col-md-4 control-label">
                {$feature.name}
                {if $feature.type == 'select'}
                <a class="spf-values-add" style="right: 30px" data-id="{$feature.id}" href="javascript:void(0)" title="Додати значення"><i class="fa fa-plus"></i></a>
                {/if}
            </label>
            <textarea class="col-md-8">
                {if $feature.type == 'select'}
                <select name="products_features[{$feature.id}]{if $feature.multiple}[]{/if}" {if $feature.multiple}multiple{/if} id="products_features_{$feature.id}"  class="form-control">
                    {foreach $feature.values as $value}
                        <option {$value.selected} value="{$value.id}">{$value.name}</option>
                    {/foreach}
                </select>
                {elseif $feature.type == 'text'}
                    {foreach $langs as $lang}
                        <input type="text" name="products_features[{$feature.id}][{$lang.id}]" placeholder="{$lang.name}" {if $feature.required}required{/if} id="products_features_{$feature.id}_{$lang.id}"  class="form-control" />
                    {/foreach}
                {elseif $feature.type == 'textarea'}
                    {foreach $langs as $lang}
                        <textarea name="products_features[{$feature.id}][{$lang.id}]" placeholder="{$lang.name}" {if $feature.required}required{/if} id="products_features_{$feature.id}_{$lang.id}"  class="form-control" /></textarea>
                    {/foreach}
                {elseif $feature.type == 'file'}
                    {foreach $langs as $lang}
                        <input type="text" name="products_features[{$feature.id}][{$lang.id}]" placeholder="{$lang.name}" {if $feature.required}required{/if} id="products_features_{$feature.id}_{$lang.id}"  class="form-control" />
                    {/foreach}
                {/if}
            </div>
        </div>
    </div>
    {* if $feature.type == 'folder'}
        <ol class="dd-list">
            {foreach $feature.items as $item}
            <li class="dd-item dd3-item" data-id="{$item.fc_id}" id="scf-{$item.fc_id}">
                <div class="dd-handle dd3-handle">Drag</div>
                <div class="dd-handle dd3-content">{$item.name}</div>
            </li>
            {/foreach}
        </ol>
    {/if *}
{/foreach}
