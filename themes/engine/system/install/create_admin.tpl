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
        <label> Мова сайту по замовчуванню <span class="text-danger">*</span></label>
        <select name="data[language]">
            <option value="uk">Українська</option>
            <option value="ru">Русский</option>
            <option value="en">English</option>
            <option value="pl">Polska</option>
            <option value="de">Deutch</option>
        </select>
    </div>

    <div class="row">
        <div class="col-md-3 col-md-offset-9 text-right">
            <input type="hidden" name="action" value="db_config">
            <button class="btn btn-default">Встановити</button>
        </div>
    </div>
</form>