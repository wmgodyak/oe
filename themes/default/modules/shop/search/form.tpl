{function name=doCategories}
    {foreach $categories as $cat}
        {* if $cat.isfolder}*}
            {*<optgroup>*}
                {*{call doCategories categories=$cat.items}*}
            {*</optgroup>*}
        {*{else}*}
            <option {if isset($smarty.get.cat) && $smarty.get.cat == $cat.id}selected{/if} data-href="{$cat.id}" value="{$cat.id}">{$cat.name}</option>
        {*{/if}*}
    {/foreach}
{/function}
{assign var="ckey" value="shop.search`$page.id`x`$page.languages_id`"}
{if !$app->cache->exists($ckey)}
{$app->cache->begin($ckey, 60*60)}
<div class="tel-search__bottom">
    <form class="search-form" action="8" id="searchForm">
        <input id="shopLiveSearch" tabindex="1" type="text" required name="q" value="{if isset($smarty.get.q)}{$smarty.get.q}{/if}" placeholder="Пошук по сайту">
        <select data-placeholder='{$t.theme.select_placeholder}' class="jq-select" name="cat" id="search_cat">
            <option value="" data-href="">{$t.theme.select_all}</option>
            {foreach $mod->shop->categories(0) as $cat}
                <option {if isset($smarty.get.cat) && $smarty.get.cat == $cat.id}selected{/if} data-href="{$cat.id}" value="{$cat.id}">{$cat.name}</option>
            {/foreach}
            {*{call doCategories categories=$mod->shop->categories(0)}*}
        </select>
        <button class="search-btn" type="submit"></button>
    </form>
</div>

    {$app->cache->end()}
{else}
    {$app->cache->get($ckey)}
{/if}
