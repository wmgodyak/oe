<div class="social-intro">
    <h3>{$t.hybridAuth.login_as}</h3>
    {foreach $providers as $provider => $params}
        {if $params.enabled}
            <a href="route/hybridAuth/auth/{$provider}" class="block">
                <div class="icon {$provider}"></div>
                <div class="link">{$provider}</div>
                <div class="clearfix"></div>
            </a>
        {/if}
    {/foreach}
</div>
<div class="clearfix"></div>