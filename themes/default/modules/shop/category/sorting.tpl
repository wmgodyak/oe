{assign var="sorting" value=$app->guides->get('shop.sorting', 'position')}
{if $sorting|count}
<div class="sort">
    {*{d($sorting)}*}
    <form>
        <div class="sort-label-group">
            <div class="label">{$sorting.name}:</div>
        </div>

        <div class="sort-select-group">
            <select class="jq-select" name="sort" onchange="submit()">
                {foreach $sorting.items as $item}
                    <option {if isset($smarty.get.sort) && $smarty.get.sort == $item.external_id}selected{/if} value="{$item.external_id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>


        <div class="sort-btn-group">
            <button class="sort-btn sort-btn1 shop-display-mode {if $smarty.session.display_mode == 'list'}sort-btn--active{/if}" data-mode="list"></button>
            <button class="sort-btn sort-btn2 shop-display-mode {if !$smarty.session.display_mode || $smarty.session.display_mode == 'grid'}sort-btn--active{/if}" data-mode="grid"></button>
        </div>

        {if $smarty.get|count > 0}
            {foreach $smarty.get as $k=>$v}
                {if $k != 'sort' && $k != 'p'}
                    <input type="hidden" name="{$k}" value="{$v}">
                {/if}
            {/foreach}
        {/if}
    </form>
</div>
{/if}