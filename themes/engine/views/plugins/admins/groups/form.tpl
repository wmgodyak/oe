<form class="form-horizontal" action="plugins/adminsGroup/process/{$data.id}" method="post" id="adminsGroupForm">
    <fieldset>
        <legend>Основне</legend>
        <div class="form-group">
            <label for="data_parent_id" class="col-md-3 control-label">{$t.admins_group.parent}</label>
            <div class="col-md-9">
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
                <label for="info_name_{$lang.id}" class="col-md-3 control-label">{$t.admins_group.name} ({$lang.name})</label>
                <div class="col-md-9">
                    <input type="tel" class="form-control" name="info[{$lang.id}][name]" id="info_name_{$lang.id}" value="{$info[$lang.id].name}" required>
                </div>
            </div>
        {/foreach}
        <div class="form-group">
            <div class="col-md-10">
                <input type="hidden"  name="permissions[full_access]"  class="form-control" value="0" >
                <input type="checkbox" {if $data.permissions.full_access}checked{/if} name="permissions[full_access]" id="permissions_full_access" value="1" > Повний доступ
            </div>
        </div>
    </fieldset>
    <fieldset id="custom_permissions" style="display: {if $data.permissions.full_access}none{else}block{/if}">
        <legend>Виберіть доступ до компонентів</legend>
        {*<pre>{print_r( $data.permissions)}</pre>*}
        {foreach $components as $component=>$a}
            <div class="form-group">
                <label for="p_{$component}" class="col-md-3 control-label"><a class="gp-toggle-c-actions" data-id="{str_replace('\\','-',$component)}" href="javascript:void('Клік щоб вибрати все');">{$component}</a></label>
                <div class="col-md-9">
                    <div class="row">
                        {foreach array_chunk($a, 3) as $k=>$row}
                            <div class="col-md-4">
                                {foreach $row as $c=> $_action}
                                    <label class="checkbox" style="width: 100%;display: inline-block; ">
                                        <input {if $data.permissions[$component] && in_array($_action, $data.permissions[$component])}checked{/if} type="checkbox" class="com {str_replace('\\','-',$component)}" id="{$component}_{$_action}" name="permissions[{$component}][]" value="{$_action}"> {$_action}
                                    </label>
                                {/foreach}
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/foreach}
    </fieldset>


    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="a" value="1">
</form>