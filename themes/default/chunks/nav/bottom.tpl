<div class="footer__heading">
    {$t.theme.info}
</div>
<div class="footer-nav">
    <ul class="footer-nav__list">
        {foreach $app->nav->get('bottom') as $item}
        <li class="footer-nav__item">
            <a class="footer-nav__link" href="{$item.id}" title="{$item.title}">{$item.name}</a>
        </li>
        {/foreach}
    </ul>
</div>