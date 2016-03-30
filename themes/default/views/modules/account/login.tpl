
<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1">Login form</a>
            </h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">

                            <form role="form" action="ajax/account/login" data-href="31" method="post" id="accountLogin">
                               <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" name="data[email]" required />
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" name="data[password]" required />
                                </div>
                                <div class="submit">
                                    <button type="submit" class="button-clear">
                                        <span>Login</span>
                                    </button>
                                </div>
                                <input type="hidden" name="token" value="{$token}">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="already-account">
                Go to register
                <a href="30" data-toggle="popover" data-placement="top" data-content="Register here!" data-trigger="manual">register  here</a> |
                <a href="34">forgot passwd</a>
            </div>
        </div>
    </div>
</div>