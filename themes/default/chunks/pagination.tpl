{if $pagination.pages|count}
    <div class="clearfix blog-pagination filters-container  wow fadeInUp outer-top-bd">
        <div class="text-right">
            <div class="pagination-container">
                <ul class="list-inline list-unstyled">
                    {if $pagination.prev !=''}
                        <li class="prev"><a href="{$pagination.prev}"><i class="fa fa-angle-left"></i></a></li>
                    {/if}
                    {foreach $pagination.pages as $item}
                        <li class="{$item.class}"><a {if $item.url}href="{$item.url}"{/if}>{$item.name}</a></li>
                    {/foreach}
                    {if $pagination.next != ''}
                        <li class="next"><a href="{$pagination.next}"><i class="fa fa-angle-right"></i></a></li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>
{/if}