<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-03-09 22:00:58
         compiled from "/var/www/engine.loc/themes/engine/views/admin/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:398824386567be3f6de1cc0-24252758%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '87d8cba10fb1d6df3949caec82668d7e60c8e8f6' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/admin/login.tpl',
      1 => 1457553216,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '398824386567be3f6de1cc0-24252758',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_567be3f6deed89_26508991',
  'variables' => 
  array (
    'theme_url' => 0,
    't' => 0,
    'langs' => 0,
    'lang' => 0,
    's_lang' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_567be3f6deed89_26508991')) {function content_567be3f6deed89_26508991($_smarty_tpl) {?><section class="log-in">
    <div class="table">
        <div class="table-cell">
            <form class="login" action="admin/login" method="post" id="adminLogin">
                <div class="logo">
                    <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/img/logo/logo.png">
                </div>
                <div class="input-group">
                    <label for="email"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['email'];?>
</label>
                    <input type="email" name="data[email]" id="email" required>
                </div>
                <div class="input-group">
                    <label for="password"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['password'];?>
</label>
                    <input type="password" name="data[password]" id="password">
                    <div class="show-value" id="show-pass">
                        <i class="fa fa-eye"></i>
                        <i class="fa fa-eye-slash"></i>
                    </div>
                </div>
                <div class="input-group">
                    <label for="lang"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['lang'];?>
</label>
                    <select name="data[lang]" id="adminLang">
                        <?php  $_smarty_tpl->tpl_vars['lang'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['lang']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['langs']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['lang']->key => $_smarty_tpl->tpl_vars['lang']->value) {
$_smarty_tpl->tpl_vars['lang']->_loop = true;
?>
                            <option <?php if ($_smarty_tpl->tpl_vars['lang']->value['code']==$_smarty_tpl->tpl_vars['s_lang']->value) {?>selected<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['lang']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['lang']->value['name'];?>
</option>
                        <?php } ?>
                    </select>
                </div>
                <div class="f-link">
                    <a href="#" class="b-admin-fp" onclick="return false;"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['fp_link'];?>
</a>
                </div>
                <button type="submit" class="btn btn-info btn-lg rippler rippler-default"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['b_login'];?>
</button>
                <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
            </form>

            <form class="login" action="admin/fp" method="post" id="adminFp" style="display: none">
                <div class="logo">
                    <img src="<?php echo $_smarty_tpl->tpl_vars['theme_url']->value;?>
assets/img/logo/logo.png">
                </div>
                <div class="input-group">
                    <label for="email"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['email'];?>
</label>
                    <input type="email" name="data[email]" id="email" required>
                </div>
                <div class="f-link">
                    <a href="#" class="b-admin-login" onclick="return false;"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['login_link'];?>
</a>
                </div>
                <button type="submit" class="btn btn-info btn-lg rippler rippler-default"><?php echo $_smarty_tpl->tpl_vars['t']->value['admin']['b_send_pass'];?>
</button>
                <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
            </form>
        </div>
    </div>
</section><?php }} ?>
