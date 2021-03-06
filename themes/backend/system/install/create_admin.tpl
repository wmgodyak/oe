<fieldset>
    <legend>Налаштування сайту</legend>
</fieldset>
{if !empty($error)}
    <div class="alert alert-dismissable alert-danger fade in">
        {implode('<br>', $error)}
    </div>
{/if}
<form action="" method="post">

    <div class="form-group">
        <label>Назва сайту <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[name]" placeholder="введіть назву сайту" class="form-control ">
    </div>

    <div class="form-group">
        <label>Ім’я адміністратора <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[user]" placeholder="Ведіть ваше ім'я" class="form-control ">
    </div>

    <div class="form-group">
        <label> Ваш email <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[email]" placeholder="email@examle.com" class="form-control ">
    </div>

    <div class="form-group">
        <label>Пароль <span class="text-danger">*</span></label>
        <input type="password" required="" name="data[pass]" placeholder="pasword" class="form-control ">
    </div>

    <div class="form-group">
        <label> Шлях до адмін панелі: <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[backend_url]" placeholder="engine" class="form-control ">
    </div>

    <div class="form-group">
        <label> Мова адмінки замовчуванню <span class="text-danger">*</span></label>
        <select name="language" class="form-control">
            {foreach $langs as $k=>$lang}
                <option value="{$k}">{$lang}</option>
            {/foreach}
        </select>
    </div>

    <div class="row">
        <div class="col-md-3 col-md-offset-9 text-right">
            <input type="hidden" name="action" value="create_admin">
            <button class="btn btn-default">Встановити</button>
        </div>
    </div>
</form>