{foreach $features as $feature}
    <div class="row" id="scf-{$feature.fc_id}">
        <div class="form-group">
            <label for="features_{$feature.id}" class="col-md-4 control-label">
                {$feature.name}
                <a class="spf-values-add" style="right: 30px" data-id="{$feature.id}" href="javascript:void(0)" title="Додати значення"><i class="fa fa-plus"></i></a>
                {*<a class="spf-remove" style="right: 30px" data-id="{$feature.fc_id}" href="javascript:void(0)" title="Видалити зв'язок"><i class="fa fa-remove"></i></a>*}
                {*<a class="spf-drop" data-fcid="{$feature.fc_id}"  data-id="{$feature.id}" href="javascript:void(0)" title="Видалити властивість"><i class="fa fa-trash"></i></a>*}
            </label>
            <div class="col-md-8">
                <select name="products_features[{$feature.id}]{if $feature.multiple}[]{/if}" {if $feature.multiple}multiple{/if} id="products_features_{$feature.id}"  class="form-control">
                    {foreach $feature.values as $value}
                        <option {$value.selected} value="{$value.id}">{$value.name}</option>
                    {/foreach}
                </select>
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