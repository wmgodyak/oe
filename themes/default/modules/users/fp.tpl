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