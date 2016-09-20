<!-- begin banners -->
<div class="banners">
    <div class="row">
        <div class="m_banner-slider">
            {foreach $mod->shopActions->getBanners('top') as $item}
                <div class="slide" style="background-image: url('{$item.image}');">{if $item.clickable}<a href="{$item.url}"></a>{/if}</div>
            {/foreach}
        </div>
    </div>
    <div class="row clearfix">
        {foreach $mod->shopActions->getBanners('bottom', 2) as $item}
            <div class="m_small-banner">
                <div class="wrap" style="background-image: url('{$item.image}');">
                    {if $item.clickable}<a href="{$item.url}" class="btn md white-red">{$t.shopActions.more}</a>{/if}
                </div>
            </div>
        {/foreach}
    </div>
</div>
<!-- end banners -->