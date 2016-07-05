<!-- begin m_breadcrumbs -->
<div class="m_breadcrumbs">
    <div class="container">
        <ul class="breadcrumbs__list">
            {foreach $mod->breadcrumbs->get() as $item}
            <li class="breadcrumbs__item{if $page.id == $item.id} breadcrumbs__item--current{/if}">
                <a href="{$item.id}" title="{$item.title}" class="breadcrumbs__link">{$item.name}</a>
            </li>
            {/foreach}
        </ul>
    </div>
</div>
<!-- end m_breadcrumbs -->