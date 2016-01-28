<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-28 15:09:37
         compiled from "/var/www/engine.loc/themes/engine/views/components/install_plugin.tpl" */ ?>
<?php /*%%SmartyHeaderCode:116156332456aa13110eddf2-66282232%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c78d18362443e67b2117ac9c9be2d545c3807095' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/components/install_plugin.tpl',
      1 => 1453985356,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '116156332456aa13110eddf2-66282232',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    't' => 0,
    'tree' => 0,
    'item' => 0,
    'token' => 0,
    'component' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56aa131110f4f7_88310151',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56aa131110f4f7_88310151')) {function content_56aa131110f4f7_88310151($_smarty_tpl) {?><form action="./plugins/install" method="post" id="pluginsInstall">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['plugins']['install_label_tree'];?>
</label>
        <div class="col-sm-9">
            <select name="data[parent_id]" id="data_parent_id" class="form-control">
                <option value="0"><?php echo $_smarty_tpl->tpl_vars['t']->value['plugins']['install_label_tree_home'];?>
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
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="c" value="<?php echo $_smarty_tpl->tpl_vars['component']->value;?>
">
    <input type="hidden" name="action" value="install">
</form><?php }} ?>
