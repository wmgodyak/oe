{assign var='similar' value=$mod->shop->products->similar($product)}

{*<pre>{print_r($similar)}</pre>*}
{if $similar|count > 1}
    {assign var='similar' value=array_chunk($similar, 3)}
    <div class="products-similar">
        <div class="title">Доступні інші варіанти:</div>
            <div class="products">
                {foreach $similar as $a}
                    <div>
                        {foreach $a as $item}
                            <a class="item {if $item.id==$product.id}active{/if}" href="{$item.id}" title="{$item.name}">
                                <img src="{$app->images->cover($item.id, 'thumbs')}" style="height:65px;" alt="">
                                <span>{shortText($item.name, 40)}</span>
                            </a>
                        {/foreach}
                    </div>
                {/foreach}
            </div>
    </div>
{/if}