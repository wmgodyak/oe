<fieldset>
    <legend>Налаштування БД</legend>
</fieldset>
{if empty($error)}
    <div class="alert alert-dismissable alert-success fade in">
        Перед інсталяцією системи створіть БД.
    </div>
    {else}
    <div class="alert alert-dismissable alert-danger fade in">
        {implode('<br>', $error)}
    </div>
{/if}
<form action="" method="post">
    <p>Введіть тут інформацію про підключення до бази даних.</p>

    <div class="form-group">
        <label>Назва бази даних <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[name]" placeholder="введіть назву БД" class="form-control ">
    </div>
    <div class="form-group">
        <label>Префікс <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[prefix]" placeholder="e_" class="form-control ">
    </div>

    <div class="form-group">
        <label>Ім’я користувача <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[user]" value="root" class="form-control ">
    </div>

    <div class="form-group">
        <label>Пароль <span class="text-danger">*</span></label>
        <input type="password" required="" name="data[pass]" placeholder="pasword" class="form-control ">
    </div>
    <div class="form-group">
        <label>Сервер баз даних <span class="text-danger">*</span></label>
        <input type="text" required="" name="data[host]" value="localhost" class="form-control ">
    </div>

    <div class="row">
        <div class="col-md-3 col-md-offset-9 text-right">
            <input type="hidden" name="action" value="db_config">
            <button class="btn btn-default">Встановити</button>
        </div>
    </div>
</form>