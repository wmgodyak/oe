<div class="modal-login modal">
    <h2>Вхід в інтернет-магазин</h2>
    <div class="form-block">
        <form action="route/users/fp" class="form-login" method="post" id="usersFp">
            <div class="form-group">
                <label for="email-modal">Електронна пошта:</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <button type="submit" class="btn-red">Надіслати</button>
            <a href="" class="link-red b-users-login">Увійти</a>
            <a class="link-red close b-users-cancel">Скасувати</a>
            <input type="hidden" name="token" value="{$token}">
        </form>
    </div>
    {$events->call('users.form.login', $page)}
</div>