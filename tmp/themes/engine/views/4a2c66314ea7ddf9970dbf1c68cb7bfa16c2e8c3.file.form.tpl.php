<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-01-16 13:32:14
         compiled from "/var/www/engine.loc/themes/engine/views/admins/form.tpl" */ ?>
<?php /*%%SmartyHeaderCode:924019438569a11da17ecf3-87435704%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4a2c66314ea7ddf9970dbf1c68cb7bfa16c2e8c3' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/admins/form.tpl',
      1 => 1452943931,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '924019438569a11da17ecf3-87435704',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_569a11da17f413_62442182',
  'variables' => 
  array (
    'data' => 0,
    't' => 0,
    'groups' => 0,
    'group' => 0,
    'item' => 0,
    'action' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_569a11da17f413_62442182')) {function content_569a11da17f413_62442182($_smarty_tpl) {?><form class="form-horizontal" action="admins/process/<?php echo $_smarty_tpl->tpl_vars['data']->value['id'];?>
" enctype="multipart/form-data" method="post" id="form">
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>Основне</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['name'];?>
</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['name'];?>
" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_surname" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['surname'];?>
</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[surname]" id="data_surname" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['surname'];?>
" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_email" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['email'];?>
</label>
                    <div class="col-sm-9">
                        <input type="email" class="form-control" name="data[email]" id="data_email" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['email'];?>
" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_phone" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin_profile']['phone'];?>
</label>
                    <div class="col-sm-9">
                        <input type="tel" class="form-control" name="data[phone]" id="data_phone" value="<?php echo $_smarty_tpl->tpl_vars['data']->value['phone'];?>
">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_group_id" class="col-sm-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admins']['group'];?>
</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="data[group_id]" id="data_group_id">
                            <?php  $_smarty_tpl->tpl_vars['group'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['group']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['groups']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['group']->key => $_smarty_tpl->tpl_vars['group']->value) {
$_smarty_tpl->tpl_vars['group']->_loop = true;
?>
                                <?php if ($_smarty_tpl->tpl_vars['group']->value['isfolder']) {?>
                                    <optgroup label="<?php echo $_smarty_tpl->tpl_vars['group']->value['name'];?>
">
                                        <?php  $_smarty_tpl->tpl_vars['item'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['item']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['group']->value['items']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['item']->key => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->_loop = true;
?>
                                            <option <?php if ($_smarty_tpl->tpl_vars['data']->value['group_id']==$_smarty_tpl->tpl_vars['item']->value['id']) {?>selected<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['item']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['item']->value['name'];?>
</option>
                                        <?php } ?>
                                    </optgroup>
                                    <?php } else { ?>
                                    <option <?php if ($_smarty_tpl->tpl_vars['data']->value['group_id']==$_smarty_tpl->tpl_vars['group']->value['id']) {?>selected<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['group']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['group']->value['name'];?>
</option>
                                <?php }?>
                            <?php } ?>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="is_main" class="col-sm-3 control-label"></label>
                    <div class="col-sm-9">

                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="notify" value="0">
                                <input type="checkbox" name="notify" id="notify" value="1"> <?php echo $_smarty_tpl->tpl_vars['t']->value['admins']['notify'];?>

                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-3">
            <fieldset style="height: 330px;">
                <legend>Фото</legend>
                <div style="text-align: center; margin-bottom: 1em;"><img src="<?php echo $_smarty_tpl->tpl_vars['data']->value['avatar'];?>
" alt="" class="edit-admin-avatar admin-avatar" style="max-width: 130px;"></div>
                <div style="display: none">
                    <input type="file" name="avatar" id="adminAvatar">
                </div>
                <?php if ($_smarty_tpl->tpl_vars['action']->value=='edit') {?>
                <div style="text-align: center"><button type="button" id="changeAdminAvatar" class="btn btn-default">Змінити</button></div>
                <?php }?>
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
                        <input type="password" class="form-control" name="data[password]" id="data_password" placeholder="<?php echo $_smarty_tpl->tpl_vars['t']->value['admins']['passw_gen_auto'];?>
">
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

    <input type="hidden" name="action" value="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
">
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
</form><?php }} ?>
