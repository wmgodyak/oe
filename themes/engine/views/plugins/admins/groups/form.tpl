<form class="form-horizontal" action="plugins/adminsGroup/process/{$data.id}" method="post" id="adminsGroupForm">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label">{$t.admins_group.parent}</label>
        <div class="col-sm-9">
            <select class="form-control" name="data[parent_id]" id="data_parent_id">
                <option value="0">--</option>
                {foreach $groups as $group}
                    <option {if $data.parent_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>
                    {if $group.isfolder}
                        {include file="plugins/admins/groups/options.tpl" items=$group.items level=1 disabled=$data.parent_id == $group.id}
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    {foreach $languages as $lang}
    <div class="form-group">
        <label for="info_name_{$lang.id}" class="col-sm-3 control-label">{$t.admins_group.name} ({$lang.name})</label>
        <div class="col-sm-9">
            <input type="tel" class="form-control" name="info[{$lang.id}][name]" id="info_name_{$lang.id}" value="{$info[$lang.id].name}" required>
        </div>
    </div>
    {/foreach}
    <div class="form-group">
        <label for="data_phone" class="col-sm-3 control-label">{$t.admins_group.rang}</label>
        <div class="col-sm-9">
            <input type="tel" class="form-control" name="data[rang]" id="data_rang" value="{$data.rang}" required placeholder="101 - 999">
        </div>
    </div>

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
</form>