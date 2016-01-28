<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-16 09:20:49
         compiled from "/var/www/engine.loc/themes/engine/views/nav.tpl" */ ?>
<?php /*%%SmartyHeaderCode:13410207155694b4d83e02a2-92245890%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a9817aa026a955795bbed4cb79224eecbd69c043' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/nav.tpl',
      1 => 1452928847,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '13410207155694b4d83e02a2-92245890',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5694b4d848d819_82520054',
  'variables' => 
  array (
    't' => 0,
    'nav_items' => 0,
    'item' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5694b4d848d819_82520054')) {function content_5694b4d848d819_82520054($_smarty_tpl) {?><!--side navigation-->
<div class="main-navigation">
    <nav class="side-nav">
        <ul class="first-level">
            <li class="active">
                <a href="./dashboard">
                    <i class="fa fa-home"></i>
                    <span><?php echo $_smarty_tpl->tpl_vars['t']->value['system']['name'];?>
</span>
                </a>
            </li>
            <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['nav_items']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
            <li>
                <a href="./<?php echo $_smarty_tpl->tpl_vars['item']->value['controller'];?>
">
                    <i class="fa <?php echo $_smarty_tpl->tpl_vars['item']->value['icon'];?>
"></i>
                    <span><?php echo $_smarty_tpl->tpl_vars['t']->value[$_smarty_tpl->tpl_vars['item']->value['controller']]['action_index'];?>
</span>
                </a>
            </li>
            <?php } ?>
            
            <li class="exit">
                <a href="admin/logout">
                    <i class="fa fa-power-off"></i>
                    <span>Вихід</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<!--end--><?php }} ?>
