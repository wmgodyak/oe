{assign var="nav_key" value="shop.main.nav"}
{assign var="nav_key" value=$nav_key + $page.types_id}
{if !$app->cache->exists($nav_key)}
    {$app->cache->begin($nav_key, 3*60)}
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
                                <div class="item {if $item.isfolder}item-sub{/if}">
                                    <div class="single-category">
                                        <div class="text-head" >
                                            <a href="{$item.id}" title="{$item.title}">{$item.name}</a>
                                        </div>
                                        <div class="wrap-row">
                                            <div class="wrap-img">
                                                <img src="{$theme_url}assets/img/weather.jpg" alt="">
                                            </div>
                                            {if $item.isfolder}
                                                <div class="item-sub-list">
                                                    {foreach $mod->shop->categories($item.id) as $k=>$sub}
                                                        {if $k < 6}
                                                        <a class="link" href="{$sub.id}" title="{$sub.title}" rel="{$theme_url}assets/img/noimage.jpg">{$sub.name}</a>
                                                        {/if}
                                                    {/foreach}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
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
    {$app->cache->end()}
{else}
    {$app->cache->get($nav_key)}
{/if}