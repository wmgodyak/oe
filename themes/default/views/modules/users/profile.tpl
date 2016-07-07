<form action="route/users/profile" method="post" id="accountProfile">
    <table class="info">
        <tr>
            <td><h3 class="head-red">{$t.users.profile.title}</h3></td>
            <td class="text-right"><a href="javascript:void(0);" class="btn-edit b-users-profile-edit">{$t.users.profile.edit}</a></td>
        </tr>
        <tr>
            <td>{$t.users.profile.name}</td>
            <td><input type="text" name="data[name]" value="{if isset($user.name)}{$user.name}{/if}" disabled required></td>
        </tr>
        <tr>
            <td>{$t.users.profile.surname}</td>
            <td><input type="text" name="data[surname]" value="{if isset($user.surname)}{$user.surname}{/if}" disabled required></td>
        </tr>
        <tr>
            <td>{$t.users.profile.phone}</td>
            <td><input type="text" class="hidden" name="data[phone]" value="{if isset($user.phone)}{$user.phone}{/if}" disabled required></td>
        </tr>
        <tr>
            <td>{$t.users.profile.email}</td>
            <td><input type="email" class="hidden" name="data[email]" value="{if isset($user.email)}{$user.email}{/if}" disabled required></td>
        </tr>
        {*<tr>*}
            {*<td>Дата народження</td>*}
            {*<td><input type="date" class="hidden" name="data[name]" value="{$user.name}" disabled="disabled"></td>*}
        {*</tr>*}
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