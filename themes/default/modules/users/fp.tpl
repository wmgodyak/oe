<div class="modal-login modal">
    <h2>{$t.users.fp.title}</h2>
    <div class="form-block">
        <form action="route/users/fp" class="form-login" method="post" id="usersFp">
            <div class="form-group">
                <label for="email-modal">{$t.users.fp.email}</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <button type="submit" class="btn-red">{$t.users.fp.submit}</button>
            <a href="" class="link-red b-users-login">{$t.users.fp.login}</a>
            <a class="link-red close b-users-cancel">{$t.users.fp.cancel}</a>
            <input type="hidden" name="token" value="{$token}">
        </form>
    </div>
    {$events->call('users.form.login', $page)}
</div>