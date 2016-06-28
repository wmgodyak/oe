<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1" title="home">{$page.name}</a>
            </h3>
            <p>
                {$page.content}
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">
                            <form role="form" action="ajax/account/profile" method="post" id="accountProfile">
                                <div class="response"></div>
                                <div class="form-group">
                                    <label for="name">Your name</label>
                                    <input type="text" class="form-control" name="data[name]" value="{$user.name}" required />
                                </div>
                                <div class="form-group">
                                    <label for="surname">Your surname</label>
                                    <input type="text" class="form-control" name="data[surname]"  value="{$user.surname}" required />
                                </div>
                                <div class="form-group">
                                    <label for="phone">Your phone</label>
                                    <input type="text" class="form-control" name="data[phone]"  value="{$user.phone}" required />
                                </div>
                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" name="data[email]"  value="{$user.email}" required />
                                </div>
                                <div class="submit">
                                    <button type="submit" class="button-clear">
                                        <span>Save</span>
                                    </button>
                                </div>
                                <input type="hidden" name="token" value="{$token}">
                            </form>

                            <form role="form" action="ajax/account/updatePassword" method="post" id="accountUpdatePassword">
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
                            </form>

                            <p><a href="route/account/logout">Logout</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>