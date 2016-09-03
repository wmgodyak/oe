{if $page.isfolder}
    {assign var = 'subnav' value=$mod->shop->categories($page.id)}
    {if $subnav|count}
       <div  class="shop-sub-nav">
           {assign var= 'nav' value=array_chunk_part($subnav, 4)}
           {foreach $nav as $ul}
            <ul>
                {foreach $ul as $i=>$cat}
                    <li><a href="{$cat.id}" title="{$cat.title}">{$cat.name}</a></li>
                {/foreach}
            </ul>
           {/foreach}
       </div>
        <div class="clearfix" style="clear: both;display: table;"></div>
    {/if}
{/if}