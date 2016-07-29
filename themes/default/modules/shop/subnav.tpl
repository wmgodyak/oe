{if $page.isfolder}
   <div  class="shop-sub-nav">
    <h2>Підкатегорії</h2>
    <ul>
    {foreach $mod->shop->categories($page.id) as $i=>$cat}
        <li><a href="{$cat.id}" title="{$cat.title}">{$cat.name}</a></li>
    {/foreach}
    </ul>
   </div>
{/if}