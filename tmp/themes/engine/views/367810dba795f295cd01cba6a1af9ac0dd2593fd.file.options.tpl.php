<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-27 16:39:25
         compiled from "/var/www/engine.loc/themes/engine/views/plugins/admins/groups/options.tpl" */ ?>
<?php /*%%SmartyHeaderCode:145548444956a8c90e34c681-41156910%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '367810dba795f295cd01cba6a1af9ac0dd2593fd' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/plugins/admins/groups/options.tpl',
      1 => 1453905561,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '145548444956a8c90e34c681-41156910',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56a8c90e35aa28_89939628',
  'variables' => 
  array (
    'items' => 0,
    'disabled' => 0,
    'data' => 0,
    'item' => 0,
    'i' => 0,
    'level' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56a8c90e35aa28_89939628')) {function content_56a8c90e35aa28_89939628($_smarty_tpl) {?><?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['items']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
    <option <?php if ($_smarty_tpl->tpl_vars['disabled']->value) {?>disabled<?php }?> <?php if ($_smarty_tpl->tpl_vars['data']->value['parent_id']==$_smarty_tpl->tpl_vars['item']->value['id']) {?>selected<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['item']->value['id'];?>
"><?php  $_smarty_tpl->tpl_vars['i'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['i']->value = 0;
  if ($_smarty_tpl->tpl_vars['i']->value<$_smarty_tpl->tpl_vars['level']->value) { for ($_foo=true;$_smarty_tpl->tpl_vars['i']->value<$_smarty_tpl->tpl_vars['level']->value; $_smarty_tpl->tpl_vars['i']->value++) {
?>. <?php }} ?> <?php echo $_smarty_tpl->tpl_vars['item']->value['name'];?>
</option>
    <?php if ($_smarty_tpl->tpl_vars['item']->value['isfolder']) {?>
        <?php echo $_smarty_tpl->getSubTemplate ("plugins/admins/groups/options.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array('items'=>$_smarty_tpl->tpl_vars['item']->value['items'],'level'=>$_smarty_tpl->tpl_vars['level']->value+1), 0);?>

    <?php }?>
<?php } ?><?php }} ?>
