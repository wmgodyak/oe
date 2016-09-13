{assign var='similar' value=$mod->shop->products->similar($product)}
{*<pre>{print_r($similar)}</pre>*}
{if $similar|count}
    <div class="products-similar">
        <div class="title">Доступні інші варіанти:</div>
            <div class="products">
                {foreach $similar as $item}
                    <a class="item {if $item.id==$product.id}active{/if}" href="{$item.id}" title="{$item.name}">
                        <img src="{$app->images->cover($item.id, 'thumbs')}" style="width: 80px;" alt="">
                        <span>{$item.name}</span>
                    </a>
                {/foreach}
            </div>
    </div>
{/if}