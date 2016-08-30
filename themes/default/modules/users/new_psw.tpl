<div class="form-block">
    {if isset($errors) && !empty($errors)}
        <pre>{print_r($errors)}</pre>
    {/if}
    <form class="form-login" method="post">
        <div class="form-group">
            <label for="pass-modal">Пароль:</label>
            <input id="pass-modal" name="data[password]" class="alert" type="password">
        </div>
        <div class="form-group">
            <label for="pass-modal">Пароль повторіть:</label>
            <input id="pass-modal" name="data[password_c]" class="alert" type="password">
        </div>
        <input type="hidden" name="token" value="{$token}">
        <button type="submit" class="btn-red">Зберегти</button>
    </form>
</div>