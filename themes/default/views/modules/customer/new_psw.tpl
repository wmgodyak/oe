<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1">New password</a>
            </h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">
                            {if !$user.id}
                                <p>Wrong key</p>
                                {else}
                                <form role="form" action="ajax/account/newPsw" data-href="29" method="post" id="accountNewPsw">
                                    <div class="response"></div>
                                    <p>Change password</p>
                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <input type="password" class="form-control" name="data[password]" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="password_c">Password Confirm</label>
                                        <input type="password" class="form-control" name="data[password_c]" required />
                                    </div>
                                    <div class="submit">
                                        <button type="submit" class="button-clear">
                                            <span>Save</span>
                                        </button>
                                    </div>
                                    <input type="hidden" name="token" value="{$token}">
                                    <input type="hidden" name="id"    value="{$user.id}">
                                </form>
                            {/if}
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