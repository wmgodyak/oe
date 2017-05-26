{if !$user}
    <ul class="hotline nav-left">
        <li><span class="wellcome">Wellcome to {settings('company_name')}
                <a href="{route('register')}">register</a>
                <span>or</span>
                <a href="{route('login')}">login</a>
            </span>
        </li>
    </ul>
{else}
    <ul class="hotline nav-left">
        <li>
            <span class="wellcome">Hi, {$user.name}
                <a href="{route('profile')}">Profile</a> | <a href="/logout">Logout</a>
            </span>
        </li>
    </ul>
{/if}