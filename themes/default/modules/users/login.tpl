<div class="modal-login modal">
    <h2>{$t.users.login.title}</h2>
    <div class="form-block">
        <form action="route/users/login" class="form-login" data-href="28" method="post" id="usersLogin">
            <div class="form-group">
                <label for="email-modal">{$t.users.login.email}</label>
                <input id="email-modal" required name="data[email]" type="email">
            </div>
            <div class="form-group">
                <label for="pass-modal">{$t.users.login.password}</label>
                <input id="pass-modal" required name="data[password]" class="alert" type="password">
            </div>
            <a href="" class="link-red b-users-fp">{$t.users.login.fp_link}</a>
            <input type="hidden" name="token" value="{$token}">
            <button type="submit" class="btn-red">{$t.users.login.button}</button>
            <button type="button" class="btn-clear close b-users-cancel">{$t.users.login.cancel}</button>
        </form>
    </div>
    {$events->call('users.form.login', $page)}
</div>