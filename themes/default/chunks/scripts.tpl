
{assets('js/jquery.min.js')}
{assets('bootstrap/js/bootstrap.min.js')}
{*{assets('js/jquery-ui.min.js')}*}
{assets('js/plugins.js')}
{assets('js/app.js')}
{foreach $modules_scripts as $k=>$src}
{assets($src, false)}
{/foreach}