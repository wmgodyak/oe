<div class="profile_links">
    <h3 class="head">Мій профіль</h3>
    <ul class="list">
        {foreach $app->nav->get('user') as $item}
            <li><a href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
        {/foreach}
        {$events->call('user.profile.nav', $user)}

        <li><a href="route/users/logout">{$t.users.b_logout}</a></li>
    </ul>
    {$events->call('user.profile.sidebar', $user)}
</div>
{$events->call('user.profile.sidebar.after', $user)}