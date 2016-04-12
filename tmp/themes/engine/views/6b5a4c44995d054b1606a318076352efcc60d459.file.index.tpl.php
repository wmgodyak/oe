<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-04-12 18:44:20
         compiled from "/var/www/engine.loc/themes/engine/views/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1202898852567be873c6fe20-51470877%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6b5a4c44995d054b1606a318076352efcc60d459' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/index.tpl',
      1 => 1460474373,
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
    'controller' => 0,
    'action' => 0,
    'base_url' => 0,
    'title' => 0,
    't' => 0,
    'theme_url' => 0,
    'body' => 0,
    'nav' => 0,
    'plugins' => 0,
    'sidebar' => 0,
    'name' => 0,
    'admin' => 0,
    'heading_panel' => 0,
    'token' => 0,
    'component_script' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_567be873cb61d8_71422844')) {function content_567be873cb61d8_71422844($_smarty_tpl) {?><!DOCTYPE html>
<html data-controller="<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
" data-action="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
">
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
                <?php if (!empty($_smarty_tpl->tpl_vars['plugins']->value['sidebar'])!=''||isset($_smarty_tpl->tpl_vars['sidebar']->value)) {?>
                <div class="sidebar sidebar-open">
                    <div class="toggle-btn">
                        <i class="fa fa-chevron-left"></i>
                    </div>
                    <div class="sidebar-heading">
                        <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/img/logo/logo-black.png">
                    </div>
                    <?php if (isset($_smarty_tpl->tpl_vars['plugins']->value['sidebar'])) {
echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['sidebar']);
}?>
                    <?php if (isset($_smarty_tpl->tpl_vars['sidebar']->value)) {
echo $_smarty_tpl->tpl_vars['sidebar']->value;
}?>
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
                                                        <span><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['messages'];?>
</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/profile" onclick="return false;" class="b-admin-profile">
                                                        <i class="fa fa-sliders"></i>
                                                        <span><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['profile'];?>
</span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="admin/logout">
                                                        <i class="fa fa-power-off"></i>
                                                        <span><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['logout'];?>
</span>
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
                        <?php if ($_smarty_tpl->tpl_vars['action']->value=='index'&&isset($_smarty_tpl->tpl_vars['plugins']->value['top'])) {
echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['top']);
}?>
                        <?php echo $_smarty_tpl->tpl_vars['body']->value;?>

                        <?php if ($_smarty_tpl->tpl_vars['action']->value=='index'&&isset($_smarty_tpl->tpl_vars['plugins']->value['bottom'])) {
echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['bottom']);
}?>
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
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/dropzone.min.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 src="/vendor/ckeditor/ckeditor.js"><?php echo '</script'; ?>
>
<?php echo '<script'; ?>
>
    var TOKEN = '<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
', ONLINE = 0, t = <?php echo json_encode($_smarty_tpl->tpl_vars['t']->value);?>
, CONTROLLER = '<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
', ACTION = '<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
';

    jQuery.extend(jQuery.validator.messages, {
        required: "<?php echo $_smarty_tpl->tpl_vars['t']->value['common']['e_required'];?>
",
        remote: "<?php echo $_smarty_tpl->tpl_vars['t']->value['common']['e_check'];?>
",
        email: "<?php echo $_smarty_tpl->tpl_vars['t']->value['common']['e_email'];?>
"
    });
<?php echo '</script'; ?>
>
<?php echo '<script'; ?>
 id="mainScript" src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/main.js"><?php echo '</script'; ?>
>
<?php if ($_smarty_tpl->tpl_vars['component_script']->value) {?>
    <?php echo '<script'; ?>
 id="componentScript" src="<?php echo $_smarty_tpl->tpl_vars['component_script']->value;?>
"><?php echo '</script'; ?>
>
<?php }?>
</body>
</html><?php }} ?>
