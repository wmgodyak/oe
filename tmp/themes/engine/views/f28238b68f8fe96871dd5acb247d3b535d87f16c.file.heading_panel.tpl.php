<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-04-19 18:37:07
         compiled from "/var/www/engine.loc/themes/engine/views/heading_panel.tpl" */ ?>
<?php /*%%SmartyHeaderCode:12336200085696130d0b6045-76198499%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f28238b68f8fe96871dd5acb247d3b535d87f16c' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/heading_panel.tpl',
      1 => 1461080227,
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
    'breadcrumb' => 0,
    'b' => 0,
    'k' => 0,
    'panel_nav' => 0,
    'item' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5696130d0c6565_03315811')) {function content_5696130d0c6565_03315811($_smarty_tpl) {?>
<!--heading-->
<div class="dashboard-heading">
    <div class="dashboard-title">
        
        <h1 class="breadcrumb">
            <a href="dashboard"><i class="fa fa-home"></i></a>
            <?php  $_smarty_tpl->tpl_vars['b'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['b']->_loop = false;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['breadcrumb']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['b']->key => $_smarty_tpl->tpl_vars['b']->value) {
$_smarty_tpl->tpl_vars['b']->_loop = true;
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['b']->key;
?>
                <?php if ($_smarty_tpl->tpl_vars['b']->value['url']) {?>
                   / <a href="<?php echo $_smarty_tpl->tpl_vars['b']->value['url'];?>
"><?php echo $_smarty_tpl->tpl_vars['b']->value['name'];?>
</a>
                <?php } else { ?>
                    <span class="item-<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
">/ <?php echo $_smarty_tpl->tpl_vars['b']->value['name'];?>
</span>
                <?php }?>
            <?php } ?>
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
