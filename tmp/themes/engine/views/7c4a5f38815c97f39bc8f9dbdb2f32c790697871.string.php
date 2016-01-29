<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-16 12:55:59
         compiled from "7c4a5f38815c97f39bc8f9dbdb2f32c790697871" */ ?>
<?php /*%%SmartyHeaderCode:472820906569a21bfd0f3e0-56750253%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7c4a5f38815c97f39bc8f9dbdb2f32c790697871' => 
    array (
      0 => '7c4a5f38815c97f39bc8f9dbdb2f32c790697871',
      1 => 0,
      2 => 'string',
    ),
  ),
  'nocache_hash' => '472820906569a21bfd0f3e0-56750253',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'data' => 0,
    't' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_569a21bfd1fec0_01889140',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_569a21bfd1fec0_01889140')) {function content_569a21bfd1fec0_01889140($_smarty_tpl) {?>Вітаємо <?php echo $_smarty_tpl->tpl_vars['data']->value['name'];?>
. Вам надіслано доступи до системи <?php echo $_smarty_tpl->tpl_vars['t']->value['system']['name'];?>
.
Ваш лоігн: <?php echo $_smarty_tpl->tpl_vars['data']->value['email'];?>

Ваш пароль: <?php echo $_smarty_tpl->tpl_vars['data']->value['password'];?>

Отримати доступ ви можете за адресою: <?php echo $_smarty_tpl->tpl_vars['data']->value['url'];?>
<?php }} ?>
