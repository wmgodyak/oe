<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1">Forgot password</a>
            </h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">

                            <form role="form" action="ajax/account/fp" data-href="1" method="post" id="accountFp">
                                <div class="response"></div>
                               <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" name="data[email]" required />
                                </div>
                                <div class="submit">
                                    <button type="submit" class="button-clear">
                                        <span>Reset</span>
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
                <a href="30" >register here</a> |
                <a href="29">login</a>
            </div>
        </div>
    </div>
</div>