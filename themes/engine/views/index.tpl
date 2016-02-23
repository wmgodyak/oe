<!DOCTYPE html>
<html>
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
                    {implode("\r\n", $plugins.sidebar)}
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
                                                        <span>Повідомлення</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/profile" onclick="return false;" class="b-admin-profile">
                                                        <i class="fa fa-sliders"></i>
                                                        <span>Налаштування</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/logout">
                                                        <i class="fa fa-power-off"></i>
                                                        <span>Вихід</span>
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
                        {$body}

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
<script src="{$theme_url}assets/js/vendor/lodash.core.min.js"></script>
<script>
    var TOKEN = '{$token}', ONLINE = 0, t = {json_encode($t)};

    jQuery.extend(jQuery.validator.messages, {
        required: "Це поле обов'язкове",
        remote: "Будь ласка, перевірте це поле",
        email: "Введіть коректну електронну скриньку"
    });
</script>
<script src="{$theme_url}assets/js/main.js"></script>
    {foreach $required_components as $c}
        <script src="{$c}"></script>
    {/foreach}
<script src="{$theme_url}assets/js/bootstrap/{$controller}.js"></script>
</body>
</html>