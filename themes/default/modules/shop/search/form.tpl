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
<!-- begin tel-search__bottom -->
<div class="tel-search__bottom">
    <form class="search-form" action="8" id="searchForm">
        <input id="shopLiveSearch" tabindex="1" type="text" required name="q" value="{if isset($smarty.get.q)}{$smarty.get.q}{/if}" placeholder="Пошук по сайту">
        <select class="jq-select" name="cat" id="search_cat">
            <option value="" data-href="">Усі категорії</option>
            {call doCategories categories=$mod->shop->categories()}
        </select>
        <button class="search-btn" type="submit"></button>
    </form>
</div>
<!-- end tel-search__bottom -->