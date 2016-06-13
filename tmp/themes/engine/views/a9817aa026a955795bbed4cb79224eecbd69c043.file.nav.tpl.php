<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-06-13 15:29:00
         compiled from "/var/www/engine.loc/themes/engine/views/nav.tpl" */ ?>
<?php /*%%SmartyHeaderCode:681911729575ea6a88dcc14-98449532%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a9817aa026a955795bbed4cb79224eecbd69c043' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/nav.tpl',
      1 => 1465820939,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '681911729575ea6a88dcc14-98449532',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_575ea6a890d9d6_87149308',
  'variables' => 
  array (
    'nav_items' => 0,
    'item' => 0,
    'subitem' => 0,
    't' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_575ea6a890d9d6_87149308')) {function content_575ea6a890d9d6_87149308($_smarty_tpl) {?><!--side navigation-->
<div class="main-navigation">
    <nav class="side-nav">
        <ul class="first-level">
            
            <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['nav_items']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
            <li <?php if ($_smarty_tpl->tpl_vars['item']->value['isfolder']) {?>class="has-child"<?php }?>>
                <a href="./<?php echo $_smarty_tpl->tpl_vars['item']->value['controller'];?>
" <?php if ($_smarty_tpl->tpl_vars['item']->value['isfolder']) {?>onclick="return false;" <?php }?>>
                    <?php if ($_smarty_tpl->tpl_vars['item']->value['isfolder']) {?><div class="toggle-child"><i class="fa fa-plus"></i></div><?php }?>
                    <i class="fa <?php echo $_smarty_tpl->tpl_vars['item']->value['icon'];?>
"></i>
                    <span><?php echo $_smarty_tpl->tpl_vars['item']->value['name'];?>
</span>
                </a>
                <?php if (isset($_smarty_tpl->tpl_vars['item']->value['items'])) {?>
                <ul class="second-level">
                    <?php  $_smarty_tpl->tpl_vars['subitem'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['subitem']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['item']->value['items']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['subitem']->key => $_smarty_tpl->tpl_vars['subitem']->value) {
$_smarty_tpl->tpl_vars['subitem']->_loop = true;
?>
                        <li><a href="./<?php echo $_smarty_tpl->tpl_vars['subitem']->value['controller'];?>
"><?php echo $_smarty_tpl->tpl_vars['subitem']->value['name'];?>
</a></li>
                    <?php } ?>
                </ul>
                <?php }?>
            </li>
            <?php } ?>
            <li class="exit">
                <a href="admin/logout">
                    <i class="fa fa-power-off"></i>
                    <span><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['logout'];?>
</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<!--end--><?php }} ?>
