{extends 'layouts/pages/fw.tpl'}
{block name="container"}
    <div class="block-form-login">

        <!-- block Create an Account -->
        <div class="block-form-create">
            <div class="block-title">
                Create an Account
            </div>
            <div class="block-content">
                <p>Please enter your email address to create an account!</p>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Your email">
                </div>
                <button type="submit" class="btn btn-inline">Register</button>
            </div>
        </div><!-- block Create an Account -->

        <!-- block Registered-->
        <div class="block-form-registered">

            <div class="block-title">
                Already Registered?
            </div>
            <div class="block-content">
                <p>If you have an account please enter the username & password her</p>
                <form>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Your email">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Password">
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox"><span>Remember me!</span>
                        </label>
                    </div>
                    <button type="submit" class="btn btn-inline">Login</button>
                </form>
            </div>

        </div><!-- block Registered-->

    </div>

    <!-- Forgot your password -->
    <div class="block-forgot-pass">
        Forgot your password ? <a href="Login.html">Click Here</a>
    </div><!-- Forgot your password -->

    <div class="modal-login modal">
        <h2>{$t.users.login.title}</h2>
        <div class="form-block">
            <form action="route/users/login" class="form-login" data-href="28" method="post" id="usersLogin">
                <div class="form-group">
                    <label for="email-modal">{$t.users.login.email}</label>
                    <input id="email-modal" required name="data[email]" type="email">
                </div>
                <div class="form-group">
                    <label for="pass-modal">{$t.users.login.password}</label>
                    <input id="pass-modal" required name="data[password]" class="alert" type="password">
                </div>
                <a href="" class="link-red b-users-fp">{$t.users.login.fp_link}</a>
                <input type="hidden" name="token" value="{$token}">
                <button type="submit" class="btn-red">{$t.users.login.button}</button>
                <button type="button" class="btn-clear close b-users-cancel">{$t.users.login.cancel}</button>
            </form>
        </div>
        {*{$events->call('users.form.login', $page)}*}
    </div>
{/block}