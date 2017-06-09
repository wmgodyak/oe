{extends 'layouts/pages/fw.tpl'}
{block name='meta.title'}{t('users.reset_password.title')}{/block}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.reset_password.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.reset_password.form.description')}


                        <form method="post" action="/restore-password" id="usersPasswordResetForm" data-href="{route('login')}">

                            <div class="form-group">
                                <input type="password" required name="password" class="form-control" placeholder="{t('users.reset_password.form.labels.password')}">
                            </div>
                            <div class="form-group">
                                <input type="password" required name="password_c" class="form-control" placeholder="{t('users.reset_password.form.labels.password_c')}">
                            </div>
                            <input type="hidden" name="skey" value="{$skey}">
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.reset_password.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}