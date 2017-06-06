{extends 'layouts/pages/fw.tpl'}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.register.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.register.form.description')}
                        <form method="post" action="{route('register')}" id="usersLoginForm">
                            <div class="form-group">
                                <input type="text" required name="data[email]" class="form-control" placeholder="{t('users.register.form.labels.email')}">
                            </div>
                            <div class="form-group">
                                <input type="password" required name="data[password]" class="form-control" placeholder="{t('users.register.form.labels.password')}">
                            </div>
                            <div class="form-group">
                                <input type="password" required name="data[password_c]" class="form-control" placeholder="{t('users.register.form.labels.password_c')}">
                            </div>
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.register.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}