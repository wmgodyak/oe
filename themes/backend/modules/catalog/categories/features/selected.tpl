<div class="dd" id="categories_features">
    <ol class="dd-list">
        {foreach $features as $feature}
            <li class="dd-item dd3-item" data-id="{$feature.fc_id}" id="scf-{$feature.fc_id}">
                <div class="dd-handle dd3-handle">Drag</div>
                <div class="dd3-content">{$feature.name}
                    <a class="scf-edit dd-remove" style="right: 50px" data-id="{$feature.id}" href="javascript:void(0)" title="Редагувати властивість"><i class="fa fa-pencil"></i></a>
                    <a class="scf-remove dd-remove" style="right: 30px" data-id="{$feature.fc_id}" href="javascript:void(0)" title="Видалити зв'язок"><i class="fa fa-remove"></i></a>
                    <a class="scf-drop dd-remove" data-fcid="{$feature.fc_id}"  data-id="{$feature.id}" href="javascript:void(0)" title="Видалити властивість"><i class="fa fa-trash"></i></a>
                </div>
            </li>
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
    </ol>
</div>