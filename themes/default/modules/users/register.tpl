<div class="modal-login modal">
    <h2>Вхід в інтернет-магазин</h2>
    <div class="form-block">
        <form action="route/users/register" class="form-login" method="post" id="usersRegister">
            <div class="form-group">
                <label for="name-modal">Ім'я:</label>
                <input id="name-modal" name="data[name]" type="text">
            </div>
            <div class="form-group">
                <label for="email-modal">Електронна пошта:</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <div class="form-group">
                <label for="pass-modal">Пароль:</label>
                <input id="pass-modal" name="data[password]" class="alert" type="password">
            </div>
            <div class="form-group">
                <label for="pass-modal">Підтвердьте пароль:</label>
                <input id="pass-modal" name="data[password_c]" class="alert" type="password">
            </div>
            <input type="hidden" name="token" value="{$token}">
            <button type="submit" class="btn-red">Зареєструватись</button>
            <button type="button" class="btn-clear close b-users-cancel">Скасувати</button>
        </form>
    </div>
    <div class="social-intro">
        <h3>Увійти як користувач</h3>
        <a href="#" class="block">
            <div class="icon"></div>
            <div class="link">Вконтакте</div>
            <div class="clearfix"></div>
        </a>
        <a href="#" class="block">
            <div class="icon"></div>
            <div class="link">Facebook</div>
            <div class="clearfix"></div>
        </a>
        <a href="#" class="block">
            <div class="icon"></div>
            <div class="link">GooglePlus</div>
            <div class="clearfix"></div>
        </a>
    </div>
    <div class="clearfix"></div>

</div>