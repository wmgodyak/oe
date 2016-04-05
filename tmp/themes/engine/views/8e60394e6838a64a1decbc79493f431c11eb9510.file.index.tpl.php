<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-18 17:25:08
         compiled from "/var/www/engine.loc/themes/engine/views/dashboard/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1856252900567cf13271bbf0-07807053%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8e60394e6838a64a1decbc79493f431c11eb9510' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/dashboard/index.tpl',
      1 => 1458314382,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1856252900567cf13271bbf0-07807053',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_567cf1327c2f58_58850710',
  'variables' => 
  array (
    'plugins' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_567cf1327c2f58_58850710')) {function content_567cf1327c2f58_58850710($_smarty_tpl) {?><h1>Dashboard</h1>
<?php if (isset($_smarty_tpl->tpl_vars['plugins']->value['dashboard'])) {
echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['dashboard']);
}?><?php }} ?>
