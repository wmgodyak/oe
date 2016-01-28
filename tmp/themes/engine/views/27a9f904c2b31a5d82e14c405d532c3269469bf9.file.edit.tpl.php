<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-14 16:58:33
         compiled from "/var/www/engine.loc/themes/engine/views/components/edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:7294469025697acb7a12b43-76893993%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '27a9f904c2b31a5d82e14c405d532c3269469bf9' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/components/edit.tpl',
      1 => 1452783511,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '7294469025697acb7a12b43-76893993',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5697acb7a42a80_37760822',
  'variables' => 
  array (
    'data' => 0,
    't' => 0,
    'tree' => 0,
    'item' => 0,
    'token' => 0,
    'components' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5697acb7a42a80_37760822')) {function content_5697acb7a42a80_37760822($_smarty_tpl) {?><form action="./components/process/<?php echo $_smarty_tpl->tpl_vars['data']->value['id'];?>
" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['install_label_tree'];?>
</label>
        <div class="col-sm-9">
            <select class="form-control" name="data[parent_id]" id="data_parent_id">
                <option value="0" selected><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['install_label_tree_home'];?>
</option>
                <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['tree']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
                    <option <?php if ($_smarty_tpl->tpl_vars['data']->value['id']==$_smarty_tpl->tpl_vars['item']->value['id']) {?>disabled<?php }?> <?php if ($_smarty_tpl->tpl_vars['data']->value['parent_id']==$_smarty_tpl->tpl_vars['item']->value['id']) {?>selected<?php }?>  value="<?php echo $_smarty_tpl->tpl_vars['item']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['t']->value[$_smarty_tpl->tpl_vars['item']->value['controller']]['action_index'];?>
</option>
                <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="icon" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['icon'];?>
</label>
        <div class="col-sm-9">
            <input name="data[icon]" id="icon"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['icon'];?>
" required>
        </div>
    </div>
    <div class="form-group">
        <label for="position" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['position'];?>
</label>
        <div class="col-sm-9">
            <input name="data[position]" id="position"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['position'];?>
" required>
        </div>
    </div>
    <div class="form-group">
        <label for="published" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['common']['published'];?>
</label>
        <div class="col-sm-9">
            <input name="data[published]" id="published"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['published'];?>
" required>
        </div>
    </div>
    <div class="form-group">
        <label for="rang" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['components']['rang'];?>
</label>
        <div class="col-sm-9">
            <input name="data[rang]" id="rang"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['rang'];?>
" required>
        </div>
    </div>
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="c" value="<?php echo $_smarty_tpl->tpl_vars['components']->value;?>
">
</form><?php }} ?>
