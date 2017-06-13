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
            <div class="col-md-8">
                {if $feature.type == 'select'}
                <select name="products_features[{$feature.id}]{if $feature.multiple}[]{/if}" {if $feature.multiple}multiple{/if} id="products_features_{$feature.id}"  class="form-control">
                    {if $feature.multiple == 0}
                        <option value="">виберіть</option>
                    {/if}
                    {foreach $feature.values as $value}
                        <option {$value.selected} value="{$value.id}">{$value.name}</option>
                    {/foreach}
                </select>
                {elseif $feature.type == 'text'}
                    {foreach $langs as $lang}
                        <input type="text" name="products_features[{$feature.id}][{$lang.id}]" placeholder="{$lang.name}" {if $feature.required}required{/if} value="{$feature.values[$lang.id]}" id="products_features_{$feature.id}_{$lang.id}"  class="form-control" />
                    {/foreach}
                {elseif $feature.type == 'number'}
                    <input type="text" name="products_features[{$feature.id}]" id="products_features_{$feature.id}"  class="form-control"  value="{$feature.values}" />
                {elseif $feature.type == 'textarea'}
                    {foreach $languages as $lang}
                        <textarea name="products_features[{$feature.id}][{$lang.id}]" placeholder="{$lang.name}" {if $feature.required}required{/if} id="products_features_{$feature.id}_{$lang.id}"  class="form-control" >{$feature.values[$lang.id]}</textarea>
                    {/foreach}
                {elseif $feature.type == 'file'}
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-10">
                                <input type="text" readonly name="products_features[{$feature.id}]" id="products_features_{$feature.id}"  class="form-control"  value="{$feature.values}" />
                            </div>
                            <div class="col-md-2">
                                <button class="btn cf-file-browse" type="button" data-target="products_features_{$feature.id}"><i class="fa fa-file"></i></button>
                            </div>
                        </div>
                    </div>
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
