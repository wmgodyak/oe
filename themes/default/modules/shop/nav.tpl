{*{assign var="nav_key" value="shop.main.nav"}*}
{*{assign var="nav_key" value=$nav_key + $page.types_id}*}
{*{if !$app->cache->exists($nav_key)}*}
    {*{$app->cache->begin($nav_key, 60*60)}*}

    <aside class="sidebar sidebar-collapse">

        <nav class="m_goods-nav {if $page.id > 1 }collapse{/if}">
            <div class="goods-nav__header">
                <a href="javascript:;">{$t.shop.nav}</a>
            </div>
            <ul class="goods-nav__list" {if $page.id > 1 }style="display: none;" {/if}>
                {foreach $mod->shop->categories(0) as $i=>$cat}
                    {if $app->contentMeta->get($cat.id, 'hide_nav', true) != 1}
                     <li class="goods-nav__item {$app->contentMeta->get($cat.id,'icon_class', true)}">
                     <a class="goods-nav__link" title="{$cat.title}" {if $page.id != $cat.id}href="{$cat.id}"{/if} >{$cat.name}</a>
                    {if $cat.isfolder}
                    <div class="sub-menu">
                        <div class="content my-grid">
                            <div class="row">
                                {foreach $mod->shop->categories($cat.id) as $item}
                                    {if $app->contentMeta->get($item.id, 'hide_nav', true) != 1}
                                        <div class="item {if $item.isfolder}item-sub{/if}">
                                    <div class="single-category">
                                        <div class="text-head" >
                                            <a {if $page.id != $item.id}href="{$item.id}"{/if} title="{$item.title}">{$item.name}</a>
                                        </div>
                                        <div class="wrap-row">
                                            <div class="wrap-img">
                                                {assign var='cat_im' value=$app->images->cover($item.id, 'catsm')}
                                                {if $cat_im == '/uploads/noimage.jpg'}{assign var='cat_im' value=$app->images->cover($cat.id, 'catsm')}{/if}
                                                <a href="{$item.id}"><img src="{$cat_im}" alt="{$item.name}"></a>
                                            </div>
                                            {if $item.isfolder}
                                                <div class="item-sub-list">
                                                    {foreach $mod->shop->categories($item.id) as $k=>$sub}
                                                        {if $app->contentMeta->get($sub.id, 'hide_nav', true) != 1}
                                                            {assign var='im' value=$app->images->cover($sub.id, 'catsm')}
                                                            {if $im == '/uploads/noimage.jpg'}{assign var='im' value=$app->images->cover($item.id, 'catsm')}{/if}
                                                            {if $im == '/uploads/noimage.jpg'}{assign var='im' value=$app->images->cover($cat.id, 'catsm')}{/if}
                                                            {if $k < 6}
                                                                <a class="link" {if $page.id != $sub.id}href="{$sub.id}" {/if} title="{$sub.title}" rel="{$im}">{$sub.name}</a>
                                                            {/if}
                                                            {if $k == 6}
                                                                <a class="link" href="{$item.id}" title="{$item.title}" rel="{$cat_im}">Переглянути всі</a>
                                                            {/if}
                                                        {/if}
                                                    {/foreach}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    {/if}
                </li>
                    {/if}
                {/foreach}
            </ul>
        </nav>

    </aside>

    {*{$app->cache->end()}*}
{*{else}*}
    {*{$app->cache->get($nav_key)}*}
{*{/if}*}