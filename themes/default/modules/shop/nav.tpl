{*{assign var="nav_key" value="shop.main.nav"}*}
{*{assign var="nav_key" value=$nav_key + $page.types_id}*}
{*{if !$app->cache->exists($nav_key)}*}
    {*{$app->cache->begin($nav_key, 3*60)}*}
    <!-- begin sidebar -->
    <aside class="sidebar sidebar-collapse">
        <!-- begin m_goods-nav -->
        <nav class="m_goods-nav {if $page.id > 1 }collapse{/if}">
            <div class="goods-nav__header">
                <a href="javascript:;">КАТАЛОГ ТОВАРІВ</a>
            </div>
            <ul class="goods-nav__list" {if $page.id > 1 }style="display: none;" {/if}>
                {foreach $mod->shop->categories(0) as $i=>$cat}
                <li class="goods-nav__item {$app->contentMeta->get($cat.id,'icon_class', true)}">
                    <a class="goods-nav__link" title="{$cat.title}" href="{$cat.id}">{$cat.name}</a>
                    {if $cat.isfolder}
                    <div class="sub-menu">
                        <div class="content my-grid">
                            <div class="row">
                                {foreach $mod->shop->categories($cat.id) as $item}
                                <div class="item">
                                    <ul class="single-category">
                                        <li><a class="text-head" href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
                                        {if $item.isfolder}
                                            {foreach $mod->shop->categories($item.id) as $k=>$sub}
                                                {if $k < 6}
                                                <li><a class="link" href="{$sub.id}" title="{$sub.title}">{$sub.name}</a></li>
                                                {/if}
                                            {/foreach}
                                        {/if}
                                    </ul>
                                </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    {/if}
                </li>
                {/foreach}
            </ul>
        </nav>
        <!-- end m_goods-nav -->
    </aside>
    <!-- end sidebar -->
    {*{$app->cache->end()}*}
{*{else}*}
    {*{$app->cache->get($nav_key)}*}
{*{/if}*}