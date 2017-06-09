{extends 'layouts/pages/fw.tpl'}
{block name='meta.title'}{t('users.profile.title')}{/block}
{block name="container"}
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="block-form-login">
                <div class="block-form-registered">
                    <div class="block-title">
                        {t('users.account.title')}
                    </div>
                    <div class="block-content">
                        {block name="users.account.content"}
                            {$events->call('users.account.content')}
                        {/block}
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}