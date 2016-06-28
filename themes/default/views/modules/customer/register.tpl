
<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1">OYi.Engine7</a>
            </h3>
            <h4>Set up your new account today.</h4>
            <p>
                30-day money-back guarantee that starts after your first payment.
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">


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
                                <div class="form-group">
                                    <label for="password_c">Password Confirm</label>
                                    <input type="password" class="form-control" name="data[password_c]" required />
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
                        </div>
                    </div>
                </div>
            </div>
            <div class="already-account">
                Already have an account?
                <a href="29" data-toggle="popover" data-placement="top" data-content="Go to sign in!" data-trigger="manual">Sign in here</a>
            </div>
        </div>
    </div>
</div>