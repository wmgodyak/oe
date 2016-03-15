<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-12 21:19:03
         compiled from "/var/www/engine.loc/themes/engine/views/admin/edit_profile.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1192116255681513d066ae1-08123358%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '69d1d9450461e1879027190fa631f537a420a67c' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/admin/edit_profile.tpl',
      1 => 1457553216,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1192116255681513d066ae1-08123358',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_5681513d071eb0_26693519',
  'variables' => 
  array (
    't' => 0,
    'ui' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5681513d071eb0_26693519')) {function content_5681513d071eb0_26693519($_smarty_tpl) {?><form class="form-horizontal" action="admin/profile" enctype="multipart/form-data" method="post" id="editProfileForm">
<div class="row">
    <div class="col-md-9">
        <fieldset>
            <legend>Основне</legend>
            <div class="form-group">
                <label for="data_name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['name'];?>
</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[name]" id="data_name" value="<?php echo $_smarty_tpl->tpl_vars['ui']->value['name'];?>
" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_surname" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['surname'];?>
</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" name="data[surname]" id="data_surname" value="<?php echo $_smarty_tpl->tpl_vars['ui']->value['surname'];?>
" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_email" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['email'];?>
</label>
                <div class="col-sm-9">
                    <input type="email" class="form-control" name="data[email]" id="data_email" value="<?php echo $_smarty_tpl->tpl_vars['ui']->value['email'];?>
" required>
                </div>
            </div>
            <div class="form-group">
                <label for="data_phone" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['phone'];?>
</label>
                <div class="col-sm-9">
                    <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="<?php echo $_smarty_tpl->tpl_vars['ui']->value['phone'];?>
" required>
                </div>
            </div>
        </fieldset>
    </div>
    <div class="col-md-3">
        <fieldset style="height: 245px;">
            <legend>Фото</legend>
            <div style="text-align: center; margin-bottom: 1em;"><img src="<?php echo $_smarty_tpl->tpl_vars['ui']->value['avatar'];?>
" alt="" class="admin-avatar"></div>
            <div style="display: none">
                <input type="file" name="avatar" id="adminAvatar">
            </div>
            <div style="text-align: center"><button type="button" id="changeAvatar" class="btn btn-default">Змінити</button></div>
        </fieldset>
    </div>
</div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Зміна паролю</legend>
                <div class="form-group">
                    <label for="data_password" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['password'];?>
</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" name="data[password]" id="data_password">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_password_c" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['password_c'];?>
</label>
                    <div class="col-sm-9">
                        <input type="password" class="form-control" name="data[password_c]" id="data_password_c" >
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
</form><?php }} ?>
