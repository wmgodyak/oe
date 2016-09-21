<form class="form-horizontal" action="module/run/users/process/{if isset($data.id)}{$data.id}{/if}" enctype="multipart/form-data" method="post" id="form">
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label">{$t.users.name}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{if isset($data.name)}{$data.name}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_surname" class="col-sm-3 control-label">{$t.users.surname}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[surname]" id="data_surname" value="{if isset($data.surname)}{$data.surname}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_email" class="col-sm-3 control-label">{$t.users.email}</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" name="data[email]" id="data_email" value="{if isset($data.email)}{$data.email}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_phone" class="col-sm-3 control-label">{$t.users.phone}</label>
                    <div class="col-sm-9">
                        <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="{if isset($data.phone)}{$data.phone}{/if}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_group_id" class="col-sm-3 control-label">{$t.users.group}</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="data[group_id]" id="data_group_id">
                            {foreach $groups as $group}
                                {if $group.isfolder}
                                    <optgroup label="{$group.name}">
                                        {foreach $group.items as $item}
                                            <option {if isset($data.group_id) && $data.group_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>
                                        {/foreach}
                                    </optgroup>
                                    {else}
                                    <option {if isset($data.group_id) && $data.group_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>
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
                                <input type="checkbox" name="notify" id="notify" value="1"> {$t.users.notify}
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-3">
            <fieldset style="height: 330px;">
                <legend>{$t.users.avatar}</legend>
                <div style="text-align: center; margin-bottom: 1em;">
                    <img src="{if isset($data.avatar)}{$data.avatar}{/if}" alt="" class="edit-customer-avatar customer-avatar" style="max-width: 130px;">
                </div>
                <div style="display: none">
                    <input type="file" name="avatar" id="customerAvatar">
                </div>
                {if $action == 'edit' }
                    <div style="text-align: center">
                        <button type="button" id="changeCustomerAvatar" class="btn btn-default">{$t.users.btn_change}</button>
                    </div>
                {/if}
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>{$t.users.legend_password}</legend>
                <div class="form-group">
                    <label for="data_password" class="col-sm-3 control-label">{$t.users.password}</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" name="data[password]" id="data_password" placeholder="{$t.users.passw_gen_auto}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_password_c" class="col-sm-3 control-label">{$t.users.password_c}</label>
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