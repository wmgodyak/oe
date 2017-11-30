<script src="{$theme_url}assets/js/vendor/pace.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.cookie.js"></script>
<script src="{$theme_url}assets/js/vendor/jstree.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.materialripple.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.dataTables.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery-ui.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.form.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.validate.min.js"></script>
<script src="{$theme_url}assets/js/vendor/bootstrap.min.js"></script>
<script src="{$theme_url}assets/js/vendor/bootstrap-tagsinput.min.js"></script>
<script src="{$theme_url}assets/js/vendor/select2.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.maskedinput.min.js"></script>
<script src="{$theme_url}assets/js/vendor/lodash.min.js"></script>
<script src="{$theme_url}assets/js/vendor/charCount.js"></script>
<script src="{$theme_url}assets/js/vendor/dropzone.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.nestable.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.mCustomScrollbar.js"></script>
<script src="{$theme_url}assets/js/vendor/notify.min.js"></script>
<script src="/vendor/ckeditor/ckeditor.js"></script>
<script src="editor/config"></script>
<script>
    var TOKEN = '{$token}', ONLINE = 0, t = {json_encode($t)}, CONTROLLER = '{$controller}', ACTION = '{$action}';

    jQuery.extend(jQuery.validator.messages, {
        required: "{$t.common.e_required}",
        remote: "{$t.common.e_check}",
        email: "{$t.common.e_email}"
    });
</script>
<script id="mainScript" src="{$theme_url}assets/js/common.js?v={$version}"></script>
{if $custom_scripts}
    {foreach $custom_scripts as $src}
        <script src="/{$src}"></script>
    {/foreach}
{/if}