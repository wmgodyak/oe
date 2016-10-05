{if !$user}
    <!-- begin login-block -->
    <div class="user-login">
        <a class="user-login__link b-users-login" href="javascript:void(0);" title="{$t.users.login_title}">{$t.users.b_login}</a>
        <span>чи</span>
        <a class="user-login__link b-users-register" href="javascript:void(0);" title="{$t.users.register_title}">{$t.users.b_register}</a>
    </div>
    <!-- end login-block -->
{else}
    <div class="user-login">
        <a class="user-login__link" href="28" title="{$t.users.welcome_title}">{sprintf($t.users.welcome, $user.name)}</a>{* $t.users.b_profile *}
        <a class="user-login__link" href="route/users/logout" title="{$t.users.logout_title}">{$t.users.b_logout}</a>
    </div>
{/if}