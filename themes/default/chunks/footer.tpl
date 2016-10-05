{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:55+02:00
 * @name footer
 *}

<!-- become scripts -->
<script src='{$theme_url}assets/js/vendor/jquery-1.11.3.min.js'></script>
<script src="{$theme_url}/assets/js/plugins.js"></script>
<script src='{$theme_url}/assets/js/vendor/jquery-ui.min.js'></script>
<script src='{$theme_url}/assets/js/vendor/notify.js'></script>
<script>
    var translations = {json_encode($t)};
</script>
<script src="{$theme_url}/assets/js/app.js"></script>
<!-- end scripts -->
{if isset($modules_scripts)}
    {foreach $modules_scripts as $k=>$script}
        <script src="{$script}"></script>
    {/foreach}
{/if}