<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-06-13 18:31:31
         compiled from "/var/www/engine.loc/themes/engine/views/dashboard/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:158781640575ed1d350e0b4-62696436%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
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
  'nocache_hash' => '158781640575ed1d350e0b4-62696436',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'plugins' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_575ed1d35222e8_40063928',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575ed1d35222e8_40063928')) {function content_575ed1d35222e8_40063928($_smarty_tpl) {?><h1>Dashboard</h1>
<?php if (isset($_smarty_tpl->tpl_vars['plugins']->value['dashboard'])) {
echo implode("\r\n",$_smarty_tpl->tpl_vars['plugins']->value['dashboard']);
}?><?php }} ?>
