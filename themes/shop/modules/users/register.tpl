{extends 'layouts/pages/sb-sr.tpl'}
{block name='content'}
        <form action="route/users/register" class="form-login" method="post" id="usersRegister">
            <div class="form-group">
                <label for="name-modal">{$t.users.register.name}</label>
                <input id="name-modal" name="data[name]" type="text">
            </div>
            <div class="form-group">
                <label for="email-modal">{$t.users.register.email}</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <div class="form-group">
                <label for="pass-modal">{$t.users.password}</label>
                <input id="pass-modal" name="data[password]" class="alert" type="password">
            </div>
            <div class="form-group">
                <label for="pass-modal">{$t.users.password_c}</label>
                <input id="pass-modal" name="data[password_c]" class="alert" type="password">
            </div>
            <input type="hidden" name="token" value="{$token}">
            <button type="submit" class="btn-red">{$t.users.register.button}</button>
            <button type="button" class="btn-clear close b-users-cancel">{$t.users.register.cancel}</button>
        </form>
    {$events->call('users.form.login', $page)}
{/block}