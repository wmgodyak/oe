
<!-- Toolbar -->
<div class=" toolbar-products toolbar-{$cls}">

    <div class="modes">
        <strong  class="label">View as:</strong>
        <strong class="modes-mode active mode-grid shop-display-mode" data-mode="grid" title="Grid">
            <span>grid</span>
        </strong>
        <a href="javascript:;" title="List" class="modes-mode mode-list shop-display-mode" data-mode="list">
            <span>list</span>
        </a>
    </div><!-- View as -->

    <form class="toolbar-option" action="{$url}">

        {if $smarty.get.minp > 0}<input type="hidden" name="minp" value="{$smarty.get.minp}">{/if}
        {if $smarty.get.maxp > 0}<input type="hidden" name="maxp" value="{$smarty.get.maxp}">{/if}

        <div class="toolbar-sorter ">
            <label class="label">Short by:</label>
            <select onchange="submit();" name="sort" class="sorter-options form-control" >
                {foreach $category.sorting as $k=>$v}
                    <option value="{$v}" {if $smarty.get.sort == $v}selected{/if}>{$v}</option>
                {/foreach}
            </select>
        </div><!-- Short by -->

        <div class="toolbar-limiter">
            <label   class="label">
                <span>Show:</span>
            </label>

            <select onchange="submit();" name="ipp" class="limiter-options form-control" >
                {foreach $category.paginate_options as $k=>$v}
                <option value="{$v}" {if $smarty.get.ipp ==$v}selected{/if}>{$v}</option>
                {/foreach}
            </select>

        </div><!-- Show per page -->

    </form>

    {if $category.pagination}{$category.pagination->display()}{/if}
</div><!-- Toolbar -->