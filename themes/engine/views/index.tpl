<!DOCTYPE html>
<html>
<head>
    <base href="{$base_url}">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <title>{$t.core.sys_name}</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href="{$template_url}assets/css/vendor/style.css" rel="stylesheet">
    <link href="{$template_url}assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="{$template_url}assets/css/vendor/jquery-ui.min.css" rel="stylesheet">
    <link href="{$template_url}assets/css/vendor/jquery.dataTables.min.css" rel="stylesheet">
    <link href="{$template_url}assets/css/style.css" rel="stylesheet">
</head>

<body {*class="{$controller} {$action}"*}>
    {if $controller == 'Admin' && $action == 'login'}
        {$body}
    {else}
        <div class="dashboard">
            {$structure}
            <div class="page">
                {if $sidebar != ''}
                <div class="sidebar sidebar-open">
                    <div class="toggle-btn">
                        <i class="fa fa-chevron-left"></i>
                    </div>
                    <div class="sidebar-heading">
                        <img src="{$template_url}assets/img/logo/logo-black.png">
                    </div>
                    <div class="title">
                        <i class="fa fa-file-o"></i>
                        <span>Сторінки</span>
                    </div>
                    <div class="pages-tree" id="tree">
                        <ul>
                            <li>
                                <a href="#">GasInfoService #1</a>
                                <ul>
                                    <li>
                                        <a href="#">Новини #10</a>
                                        <ul>
                                            <li><a href="#">Реалізація #7</a></li>
                                            <li><a href="#">Підприємства, які працюють</a></li>
                                            <li><a href="#">БМР #75</a></li>
                                            <li><a href="#">Оптова реалізація конденсту</a></li>
                                            <li>
                                                <a href="#">Оптова реалізація</a>
                                                <ul>
                                                    <li><a href="#">Реалізація #7</a></li>
                                                    <li><a href="#">Підприємства</a></li>
                                                    <li><a href="#">БМР #75</a></li>
                                                    <li><a href="#">Оптова </a></li>
                                                    <li><a href="#">Оптова реалізація</a></li>
                                                    <li><a href="#">Трейдери з продажу</a></li>
                                                    <li><a href="#">Роздрібна реалізація</a></li>
                                                    <li><a href="#">АГНКС #80</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Трейдери з продажу газу #78</a></li>
                                            <li><a href="#">Роздрібна реалізація вуглево</a></li>
                                            <li><a href="#">АГНКС #80</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Підприємства, які працюють</a></li>
                                    <li><a href="#">БМР #75</a></li>
                                    <li><a href="#">Оптова реалізація конденсту</a></li>
                                    <li>
                                        <a href="#">Новини #10</a>
                                        <ul>
                                            <li><a href="#">Реалізація #7</a></li>
                                            <li><a href="#">Підприємства, які працюють</a></li>
                                            <li><a href="#">БМР #75</a></li>
                                            <li><a href="#">Оптова реалізація конденсту</a></li>
                                            <li>
                                                <a href="#">Оптова реалізація</a>
                                                <ul>
                                                    <li><a href="#">Реалізація #7</a></li>
                                                    <li><a href="#">Підприємства</a></li>
                                                    <li><a href="#">БМР #75</a></li>
                                                    <li><a href="#">Оптова </a></li>
                                                    <li><a href="#">Оптова реалізація</a></li>
                                                    <li><a href="#">Трейдери з продажу</a></li>
                                                    <li><a href="#">Роздрібна реалізація</a></li>
                                                    <li><a href="#">АГНКС #80</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="#">Трейдери з продажу газу #78</a></li>
                                            <li><a href="#">Роздрібна реалізація вуглево</a></li>
                                            <li><a href="#">АГНКС #80</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                {/if}
                <div class="dashboard-content {if $sidebar != ''} sidebar-open{/if}">
                    <div class="content-wrapper"> <!--dashboard-->
                        <!--top line-->
                        <div class="top-line">
                            <div class="breadcrumb">
                                <ul>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-home"></i>
                                        </a>
                                    </li>
                                    <li>Сторінки</li>
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
                                        <img src="{$template_url}assets/img/1.png">
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
                                                    <a href="admin/profile">
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

                        <!--heading-->
                        <div class="dashboard-heading">
                            <div class="dashboard-title">
                                <i class="fa fa-file-o"></i>
                                <h1>Сторінки</h1>
                            </div>
                            <div class="btn-group">
                                <button type="button" class="btn btn-md btn-info" disabled="disabled">Створити</button>
                            </div>

                        </div>
                        <!--end-->

                        {$body}

                    </div> <!--end-->
                    <footer>
                        <div class="copyright">
                            {$t.core.copyright}
                        </div>
                    </footer>
                </div>
            </div>
        </div>
    {/if}
<script src="{$template_url}assets/js/vendor/jquery-1.11.3.min.js"></script>
<script src="{$template_url}assets/js/vendor/pace.js"></script>
<script src="{$template_url}assets/js/vendor/jstree.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.materialripple.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.dataTables.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery-ui.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.form.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.validate.min.js"></script>

<script>
    var TOKEN = '{$token}', ONLINE = 0;

    jQuery.extend(jQuery.validator.messages, {
        required: "Це поле обов'язкове",
        remote: "Будь ласка, перевірте це поле",
        email: "Введіть коректну електронну скриньку"
    });
</script>
<script src="{$template_url}assets/js/main.js"></script>
</body>
</html>