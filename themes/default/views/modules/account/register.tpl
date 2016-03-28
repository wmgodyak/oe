<form role="form" action="ajax/account/register" data-href="31" method="post" id="accountRegister">
    <div class="form-group">
        <label for="name">Your name</label>
        <input type="text" class="form-control" name="data[name]" required />
    </div>
    <div class="form-group">
        <label for="email">Email address</label>
        <input type="email" class="form-control" name="data[email]" required />
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" name="data[password]" required />
    </div>
    <div class="checkbox">
        <label>
            <input required type="checkbox" name="rules" value="1"> You have read & agree to the
            <a href="#">Terms of service</a>.
        </label>
    </div>
    <div class="submit">
        <button type="submit" class="button-clear">
            <span>Create my account</span>
        </button>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>