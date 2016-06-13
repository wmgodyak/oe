<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-06-13 15:27:20
         compiled from "/var/www/engine.loc/themes/engine/views/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1973450862575ea6a893b416-98506933%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '6b5a4c44995d054b1606a318076352efcc60d459' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/index.tpl',
      1 => 1465736680,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1973450862575ea6a893b416-98506933',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'controller' => 0,
    'action' => 0,
    'base_url' => 0,
    'title' => 0,
    't' => 0,
    'theme_url' => 0,
    'version' => 0,
    'body' => 0,
    'nav' => 0,
    'plugins' => 0,
    'sidebar' => 0,
    'heading_panel' => 0,
    'token' => 0,
    'components_scripts' => 0,
    'src' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_575ea6a89ccfe0_57139980',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575ea6a89ccfe0_57139980')) {function content_575ea6a89ccfe0_57139980($_smarty_tpl) {?><!DOCTYPE html>
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
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/style.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/vendor/bootstrap.min.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/css/style.css?v=<?php echo $_smarty_tpl->tpl_vars['version']->value;?>
" rel="stylesheet">
    <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/js/vendor/jquery-1.11.3.min.js"><?php echo '</script'; ?>
>
</head>

<body class="ct-<?php echo $_smarty_tpl->tpl_vars['controller']->value;?>
 ac-<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
">
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
                <div class="dashboard-content <?php if (!empty($_smarty_tpl->tpl_vars['plugins']->value['sidebar'])||isset($_smarty_tpl->tpl_vars['sidebar']->value)) {?> sidebar-open<?php }?>">
                    <div class="content-wrapper"> <!--dashboard-->
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
assets/js/common.js?v=<?php echo $_smarty_tpl->tpl_vars['version']->value;?>
"><?php echo '</script'; ?>
>
<?php if ($_smarty_tpl->tpl_vars['components_scripts']->value) {?>
    <?php  $_smarty_tpl->tpl_vars['src'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['src']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['components_scripts']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['src']->key => $_smarty_tpl->tpl_vars['src']->value) {
$_smarty_tpl->tpl_vars['src']->_loop = true;
?>
        <?php echo '<script'; ?>
 src="<?php echo $_smarty_tpl->tpl_vars['src']->value;?>
"><?php echo '</script'; ?>
>
    <?php } ?>
<?php }?>
</body>
</html><?php }} ?>
