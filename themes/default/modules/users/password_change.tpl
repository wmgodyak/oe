{extends 'layouts/pages/fw.tpl'}
{block name='meta.title'}{t('users.profile_psw.title')}{/block}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.profile_psw.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.profile_psw.form.description')}


                        <form method="post" action="/change-password" id="usersPasswordChangeForm" data-href="{url('profile')}">

                            <div class="form-group">
                                <input type="password" required name="password" class="form-control" placeholder="{t('users.profile_psw.form.labels.password')}">
                            </div>
                            <div class="form-group">
                                <input type="password" required name="password_c" class="form-control" placeholder="{t('users.profile_psw.form.labels.password_c')}">
                            </div>
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.profile_psw.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}