<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-15 15:17:19
         compiled from "/var/www/engine.loc/themes/engine/views/components/install_archive.tpl" */ ?>
<?php /*%%SmartyHeaderCode:3058959745697bf918a5727-37262416%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'fbbc8648c2a30844fd1f6df7ad89eb63acd28747' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/components/install_archive.tpl',
      1 => 1452863837,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '3058959745697bf918a5727-37262416',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5697bf918cc286_09442238',
  'variables' => 
  array (
    't' => 0,
    'tree' => 0,
    'item' => 0,
    'ctype' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5697bf918cc286_09442238')) {function content_5697bf918cc286_09442238($_smarty_tpl) {?><form action="./components/install" method="post" id="componentsInstall" class="form-horizontal" enctype="multipart/form-data">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['install_label_tree'];?>
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
</option>
                <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="type" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['type'];?>
</label>
        <div class="col-sm-9">
            <select name="data[type]" id="type" class="form-control">
                <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['ctype']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['item']->key;
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['item']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['item']->value;?>
</option>
                <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="file" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['label_file'];?>
</label>
        <div class="col-sm-9">
            <input name="file" id="data_file" class="form-control" type="file" required />
        </div>
    </div>
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="action" value="install">
</form><?php }} ?>
