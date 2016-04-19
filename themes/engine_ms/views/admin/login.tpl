<section class="log-in">
    <div class="table">
        <div class="table-cell">
            <form class="login" action="admin/login" method="post" id="adminLogin">
                <div class="logo">
                    <img src="{$theme_url}assets/img/logo/logo.png">
                </div>
                <div class="input-group">
                    <label for="email">{$t.admin.email}</label>
                    <input type="email" name="data[email]" id="email" required>
                </div>
                <div class="input-group">
                    <label for="password">{$t.admin.password}</label>
                    <input type="password" name="data[password]" id="password">
                    <div class="show-value" id="show-pass">
                        <i class="fa fa-eye"></i>
                        <i class="fa fa-eye-slash"></i>
                    </div>
                </div>
                <div class="input-group">
                    <label for="lang">{$t.admin.lang}</label>
                    <select name="data[lang]" id="adminLang">
                        {foreach $langs as $lang}
                            <option {if $lang.code == $s_lang}selected{/if} value="{$lang.code}">{$lang.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="f-link">
                    <a href="#" class="b-admin-fp" onclick="return false;">{$t.admin.fp_link}</a>
                </div>
                <button type="submit" class="btn btn-info btn-lg rippler rippler-default">{$t.admin.b_login}</button>
                <input type="hidden" name="token" value="{$token}">
            </form>

            <form class="login" action="admin/fp" method="post" id="adminFp" style="display: none">
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