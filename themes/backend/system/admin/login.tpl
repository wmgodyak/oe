{extends file="index.tpl"}
{block name=body}
    <section class="log-in">
        <div class="table">
            <div class="table-cell">
                <form class="login" action="admin/login" data-redirect="/{$settings->get('backend_url')}/dashboard" data-backend-url="{$settings->get('backend_url')}" method="post" id="adminLogin">
                    {block name="backend.login.logo"}
                    <div class="logo">
                        <img src="{filter_apply('backend.login.logo', "`$theme_url`assets/img/logo/logo.png")}">
                    </div>
                    {/block}
                    <div class="input-group transformed">
                        <label for="email">{$t.admin.email}</label>
                        <input type="email" name="data[email]" id="email" required>
                    </div>
                    <div class="input-group transformed">
                        <label for="password">{$t.admin.password}</label>
                        <input type="password" name="data[password]" id="password">
                        <div class="show-value" id="show-pass">
                            <i class="fa fa-eye"></i>
                            <i class="fa fa-eye-slash"></i>
                        </div>
                    </div>
                    <div class="input-group transformed">
                        <label for="lang" class="l-lang">{$t.admin.lang}</label>
                        <select name="data[lang]" id="adminLang">
                            {foreach $langs as $code=>$lang}
                                <option value="{$code}">{$lang}</option>
                            {/foreach}
                        </select>
                    </div>
                    {$events->call('backend.login.form')}
                    <div class="f-link">
                        <a href="#" class="b-admin-fp" onclick="return false;">{$t.admin.fp_link}</a>
                    </div>
                    <button type="submit" class="btn btn-info btn-lg rippler rippler-default" style="height: 60px!important; line-height:60px; padding: 0 40px; font-size: 20px;width: auto;">{$t.admin.b_login}</button>
                    <input type="hidden" name="token" value="{$token}">
                </form>

                <form class="login" action="admin/fp"  data-redirect="/{$settings->get('backend_url')}/dashboard" method="post" id="adminFp" style="display: none">
                    <div class="logo">
                        <img src="{$theme_url}assets/img/logo/logo.png">
                    </div>
                    <div class="input-group">
                        <label for="email">{$t.admin.email}</label>
                        <input type="email" name="data[email]" id="email" required>
                    </div>
                    <div class="f-link">
                        <a href="#" class="b-admin-login" onclick="return false;">{$t.admin.login_link}</a>
                    </div>
                    <button type="submit" class="btn btn-info btn-lg rippler rippler-default">{$t.admin.b_send_pass}</button>
                    <input type="hidden" name="token" value="{$token}">
                </form>
            </div>
        </div>
    </section>
{/block}