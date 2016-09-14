{if $similar|count}
   <div class="products-similar">
       <div class="title">Доступні інші варіанти:</div>
       {foreach $similar as $features}
            {*<div class="feature">*}
                {*{$features.name}*}
            {*</div>*}
           <div class="products">
               {foreach $features.products as $item}
                   <a class="item" href="{$item.id}" title="{$item.name}">
                       <img src="{$app->images->cover($item.id, 'thumbs')}" style="width: 80px;" alt="">
                       <span>{$item.name}</span>
                   </a>
               {/foreach}
           </div>
       {/foreach}
   </div>
{/if}