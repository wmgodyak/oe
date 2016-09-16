{if $page.isfolder}
    {assign var = 'subnav' value=$mod->shop->categories($page.id)}
    {assign var = 'img' value=$app->images->cover($page.id, 'source')}
    {assign var='col' value=3}

    {if $img == '/uploads/noimage.jpg'}{assign var='col' value=4}{/if}

    {if $subnav|count}
       <div  class="shop-sub-nav">
        {if $img != '/uploads/noimage.jpg'}
           <div class="img">
               <img src="{$img}" alt="">
           </div>
        {/if}
           {assign var= 'nav' value=array_chunk_part($subnav, $col)}
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