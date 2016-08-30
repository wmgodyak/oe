{if !$user}
    <!-- begin login-block -->
    <div class="user-login">
        <a class="user-login__link b-users-login" href="javascript:void(0);">{$t.users.b_login}</a>
        <span>чи</span>
        <a class="user-login__link b-users-register" href="javascript:void(0);">{$t.users.b_register}</a>
    </div>
    <!-- end login-block -->
{else}
    <div class="user-login">
        <a class="user-login__link" href="28">{$t.users.b_profile}</a>
        <a class="user-login__link" href="route/users/logout">{$t.users.b_logout}</a>
    </div>
{/if}