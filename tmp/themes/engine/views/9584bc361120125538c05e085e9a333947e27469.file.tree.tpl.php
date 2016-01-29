<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-29 11:00:55
         compiled from "/var/www/engine.loc/themes/engine/views/plugins/admins/groups/tree.tpl" */ ?>
<?php /*%%SmartyHeaderCode:160953070556a7892ccd57d3-89836705%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9584bc361120125538c05e085e9a333947e27469' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/plugins/admins/groups/tree.tpl',
      1 => 1454058055,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '160953070556a7892ccd57d3-89836705',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56a7892cce2759_00579906',
  'variables' => 
  array (
    'admins_groups_icon' => 0,
    't' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56a7892cce2759_00579906')) {function content_56a7892cce2759_00579906($_smarty_tpl) {?><div class="title">
    <i class="fa <?php echo $_smarty_tpl->tpl_vars['admins_groups_icon']->value;?>
"></i>
    <span><?php echo $_smarty_tpl->tpl_vars['t']->value['admins_group']['tree_title'];?>
</span>
    <button class="btn btn-link b-admins-group-create">Додати</button>
</div>
<div class="pages-tree" id="usersGroup"></div><?php }} ?>
