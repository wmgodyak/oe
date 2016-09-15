<div class="modal-login modal">
    <h2>Вхід в інтернет-магазин</h2>
    <div class="form-block">
        <form action="route/users/login" class="form-login" data-href="28" method="post" id="usersLogin">
            <div class="form-group">
                <label for="email-modal">Електронна пошта:</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <div class="form-group">
                <label for="pass-modal">Пароль:</label>
                <input id="pass-modal" name="data[password]" class="alert" type="password">
            </div>
            <a href="javascript:;" class="link-red b-users-fp">Забули пароль?</a>
            <input type="hidden" name="token" value="{$token}">
            <button type="submit" class="btn-red">Увійти</button>
            <button type="button" class="btn-clear close b-users-cancel">Скасувати</button>
        </form>
    </div>
    {$events->call('users.form.login')}

</div>