{extends 'layouts/pages/fw.tpl'}
{block name='meta.title'}{t('users.profile.title')}{/block}
{block name="container"}
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.profile.form.title')}
                    </div>
                    <div class="block-content">
                        {t('users.profile.form.description')}
                        <form method="post" action="/profile" id="usersProfileForm">
                            {block name="users.profile.form"}
                                <div class="form-group">
                                    <input type="text" value="{$user.name}" required name="data[name]" class="form-control" placeholder="{t('users.profile.form.labels.name')}">
                                </div>
                                <div class="form-group">
                                    <input type="text" value="{$user.surname}" required name="data[surname]" class="form-control" placeholder="{t('users.profile.form.labels.surname')}">
                                </div>
                                <div class="form-group">
                                    <input type="email" value="{$user.email}" required name="data[email]" class="form-control" placeholder="{t('users.profile.form.labels.email')}">
                                </div>
                            {/block}
                            {$events->call('users.profile.form')}
                            <input type="hidden" name="token" value="{$token}">
                            <button type="submit" class="btn btn-inline">{t('users.profile.form.labels.submit')}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}