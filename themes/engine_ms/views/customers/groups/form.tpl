{function name=renderSelect}
    {foreach $items as $item}
        <option value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {if $item.isfolder}
            {call renderSelect items=$item.items parent=$item.name}
        {/if}
    {/foreach}
{/function}
<form class="form-horizontal" action="plugins/customersGroup/process/{$data.id}" method="post" id="customersGroupForm">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label">{$t.customers_group.parent}</label>
        <div class="col-sm-9">
            <select class="form-control" name="data[parent_id]" id="data_parent_id">
                <option value="0">--</option>
                {foreach $groups as $group}
                    <option {if $data.id == $group.id}disabled{/if} {if $data.parent_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>
                    {if $group.isfolder}
                        {call renderSelect items=$items}
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    {foreach $languages as $lang}
    <div class="form-group">
        <label for="info_name_{$lang.id}" class="col-sm-3 control-label">{$t.customers_group.name} ({$lang.name})</label>
        <div class="col-sm-9">
            <input type="tel" class="form-control" name="info[{$lang.id}][name]" id="info_name_{$lang.id}" value="{$info[$lang.id].name}" required>
        </div>
    </div>
    {/foreach}
    <div class="form-group">
        <label for="data_phone" class="col-sm-3 control-label">{$t.customers_group.rang}</label>
        <div class="col-sm-9">
            <input type="tel" class="form-control" name="data[rang]" id="data_rang" value="{$data.rang}" required placeholder="101 - 999">
        </div>
    </div>

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="a" value="1">
</form>