{assets('js/jquery-1.11.1.min.js')}

{assets('js/bootstrap.min.js')}

{assets('js/bootstrap-hover-dropdown.min.js')}
{assets('js/owl.carousel.min.js')}

{assets('js/echo.min.js')}
{assets('js/jquery.easing-1.3.min.js')}
{assets('js/bootstrap-slider.min.js')}
{assets('js/jquery.rateit.min.js')}
{assets('js/lightbox.min.js')}
{assets('js/bootstrap-select.min.js')}
{assets('js/wow.min.js')}

{*{assets('js/plugins.js')}*}
{assets('js/app.js')}
{foreach $modules_scripts as $k=>$src}
    {assets($src, false)}
{/foreach}
{assets('js/scripts.js')}

