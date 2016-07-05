{*{if $app->languages->get()}*}
<!-- begin lang-switcher -->
<div class="lang-switcher">
    <span>Мова:</span>
    <ul class="lang-switcher__list">
        {foreach $app->languages->get() as $item}
        <li class="lang-switcher__item lang-switcher__item--active">
            <a class="lang-switcher__link" href="{$page.id};lang={$item.id}">{$item.name}</a>
        </li>
        {/foreach}
    </ul>
</div>
<!-- end lang-switcher -->
{*{/if}*}