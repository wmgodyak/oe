{function name=renderOptions}
    {foreach $items as $item}
        <option {if $selected == $item.id}selected{/if} value="{$item.id}">{if isset($parent)}{$parent} / {/if}{$item.name}</option>
        {if $item.isfolder}
            {call renderOptions items=$item.items selected=$selected parent=$item.name}
        {/if}
    {/foreach}
{/function}
<form class="form-horizontal" action="module/run/users/groups/process/{if isset($data.id)}{$data.id}{/if}" method="post" id="usersGroupForm">
        <div class="form-group">
            <label for="data_parent_id" class="col-md-3 control-label">{$t.users_group.parent}</label>
            <div class="col-md-9">
                <select class="form-control" name="data[parent_id]" id="data_parent_id">
                    <option value="0">--</option>
                    {call renderOptions items=$groups selected=$data.parent_id parent=''}
                </select>
            </div>
        </div>
        {foreach $languages as $lang}
            <div class="form-group">
                <label for="info_name_{$lang.id}" class="col-md-3 control-label">{$t.users_group.name} ({$lang.name})</label>
                <div class="col-md-9">
                    <input type="tel" class="form-control" name="info[{$lang.id}][name]" id="info_name_{$lang.id}" value="{if isset($info[$lang.id].name)}{$info[$lang.id].name}{/if}" required>
                </div>
            </div>
        {/foreach}

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="a" value="1">
</form>