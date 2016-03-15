<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-09 22:01:06
         compiled from "/var/www/engine.loc/themes/engine/views/heading_panel.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12336200085696130d0b6045-76198499%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f28238b68f8fe96871dd5acb247d3b535d87f16c' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/heading_panel.tpl',
      1 => 1457553216,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '12336200085696130d0b6045-76198499',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5696130d0c6565_03315811',
  'variables' => 
  array (
    'name' => 0,
    'panel_nav' => 0,
    'item' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5696130d0c6565_03315811')) {function content_5696130d0c6565_03315811($_smarty_tpl) {?><!--heading-->
<div class="dashboard-heading">
    <div class="dashboard-title">
        <i class="fa fa-file-o"></i>
        <h1><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</h1>
    </div>
    <?php if (!empty($_smarty_tpl->tpl_vars['panel_nav']->value)) {?>
        <div class="btn-group">
            <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['panel_nav']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['item']->key;
?>
                <?php echo $_smarty_tpl->tpl_vars['item']->value;?>

            <?php } ?>
        </div>
    <?php }?>
</div>
<!--end--><?php }} ?>
