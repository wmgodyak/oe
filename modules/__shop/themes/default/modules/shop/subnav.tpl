{assign var="nav_key" value="shop.nav`$page.id`"}
{if !$app->cache->exists($nav_key)}
{$app->cache->begin($nav_key, 60*60)}
{*{if $page.isfolder}*}
    {assign var = 'subnav' value=$mod->shop->categories($page.id)}
    {if $subnav|count}
        {assign var = 'img' value=$app->images->cover($page.id, 'catsm')}

        {if $img == '/uploads/noimage.jpg'}
            {assign var='parent_id' value=$app->page->data($page.id, 'parent_id')}
            {if $parent_id > 0}
                {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                {if $img == '/uploads/noimage.jpg'}
                    {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                    {if $parent_id > 0}
                        {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                        {if $img == '/uploads/noimage.jpg'}
                            {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                            {if $parent_id > 0}
                                {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                                {if $img == '/uploads/noimage.jpg'}
                                    {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                                    {if $parent_id > 0}
                                        {assign var='img' value=$app->images->cover($parent_id, 'catsm')}
                                    {/if}
                                {/if}
                            {/if}
                        {/if}
                    {/if}
                {/if}
            {/if}
        {/if}



        {assign var='col' value=3}

        <div  class="shop-sub-nav">
        {*{if $img != '/uploads/noimage.jpg'}*}
           <div class="img">
               <img src="{$img}" alt="" class="sub-nav-cat-img" style="max-width: 100px; max-height:100px;">
           </div>
        {*{/if}*}
           {assign var= 'nav' value=array_chunk_part($subnav, $col)}
           {foreach $nav as $ul}
            <ul>
                {foreach $ul as $i=>$cat}
                    {assign var = 'img' value=$app->images->cover($cat.id, 'catsm')}

                    {if $img == '/uploads/noimage.jpg'}
                        {assign var='parent_id' value=$app->page->data($cat.id, 'parent_id')}
                        {if $parent_id > 0}
                            {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                            {if $img == '/uploads/noimage.jpg'}
                                {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                                {if $parent_id > 0}
                                    {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                                    {if $img == '/uploads/noimage.jpg'}
                                        {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                                        {if $parent_id > 0}
                                            {assign var='img' value=$app->images->cover($parent_id, 'catsm')}

                                            {if $img == '/uploads/noimage.jpg'}
                                                {assign var='parent_id' value=$app->page->data($parent_id, 'parent_id')}
                                                {if $parent_id > 0}
                                                    {assign var='img' value=$app->images->cover($parent_id, 'catsm')}
                                                {/if}
                                            {/if}
                                        {/if}
                                    {/if}
                                {/if}
                            {/if}
                        {/if}
                    {/if}

                    <li><a data-img="{$img}" class="subnav-link" href="{$cat.id}" title="{$cat.title}">{$cat.name}</a></li>
                {/foreach}
            </ul>
           {/foreach}
       </div>
        <div class="clearfix" style="clear: both;display: table;"></div>
    {/if}
{*{/if}*}

{$app->cache->end()}
{else}
{$app->cache->get($nav_key)}
{/if}