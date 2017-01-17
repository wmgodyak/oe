<form class="form-horizontal" action="admin/profile" enctype="multipart/form-data" method="post" id="editProfileForm">
<div class="row">
    <div class="col-md-9">
        <fieldset>
            <legend>{$t.common.legend_main}</legend>
            <div class="form-group">
                <label for="data_name" class="col-sm-3 control-label">{$t.admin_profile.name}</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[name]" id="data_name" value="{$ui.name}" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_surname" class="col-sm-3 control-label">{$t.admin_profile.surname}</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[surname]" id="data_surname" value="{$ui.surname}">
                </div>
            </div>
            <div class="form-group">
                <label for="data_email" class="col-sm-3 control-label">{$t.admin_profile.email}</label>
                <div class="col-sm-9">
                    <input type="email" class="form-control" name="data[email]" id="data_email" value="{$ui.email}" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_phone" class="col-sm-3 control-label">{$t.admin_profile.phone}</label>
                <div class="col-sm-9">
                    <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="{$ui.phone}">
                </div>
            </div>
        </fieldset>
    </div>
    <div class="col-md-3">
        <fieldset style="height: 245px;">
            <legend>{$t.common.legend_photo}</legend>
            <div style="clear: both;"></div>
            <div style="text-align: center; margin-bottom: 1em; margin-top: 1em;" id="changeAvatar" class="admin-avatar">
                <img style="max-width:100%;" src="{if $ui.avatar == ''}/themes/backend/assets/img/user-bg.png{else}{$ui.avatar}{/if}">
            </div>
            <div style="display: none">
                <input type="file" name="avatar" id="adminAvatar">
            </div>
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
                        <input type="password" class="form-control" name="data[password]" id="data_password">
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

    <input type="hidden" name="token" value="{$token}">
</form>