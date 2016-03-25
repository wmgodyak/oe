{if $page.images|count}
<div class="row">
    <div class="col-md-12">
        <div class="flexslider">
            <ul class="slides">
                {foreach $page.images as $item}
                <li>
                    <img src="{$item.path}/slider/{$item.image}" alt="{$page.name}" />
                </li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>
{/if}