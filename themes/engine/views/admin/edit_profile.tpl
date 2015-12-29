<form class="form-horizontal" action="admin/profile" method="post" id="editProfileForm">
<div class="row">
    <div class="col-md-9">
        <fieldset>
            <legend>Основне</legend>
            <div class="form-group">
                <label for="data_name" class="col-sm-3 control-label">{$t.admin_profile.name}</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[name]" id="data_name" value="{$ui.name}" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_surname" class="col-sm-3 control-label">{$t.admin_profile.surname}</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[surname]" id="data_surname" value="{$ui.surname}" required>
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
                    <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="{$ui.phone}" required>
                </div>
            </div>
        </fieldset>
    </div>
    <div class="col-md-3">
        <fieldset style="height: 245px;">
            <legend>Фото</legend>
            <img src="/uploads/avatars/1.jpg" alt="">
            <div><button type="button" class="btn btn-default">Змінити</button></div>
        </fieldset>
    </div>
</div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Зміна паролю</legend>
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