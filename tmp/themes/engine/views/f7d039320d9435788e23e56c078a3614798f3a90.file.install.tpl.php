<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-28 16:18:30
         compiled from "/var/www/engine.loc/themes/engine/views/plugins/install.tpl" */ ?>
<?php /*%%SmartyHeaderCode:106998018356aa14902edb16-39845159%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f7d039320d9435788e23e56c078a3614798f3a90' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/plugins/install.tpl',
      1 => 1453990707,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '106998018356aa14902edb16-39845159',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56aa1490309a57_12303744',
  'variables' => 
  array (
    't' => 0,
    'components' => 0,
    'c' => 0,
    'data' => 0,
    'token' => 0,
    'plugin' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56aa1490309a57_12303744')) {function content_56aa1490309a57_12303744($_smarty_tpl) {?><form action="./plugins/install" method="post" id="pluginsInstall" class="form-horizontal">
    <div class="form-group">
        <label for="components" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['plugins']['install_label_components'];?>
</label>
        <div class="col-sm-9">
            <select name="components[]" id="components" multiple required class="form-control">
                <?php  $_smarty_tpl->tpl_vars['c'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['c']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['components']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['c']->key => $_smarty_tpl->tpl_vars['c']->value) {
$_smarty_tpl->tpl_vars['c']->_loop = true;
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['c']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['c']->value['name'];?>
</option>
                <?php } ?>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['plugins']['install_label_place'];?>
</label>
        <div class="col-sm-9">
            <input type="text" name="data[place]" required value="<?php echo $_smarty_tpl->tpl_vars['data']->value['place'];?>
" class="form-control" placeholder="<?php echo $_smarty_tpl->tpl_vars['t']->value['plugins']['install_label_place_ph'];?>
">
        </div>
    </div>
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="c" value="<?php echo $_smarty_tpl->tpl_vars['plugin']->value;?>
">
    <input type="hidden" name="action" value="install">
</form><?php }} ?>
