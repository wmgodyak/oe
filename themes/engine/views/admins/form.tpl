<form class="form-horizontal" action="admins/process/{$data.id}" enctype="multipart/form-data" method="post" id="form">
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label">{$t.admin_profile.name}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_surname" class="col-sm-3 control-label">{$t.admin_profile.surname}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[surname]" id="data_surname" value="{$data.surname}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_email" class="col-sm-3 control-label">{$t.admin_profile.email}</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" name="data[email]" id="data_email" value="{$data.email}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_phone" class="col-sm-3 control-label">{$t.admin_profile.phone}</label>
                    <div class="col-sm-9">
                        <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="{$data.phone}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_group_id" class="col-sm-3 control-label">{$t.admins.group}</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="data[group_id]" id="data_group_id">
                            {foreach $groups as $group}
                                {if $group.isfolder}
                                    <optgroup label="{$group.name}">
                                        {foreach $group.items as $item}
                                            <option {if $data.group_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                                        {/foreach}
                                    </optgroup>
                                    {else}
                                    <option {if $data.group_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="is_main" class="col-sm-3 control-label"></label>
                    <div class="col-sm-9">

                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="notify" value="0">
                                <input type="checkbox" name="notify" id="notify" value="1"> {$t.admins.notify}
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-3">
            <fieldset style="height: 330px;">
                <legend>{$t.admin.photo}</legend>
                <div style="text-align: center; margin-bottom: 1em;"><img src="{$data.avatar}" alt="" class="edit-admin-avatar admin-avatar" style="max-width: 130px;"></div>
                <div style="display: none">
                    <input type="file" name="avatar" id="adminAvatar">
                </div>
                {if $action == 'edit' }
                <div style="text-align: center"><button type="button" id="changeAdminAvatar" class="btn btn-default">{$t.common.btn_change}</button></div>
                {/if}
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>{$t.admin.legend_passowrd}</legend>
                <div class="form-group">
                    <label for="data_password" class="col-sm-3 control-label">{$t.admin_profile.password}</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" name="data[password]" id="data_password" placeholder="{$t.admins.passw_gen_auto}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_password_c" class="col-sm-3 control-label">{$t.admin_profile.password_c}</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" name="data[password_c]" id="data_password_c" >
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
</form>