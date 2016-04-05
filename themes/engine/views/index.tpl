<!DOCTYPE html>
<html data-controller="{$controller}" data-action="{$action}">
<head>
    <base href="{$base_url}">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <title>{$title} :: {$t.system.name}</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    {*<link rel="stylesheet" href="{$theme_url}assets/css/vendor/font-awesome.min.css">*}
    <link href="{$theme_url}assets/css/vendor/style.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery-ui.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/jquery.dataTables.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/vendor/select2.min.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/my.css" rel="stylesheet">
    <link href="{$theme_url}assets/css/style.css" rel="stylesheet">
    <script src="{$theme_url}assets/js/vendor/jquery-1.11.3.min.js"></script>
</head>

<body {*class="{$controller} {$action}"*}>
    {if $controller == 'admin' && $action == 'login'}
        {$body}
    {else}
        <div class="dashboard">
            {$nav}
            <div class="page">
                {if !empty($plugins.sidebar) != ''}
                <div class="sidebar sidebar-open">
                    <div class="toggle-btn">
                        <i class="fa fa-chevron-left"></i>
                    </div>
                    <div class="sidebar-heading">
                        <img src="{$theme_url}assets/img/logo/logo-black.png">
                    </div>
                    {if isset($plugins.sidebar)}{implode("\r\n", $plugins.sidebar)}{/if}
                </div>
                {/if}
                <div class="dashboard-content {if !empty($plugins.sidebar)} sidebar-open{/if}">
                    <div class="content-wrapper"> <!--dashboard-->
                        <!--top line-->
                        <div class="top-line">
                            <div class="breadcrumb">
                                <ul>
                                    <li>
                                        <a href="./dashboard">
                                            <i class="fa fa-home"></i>
                                        </a>
                                    </li>
                                    <li>{$name}</li>
                                </ul>
                            </div>
                            <div class="user-panel">
                                <div class="table-cell">
                                    <div class="message">
                                        <i class="fa fa-comments-o"></i>
                                        <span>3</span>
                                    </div>
                                </div>
                                <div class="table-cell">
                                    <div class="avatar">
                                        <img class="admin-avatar" src="{$admin.avatar}">
                                    </div>
                                </div>
                                <div class="table-cell">
                                    <div class="name">
                                        <span>{$admin.name}</span>
                                        <div class="user-dropdown">
                                            <ul>
                                                <li>
                                                    <a href="#">
                                                        <i class="fa fa-envelope-o"></i>
                                                        <span>{$t.admin.messages}</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/profile" onclick="return false;" class="b-admin-profile">
                                                        <i class="fa fa-sliders"></i>
                                                        <span>{$t.admin.profile}</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/logout">
                                                        <i class="fa fa-power-off"></i>
                                                        <span>{$t.admin.logout}</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--end-->
                        {$heading_panel}
                        <div class="inline-notifications"></div>
                        {if $action == 'index' && isset($plugins.top)}{implode("\r\n", $plugins.top)}{/if}
                        {$body}
                        {if $action == 'index' && isset($plugins.bottom)}{implode("\r\n", $plugins.bottom)}{/if}
                    </div> <!--end-->
                    <footer>
                        <div class="copyright">
                            {$t.system.copyright}
                        </div>
                    </footer>
                </div>
            </div>
        </div>
    {/if}
<script src="{$theme_url}assets/js/vendor/pace.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.cookie.js"></script>
<script src="{$theme_url}assets/js/vendor/jstree.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.materialripple.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.dataTables.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery-ui.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.form.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.validate.min.js"></script>
<script src="{$theme_url}assets/js/vendor/bootstrap.min.js"></script>
<script src="{$theme_url}assets/js/vendor/select2.min.js"></script>
<script src="{$theme_url}assets/js/vendor/jquery.maskedinput.min.js"></script>
<script src="{$theme_url}assets/js/vendor/lodash.min.js"></script>
<script src="{$theme_url}assets/js/vendor/charCount.js"></script>
<script src="{$theme_url}assets/js/vendor/dropzone.min.js"></script>
<script src="/vendor/ckeditor/ckeditor.js"></script>
<script>
    var TOKEN = '{$token}', ONLINE = 0, t = {json_encode($t)}, CONTROLLER = '{$controller}', ACTION = '{$action}';

    jQuery.extend(jQuery.validator.messages, {
        required: "{$t.common.e_required}",
        remote: "{$t.common.e_check}",
        email: "{$t.common.e_email}"
    });
</script>
<script id="mainScript" src="{$theme_url}assets/js/main.js"></script>
{if $component_script }
    <script id="componentScript" src="{$component_script}"></script>
{/if}
</body>
</html>