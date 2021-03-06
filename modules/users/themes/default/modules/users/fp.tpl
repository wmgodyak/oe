{extends 'layouts/pages/fw.tpl'}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.fp.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.fp.form.description')}
                        <form method="post" action="forgot-password" id="usersFpForm" data-href="{url('reset-password')}">
                            <div class="form-group">
                                <input type="text" required name="email" class="form-control" placeholder="{t('users.fp.form.labels.email')}">
                            </div>
                            <div class="checkbox">
                                <label><a href="{url('login')}">{t('users.links.login')}</a></label> |
                                <label><a href="{url('register')}">{t('users.links.register')}</a></label>
                            </div>
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.fp.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}