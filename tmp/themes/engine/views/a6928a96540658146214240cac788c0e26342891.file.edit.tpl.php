<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-15 17:10:35
         compiled from "/var/www/engine.loc/themes/engine/views/languages/edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:194812704556990333a8bb38-78971679%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a6928a96540658146214240cac788c0e26342891' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/languages/edit.tpl',
      1 => 1452870633,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '194812704556990333a8bb38-78971679',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56990333ab5864_46870590',
  'variables' => 
  array (
    'data' => 0,
    't' => 0,
    'token' => 0,
    'action' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56990333ab5864_46870590')) {function content_56990333ab5864_46870590($_smarty_tpl) {?><form action="./languages/process/<?php echo $_smarty_tpl->tpl_vars['data']->value['id'];?>
" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['languages']['name'];?>
</label>
        <div class="col-sm-9">
            <input name="data[name]" id="name"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['name'];?>
" required placeholder="<?php echo $_smarty_tpl->tpl_vars['t']->value['languages']['placeholder_name'];?>
">
        </div>
    </div>
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['languages']['code'];?>
</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['code'];?>
" required placeholder="<?php echo $_smarty_tpl->tpl_vars['t']->value['languages']['placeholder_code'];?>
">
        </div>
    </div>
    <div class="form-group">
        <label for="is_main" class="col-sm-3 control-label"></label>
        <div class="col-sm-9">

            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[is_main]" value="0">
                    <input <?php if ($_smarty_tpl->tpl_vars['data']->value['is_main']==1) {?>checked<?php }?> type="checkbox" name="data[is_main]" id="is_main" value="1"> <?php echo $_smarty_tpl->tpl_vars['t']->value['languages']['is_main'];?>

                </label>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="action" value="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
">
</form><?php }} ?>
