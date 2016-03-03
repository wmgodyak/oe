<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-03 10:11:24
         compiled from "/var/www/engine.loc/themes/engine/views/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1202898852567be873c6fe20-51470877%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6b5a4c44995d054b1606a318076352efcc60d459' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/index.tpl',
      1 => 1456992634,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1202898852567be873c6fe20-51470877',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_567be873cb61d8_71422844',
  'variables' => 
  array (
    'base_url' => 0,
    'title' => 0,
    't' => 0,
    'theme_url' => 0,
    'controller' => 0,
    'action' => 0,
    'body' => 0,
    'nav' => 0,
    'plugins' => 0,
    'name' => 0,
    'admin' => 0,
    'heading_panel' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_567be873cb61d8_71422844')) {function content_567be873cb61d8_71422844($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><?php echo '<script'; ?>
 src="http://html5shiv.googlecode.com/svn/trunk/html5.js"><?php echo '</script'; ?>
><![endif]-->
    <title><?php echo $_smarty_tpl->tpl_vars['title']->value;?>
 :: <?php echo $_smarty_tpl->tpl_vars['t']->value['system']['name'];?>
</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/style.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/jquery-ui.min.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/jquery.dataTables.min.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/select2.min.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/my.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/style.css" rel="stylesheet">
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery-1.11.3.min.js"><?php echo '</script'; ?>
>
</head>

<body >
    <?php if ($_smarty_tpl->tpl_vars['controller']->value=='admin'&&$_smarty_tpl->tpl_vars['action']->value=='login') {?>
        <?php echo $_smarty_tpl->tpl_vars['body']->value;?>

    <?php } else { ?>
        <div class="dashboard">
            <?php echo $_smarty_tpl->tpl_vars['nav']->value;?>

            <div class="page">
                <?php if (!empty($_smarty_tpl->tpl_vars['plugins']->value['sidebar'])!='') {?>
                <div class="sidebar sidebar-open">
                    <div class="toggle-btn">
                        <i class="fa fa-chevron-left"></i>
                    </div>
                    <div class="sidebar-heading">
                        <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/img/logo/logo-black.png">
                    </div>
                    <?php echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['sidebar']);?>

                </div>
                <?php }?>
                <div class="dashboard-content <?php if (!empty($_smarty_tpl->tpl_vars['plugins']->value['sidebar'])) {?> sidebar-open<?php }?>">
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
                                    <li><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</li>
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
                                        <img class="admin-avatar" src="<?php echo $_smarty_tpl->tpl_vars['admin']->value['avatar'];?>
">
                                    </div>
                                </div>
                                <div class="table-cell">
                                    <div class="name">
                                        <span><?php echo $_smarty_tpl->tpl_vars['admin']->value['name'];?>
</span>
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
                        <?php echo $_smarty_tpl->tpl_vars['heading_panel']->value;?>

                        <div class="inline-notifications"></div>
                        <?php echo $_smarty_tpl->tpl_vars['body']->value;?>


                    </div> <!--end-->
                    <footer>
                        <div class="copyright">
                            <?php echo $_smarty_tpl->tpl_vars['t']->value['system']['copyright'];?>

                        </div>
                    </footer>
                </div>
            </div>
        </div>
    <?php }?>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/pace.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.cookie.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jstree.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.materialripple.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.dataTables.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery-ui.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.form.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.validate.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/bootstrap.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/select2.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery.maskedinput.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/lodash.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/charCount.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
>
    var TOKEN = '<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
', ONLINE = 0, t = <?php echo json_encode($_smarty_tpl->tpl_vars['t']->value);?>
, CONTROLLER = '<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
', ACTION = '<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
';

    jQuery.extend(jQuery.validator.messages, {
        required: "Це поле обов'язкове",
        remote: "Будь ласка, перевірте це поле",
        email: "Введіть коректну електронну скриньку"
    });
<?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 id="mainScript" src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/main.js"><?php echo '</script'; ?>
>
    
        
    
<?php echo '<script'; ?>
 id="componentScript" src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/bootstrap/<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
.js"><?php echo '</script'; ?>
>
</body>
</html><?php }} ?>
