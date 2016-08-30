<div class="modal-login modal">
    <h2>Вхід в інтернет-магазин</h2>
    <div class="form-block">
        <form action="route/users/login" class="form-login" method="post" id="usersLogin">
            <div class="form-group">
                <label for="email-modal">Електронна пошта:</label>
                <input id="email-modal" name="data[email]" type="email">
            </div>
            <div class="form-group">
                <label for="pass-modal">Пароль:</label>
                <input id="pass-modal" name="data[password]" class="alert" type="password">
            </div>
            <a href="" class="link-red b-users-fp">Забули пароль?</a>
            <input type="hidden" name="token" value="{$token}">
            <button type="submit" class="btn-red">Увійти</button>
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