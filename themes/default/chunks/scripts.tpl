
{assets('js/jquery-1.12.3.min.js')}
{assets('js/bootstrap.min.js')}
{assets('vendors/modernizr/modernizr-2.6.2.min.js')}
{assets('vendors/owl-carousel/owl.carousel.min.js')}
{assets('vendors/flexslider/jquery.flexslider-min.js')}
{assets('vendors/countdown/jquery.countdown.js')}
{assets('js/plugins.js')}
{assets('js/app.js')}
{foreach $modules_scripts as $k=>$src}
    {assets($src, false)}
{/foreach}
{assets('js/main.js')}