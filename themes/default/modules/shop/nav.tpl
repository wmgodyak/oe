{*{if !$app->cache->exists('shop.main.nav')}*}
    {*{$app->cache->begin('shop.main.nav', 60*60)}*}
    <!-- begin sidebar -->
    <aside class="sidebar sidebar-collapse">
        <!-- begin m_goods-nav -->
        <nav class="m_goods-nav {if $page.id > 1 }collapse{/if}">
            <div class="goods-nav__header">
                <a href="javascript:;">КАТАЛОГ ТОВАРІВ</a>
            </div>
            <ul class="goods-nav__list" {if $page.id > 1 }style="display: none;" {/if}>
                {foreach $mod->shop->categories(0, 3) as $i=>$cat}
                <li class="goods-nav__item {$app->contentMeta->get($cat.id,'icon_class', true)}">
                    <a class="goods-nav__link" title="{$cat.title}" href="{$cat.id}">{$cat.name}</a>
                    {if $cat.isfolder}
                    <div class="sub-menu">
                        <div class="content my-grid">
                            {foreach $cat.items as $item}
                            <div class="item">
                                <ul class="single-category">
                                    <li><a class="text-head" href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
                                    {if $item.isfolder}
                                        {foreach $item.items as $k=>$sub}
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
    {*{$app->cache->get('shop.main.nav')}*}
{*{/if}*}