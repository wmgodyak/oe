<!-- begin main-nav -->
<nav class="main-nav">
    <ul class="main-nav__list">
        {foreach $app->nav->get('top') as $item}
        <li class="main-nav__item">
            <a class="main-nav__link" href="{$item.id}" title="{$item.title}">{$item.name}</a>
        </li>
        {/foreach}
    </ul>
</nav>
<!-- end main-nav -->