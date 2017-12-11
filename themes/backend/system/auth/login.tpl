{extends file="index.tpl"}
{block name=body}
    <section class="log-in">
        <div class="table">
            <div class="table-cell">
                <form class="login" action="auth/login" data-redirect="/{$settings->get('backend_url')}/dashboard" data-backend-url="{$settings->get('backend_url')}" method="post" id="adminLogin">
                    {block name="backend.login.logo"}
                    <div class="logo">
                        <img src="{filter_apply('backend.login.logo', "`$theme_url`assets/img/logo/logo.png")}">
                    </div>
                    {/block}
                    <div class="input-group transformed">
                        <label for="email">{t('auth.email')}</label>
                        <input type="email" name="data[email]" id="email" required>
                    </div>
                    <div class="input-group transformed">
                        <label for="password">{t('auth.password')}</label>
                        <input type="password" name="data[password]" id="password" required>
                        <div class="show-value" id="show-pass">
                            <i class="fa fa-eye"></i>
                            <i class="fa fa-eye-slash"></i>
                        </div>
                    </div>
                    <div class="input-group transformed">
                        <label for="lang" class="l-lang">{t('auth.lang')}</label>
                        <select name="data[lang]" id="adminLang">
                            <option value="">Default</option>
                            {foreach $langs as $code=>$lang}
                                <option value="{$code}">{$lang}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="input-group transformed ask" style="display: none">
                        <label for="lang" class="l-lang">{t('auth.captcha')}</label>
                        <div>
                            <img src="auth/pic" id="ask_img" title="Click to refresh" alt="pic" style="width: 180px; height:44px; float: left; cursor: pointer;">
                            <input type="text" name="{$c_key}" id="ask_i"  style="width: 50%; float: left; margin-left: 15px;">
                        </div>
                        <div class="clear" style="clear: both;"></div>
                    </div>
                    {$events->call('backend.login.form')}
                    <div class="f-link">
                        <a href="#" class="b-admin-fp" onclick="return false;">{t('auth.fp_link')}</a>
                    </div>
                    <button type="submit" class="btn btn-info btn-lg rippler rippler-default" style="height: 60px!important; line-height:60px; padding: 0 40px; font-size: 20px;width: auto;">{t('auth.b_login')}</button>
                    <input type="hidden" name="token" value="{$token}">
                </form>

                <form class="login" action="auth/fp"  data-redirect="/{$settings->get('backend_url')}/dashboard" method="post" id="adminFp" style="display: none">
                    <div class="logo">
                        <img src="{$theme_url}assets/img/logo/logo.png">
                    </div>
                    <div class="input-group">
                        <label for="email">{t('auth.email')}</label>
                        <input type="email" name="data[email]" id="email" required>
                    </div>
                    <div class="f-link">
                        <a href="#" class="b-admin-login" onclick="return false;">{t('auth.login_link')}</a>
                    </div>
                    <button type="submit" class="btn btn-info btn-lg rippler rippler-default">{t('auth.b_send_pass')}</button>
                    <input type="hidden" name="token" value="{$token}">
                </form>
            </div>
        </div>
    </section>
{/block}