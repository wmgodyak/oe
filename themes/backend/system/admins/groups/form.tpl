{function name=renderGroups}
    <option {if $selected == $group.id}selected{/if} value="{$item.id}">{if isset($parent)}{$parent} / {/if}{$item.name}</option>
    {if $item.isfolder}
        {foreach $item.items as $c}
            {call renderGroups item=$c selected=$selected parent=$item.name}
        {/foreach}
    {/if}
{/function}
<form class="form-horizontal" action="{block name="system.admins.groups.form.action"}admins/groups/process{if isset($data.id)}/{$data.id}{/if}{/block}" method="post" id="{block name="system.admins.groups.form.id"}adminsGroupForm{/block}">
    <fieldset>
        <legend>{t('admins.groups.label_main')}</legend>
        <div class="form-group">
            <label for="data_parent_id" class="col-md-3 control-label">{$t.admins.groups.parent}</label>
            <div class="col-md-9">
                <select class="form-control" name="data[parent_id]" id="data_parent_id">
                    <option value="0">--</option>
                    {foreach $groups as $group}
                        {call renderGroups item=$group selected=$data.parent_id parent=''}
                    {/foreach}
                </select>
            </div>
        </div>
        {foreach $languages as $lang}
            <div class="form-group">
                <label for="info_name_{$lang.id}" class="col-md-3 control-label">{$t.admins.groups.name} ({$lang.name})</label>
                <div class="col-md-9">
                    <input type="tel" class="form-control" name="info[{$lang.id}][name]" id="info_name_{$lang.id}" value="{if isset($info[$lang.id].name)}{$info[$lang.id].name}{/if}" required>
                </div>
            </div>
        {/foreach}

        <div class="form-group">
            <label for="info_allowed_ips" class="col-md-3 control-label">{$t.admins.groups.allowed_ip}</label>
            <div class="col-md-9">
                <input type="text" class="form-control" name="data[allowed_ips]" id="info_allowed_ips" value="{if isset($data.allowed_ips)}{$data.allowed_ips}{/if}">
                <p class="help-block">{$t.admins.groups.allowed_ip_hint}</p>
            </div>
        </div>

        {block name="system.admins.groups.form.full_access_group"}
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <div class="checkbox">
                        <label>
                            <input type="hidden"  name="permissions[full_access]"  class="form-control" value="0" >
                            <input type="checkbox" {if isset($data.permissions.full_access) && $data.permissions.full_access}checked{/if} name="permissions[full_access]" id="permissions_full_access" value="1" > {t('admins.groups.full_access')}
                        </label>
                    </div>
                </div>
            </div>
        {/block}
    </fieldset>

    {block name="system.admins.groups.form.access_to_components"}
    <fieldset id="custom_permissions" style="display: {if $data.permissions.full_access}none{else}block{/if}">
        <legend>{t('admins.groups.access_to_components')}</legend>
        {foreach $components as $component=>$a}
            <div class="form-group">
                <label for="p_{$component}" class="col-md-2 control-label"><a class="gp-toggle-c-actions" data-id="{$component}" href="javascript:void('Клік щоб вибрати все');">{if $t[$component].action_index == ''}{$component}{else}{$t[$component].action_index}{/if}</a></label>
                <div class="col-md-10">
                    <div class="row">
                        {foreach array_chunk_part($a, 4) as $k=>$row}
                            <div class="col-md-3">
                                {foreach $row as $c=> $_action}
                                    <label class="checkbox" style="width: 100%;display: inline-block; ">
                                        <input {if isset($data.permissions['components'][$component]) && in_array($_action, $data.permissions['components'][$component])}checked{/if} name="permissions[components][{$component}][]" value="{$_action}" type="checkbox" class="com {$component}">
                                        {if $t[$component]["action_`$_action`"] == ''}{$_action}{else}{$t[$component]["action_`$_action`"]}{/if}
                                    </label>
                                {/foreach}
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/foreach}
    </fieldset>
    {/block}

    {block name="system.admins.groups.form.access_to_modules"}
    <fieldset id="custom_permissions" style="display: {if $data.permissions.full_access}none{else}block{/if}">
        <legend>{t('admins.groups.access_to_modules')}</legend>
        {foreach $modules as $module=>$a}
            <div class="form-group">
                <label for="p_{$module}" class="col-md-2 control-label"><a class="gp-toggle-c-actions" data-id="{$module}" href="javascript:void('Клік щоб вибрати все');">{if $t[$module].action_index == ''}{$module}{else}{$t[$module].action_index}{/if}</a></label>
                <div class="col-md-10">
                    <div class="row">
                        {foreach array_chunk_part($a, 4) as $k=>$row}
                            <div class="col-md-3">
                                {foreach $row as $c=> $_action}
                                    <label class="checkbox" style="width: 100%;display: inline-block; ">
                                        <input {if isset($data.permissions['modules'][$module]) && in_array($_action, $data.permissions['modules'][$module])}checked{/if} name="permissions[modules][{$module}][]" value="{$_action}" type="checkbox" class="com {$module}">
                                        {if $t[$module]["action_`$_action`"] == ''}{$_action}{else}{$t[$module]["action_`$_action`"]}{/if}
                                    </label>
                                {/foreach}
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/foreach}
    </fieldset>
    {/block}

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
</form>