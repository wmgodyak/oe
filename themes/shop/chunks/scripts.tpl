{assets('js/jquery.min.js')}
{assets('js/jquery.sticky.js')}
{assets('js/owl.carousel.min.js')}
{assets('js/bootstrap.min.js')}
{assets('js/jquery.countdown.min.js')}
{assets('js/jquery.bxslider.min.js')}
{assets('js/jquery.actual.min.js')}
{assets('js/jquery-ui.min.js')}
{assets('js/chosen.jquery.min.js')}
{assets('js/jquery.elevateZoom.min.js')}
{assets('js/fancybox/source/jquery.fancybox.pack.js')}
{assets('js/fancybox/source/helpers/jquery.fancybox-media.js')}
{assets('js/fancybox/source/helpers/jquery.fancybox-thumbs.js')}
{assets('js/arcticmodal/jquery.arcticmodal.js')}

{assets('js/main.js')}

{assets('js/app.js')}

{foreach $modules_scripts as $k=>$src}
    {assets($src, false)}
{/foreach}

