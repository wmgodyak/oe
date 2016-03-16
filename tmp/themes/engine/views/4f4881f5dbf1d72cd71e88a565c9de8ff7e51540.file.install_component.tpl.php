<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-16 17:18:23
         compiled from "/var/www/engine.loc/themes/engine/views/components/install_component.tpl" */ ?>
<?php /*%%SmartyHeaderCode:150950108956978bb10860e7-24022422%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4f4881f5dbf1d72cd71e88a565c9de8ff7e51540' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/components/install_component.tpl',
      1 => 1458141501,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '150950108956978bb10860e7-24022422',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56978bb1092626_87626930',
  'variables' => 
  array (
    't' => 0,
    'tree' => 0,
    'item' => 0,
    'token' => 0,
    'component' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56978bb1092626_87626930')) {function content_56978bb1092626_87626930($_smarty_tpl) {?><form action="./components/install" method="post" id="componentsInstall">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['install_label_tree'];?>
</label>
        <div class="col-sm-9">
            <select name="data[parent_id]" id="data_parent_id" class="form-control">
                <option value="0"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['install_label_tree_home'];?>
</option>
                <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tree']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['item']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['t']->value[$_smarty_tpl->tpl_vars['item']->value['controller']]['action_index'];?>
 (<?php echo $_smarty_tpl->tpl_vars['item']->value['controller'];?>
)</option>
                <?php } ?>
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="c" value="<?php echo $_smarty_tpl->tpl_vars['component']->value;?>
">
    <input type="hidden" name="action" value="install">
</form><?php }} ?>
