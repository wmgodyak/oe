<div class="form-block">
    {if isset($errors) && !empty($errors)}
        <p>{implode('<br>', $errors)}</p>
    {/if}
    <form class="form-login" method="post">
        <div class="form-group">
            <label for="pass-modal">{$t.users.new_psw.password}</label>
            <input id="pass-modal" name="data[password]" class="alert" type="password">
        </div>
        <div class="form-group">
            <label for="pass-modal">{$t.users.new_psw.password_c}</label>
            <input id="pass-modal" name="data[password_c]" class="alert" type="password">
        </div>
        <input type="hidden" name="token" value="{$token}">
        <button type="submit" class="btn-red">{$t.users.new_psw.update}</button>
    </form>
</div>