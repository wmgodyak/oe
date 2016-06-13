<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-06-13 15:27:20
         compiled from "/var/www/engine.loc/themes/engine/views/heading_panel.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1204829671575ea6a891abe1-65447169%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f28238b68f8fe96871dd5acb247d3b535d87f16c' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/heading_panel.tpl',
      1 => 1465820788,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1204829671575ea6a891abe1-65447169',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'breadcrumb' => 0,
    'b' => 0,
    'k' => 0,
    'panel_nav' => 0,
    'item' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_575ea6a8938456_32638004',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575ea6a8938456_32638004')) {function content_575ea6a8938456_32638004($_smarty_tpl) {?><!--heading-->

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
 current">/ <?php echo $_smarty_tpl->tpl_vars['b']->value['name'];?>
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
