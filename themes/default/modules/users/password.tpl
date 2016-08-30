<form action="route/users/changePassword" method="post" id="accountChangePassword">
    <table class="info">
        <tr>
            <td><h3 class="head-red">{$t.users.password_form_title}</h3></td>
            <td class="text-right"><button class="btn-edit b-users-profile-edit">{$t.users.password_form_edit}</button></td>
        </tr>
        <tr>
            <td>{$t.users.password}</td>
            <td><input name="data[password]" disabled required type="password"></td>
        </tr>
        <tr>
            <td>{$t.users.password_c}</td>
            <td><input name="data[password_c]" disabled required type="password"></td>
        </tr>
        <tr class="form-action" style="display: none">
            <td>&nbsp;</td>
            <td>
                <button class="btn b-form-save">{$t.users.profile.save}</button>
            </td>
        </tr>
    </table>
    <div class="response"></div>
    <input type="hidden" name="token" value="{$token}">
</form>