<!-- begin banners -->
<div class="banners">

    <div class="row">
        <div class="m_banner-slider">
            {foreach $mod->banners->get('home-top') as $item}
            <div class="slide" style="background-image: url('{$item.img}');"></div>
            {/foreach}
        </div>
    </div>

    <div class="row clearfix">
        {foreach $mod->banners->get('home-bottom', 2, 'rand') as $item}
            <div class="m_small-banner">
                <div class="wrap" style="background-image: url('{$item.img}');">
                    <a href="{$item.url}" class="btn md white-red">{$t.banners.more}</a>
                </div>
            </div>
        {/foreach}
    </div>

</div>
<!-- end banners -->