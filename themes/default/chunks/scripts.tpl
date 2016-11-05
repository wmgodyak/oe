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