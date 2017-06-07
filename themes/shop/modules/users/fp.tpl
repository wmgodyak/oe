{extends 'layouts/pages/fw.tpl'}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.login.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.login.form.description')}
                        <form method="post" action="forgot-password" id="usersFpForm" data-href="{route('reset-password')}">
                            <div class="form-group">
                                <input type="text" required name="email" class="form-control" placeholder="{t('users.login.form.labels.email')}">
                            </div>
                            <div class="checkbox">
                                <label><a href="{route('login')}">{t('users.login.links.login')}</a></label>
                                <label><a href="{route('register')}">{t('users.login.links.register')}</a></label>
                            </div>
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.login.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}