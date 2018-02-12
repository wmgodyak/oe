{if !$user}
    <ul class="hotline nav-left">
        <li><span class="wellcome">Wellcome to {settings('company_name')}
                <a href="{url('register')}">register</a>
                <span>or</span>
                <a href="{url('login')}">login</a>
            </span>
        </li>
    </ul>
{else}
    <ul class="hotline nav-left">
        <li>
            <span class="wellcome">Hi, {$user.name}
                <a href="{url('profile')}">Profile</a> | <a href="{url('logout')}">Logout</a>
            </span>
        </li>
    </ul>
{/if}