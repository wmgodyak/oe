<script src="{$theme_url}assets/js/jquery.min.js"></script>
<script src="{$theme_url}assets/js/custom.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="{$theme_url}assets/js/bootstrap.js"></script>

<script>
    var translations = {json_encode($t)};
</script>
<script src="{$theme_url}/assets/js/jquery-ui.min.js"></script>
<script src="{$theme_url}/assets/js/plugins.js"></script>
<script src="{$theme_url}/assets/js/app.js"></script>
<!-- end scripts -->
{if isset($modules_scripts)}
    {foreach $modules_scripts as $k=>$script}
        <script src="{$script}"></script>
    {/foreach}
{/if}