<?php /* Smarty version Smarty-3.1.21-dev, created on 2016-04-26 10:48:41
         compiled from "/var/www/engine.loc/themes/engine/views/plugins/admins/groups/form.tpl" */ ?>
<?php /*%%SmartyHeaderCode:47038150856a8915aaa2d88-04957485%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f6252f0e64e95b78f49edea2d27ceb43c10ff292' => 
    array (
      0 => '/var/www/engine.loc/themes/engine/views/plugins/admins/groups/form.tpl',
      1 => 1461656630,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '47038150856a8915aaa2d88-04957485',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.21-dev',
  'unifunc' => 'content_56a8915ab04256_91752298',
  'variables' => 
  array (
    'data' => 0,
    't' => 0,
    'groups' => 0,
    'group' => 0,
    'languages' => 0,
    'lang' => 0,
    'info' => 0,
    'components' => 0,
    'component' => 0,
    'a' => 0,
    'row' => 0,
    '_action' => 0,
    'action' => 0,
    'token' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_56a8915ab04256_91752298')) {function content_56a8915ab04256_91752298($_smarty_tpl) {?><form class="form-horizontal" action="plugins/adminsGroup/process/<?php echo $_smarty_tpl->tpl_vars['data']->value['id'];?>
" method="post" id="adminsGroupForm">
    <fieldset>
        <legend>Основне</legend>
        <div class="form-group">
            <label for="data_parent_id" class="col-md-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admins_group']['parent'];?>
</label>
            <div class="col-md-9">
                <select class="form-control" name="data[parent_id]" id="data_parent_id">
                    <option value="0">--</option>
                    <?php  $_smarty_tpl->tpl_vars['group'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['group']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['groups']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['group']->key => $_smarty_tpl->tpl_vars['group']->value) {
$_smarty_tpl->tpl_vars['group']->_loop = true;
?>
                        <option <?php if ($_smarty_tpl->tpl_vars['data']->value['parent_id']==$_smarty_tpl->tpl_vars['group']->value['id']) {?>selected<?php }?> value="<?php echo $_smarty_tpl->tpl_vars['group']->value['id'];?>
"><?php echo $_smarty_tpl->tpl_vars['group']->value['name'];?>
</option>
                        <?php if ($_smarty_tpl->tpl_vars['group']->value['isfolder']) {?>
                            <?php echo $_smarty_tpl->getSubTemplate ("plugins/admins/groups/options.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array('items'=>$_smarty_tpl->tpl_vars['group']->value['items'],'level'=>1,'disabled'=>$_smarty_tpl->tpl_vars['data']->value['parent_id']==$_smarty_tpl->tpl_vars['group']->value['id']), 0);?>

                        <?php }?>
                    <?php } ?>
                </select>
            </div>
        </div>
        <?php  $_smarty_tpl->tpl_vars['lang'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['lang']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['languages']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['lang']->key => $_smarty_tpl->tpl_vars['lang']->value) {
$_smarty_tpl->tpl_vars['lang']->_loop = true;
?>
            <div class="form-group">
                <label for="info_name_<?php echo $_smarty_tpl->tpl_vars['lang']->value['id'];?>
" class="col-md-3 control-label"><?php echo $_smarty_tpl->tpl_vars['t']->value['admins_group']['name'];?>
 (<?php echo $_smarty_tpl->tpl_vars['lang']->value['name'];?>
)</label>
                <div class="col-md-9">
                    <input type="tel" class="form-control" name="info[<?php echo $_smarty_tpl->tpl_vars['lang']->value['id'];?>
][name]" id="info_name_<?php echo $_smarty_tpl->tpl_vars['lang']->value['id'];?>
" value="<?php echo $_smarty_tpl->tpl_vars['info']->value[$_smarty_tpl->tpl_vars['lang']->value['id']]['name'];?>
" required>
                </div>
            </div>
        <?php } ?>
        <div class="form-group">
            <div class="col-md-10">
                <input type="hidden"  name="permissions[full_access]"  class="form-control" value="0" >
                <input type="checkbox" <?php if ($_smarty_tpl->tpl_vars['data']->value['permissions']['full_access']) {?>checked<?php }?> name="permissions[full_access]" id="permissions_full_access" value="1" > Повний доступ
            </div>
        </div>
    </fieldset>
    <fieldset id="custom_permissions" style="display: <?php if ($_smarty_tpl->tpl_vars['data']->value['permissions']['full_access']) {?>none<?php } else { ?>block<?php }?>">
        <legend>Виберіть доступ до компонентів</legend>
        
        <?php  $_smarty_tpl->tpl_vars['a'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['a']->_loop = false;
 $_smarty_tpl->tpl_vars['component'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['components']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['a']->key => $_smarty_tpl->tpl_vars['a']->value) {
$_smarty_tpl->tpl_vars['a']->_loop = true;
 $_smarty_tpl->tpl_vars['component']->value = $_smarty_tpl->tpl_vars['a']->key;
?>
            <div class="form-group">
                <label for="p_<?php echo $_smarty_tpl->tpl_vars['component']->value;?>
" class="col-md-3 control-label"><a class="gp-toggle-c-actions" data-id="<?php echo str_replace('\\','-',$_smarty_tpl->tpl_vars['component']->value);?>
" href="javascript:void('Клік щоб вибрати все');"><?php echo $_smarty_tpl->tpl_vars['component']->value;?>
</a></label>
                <div class="col-md-9">
                    <div class="row">
                        <?php  $_smarty_tpl->tpl_vars['row'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['row']->_loop = false;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = array_chunk($_smarty_tpl->tpl_vars['a']->value,3); if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['row']->key => $_smarty_tpl->tpl_vars['row']->value) {
$_smarty_tpl->tpl_vars['row']->_loop = true;
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['row']->key;
?>
                            <div class="col-md-4">
                                <?php  $_smarty_tpl->tpl_vars['_action'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['_action']->_loop = false;
 $_smarty_tpl->tpl_vars['c'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['row']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['_action']->key => $_smarty_tpl->tpl_vars['_action']->value) {
$_smarty_tpl->tpl_vars['_action']->_loop = true;
 $_smarty_tpl->tpl_vars['c']->value = $_smarty_tpl->tpl_vars['_action']->key;
?>
                                    <label class="checkbox" style="width: 100%;display: inline-block; ">
                                        <input <?php if ($_smarty_tpl->tpl_vars['data']->value['permissions'][$_smarty_tpl->tpl_vars['component']->value]&&in_array($_smarty_tpl->tpl_vars['_action']->value,$_smarty_tpl->tpl_vars['data']->value['permissions'][$_smarty_tpl->tpl_vars['component']->value])) {?>checked<?php }?> type="checkbox" class="com <?php echo str_replace('\\','-',$_smarty_tpl->tpl_vars['component']->value);?>
" id="<?php echo $_smarty_tpl->tpl_vars['component']->value;?>
_<?php echo $_smarty_tpl->tpl_vars['_action']->value;?>
" name="permissions[<?php echo $_smarty_tpl->tpl_vars['component']->value;?>
][]" value="<?php echo $_smarty_tpl->tpl_vars['_action']->value;?>
"> <?php echo $_smarty_tpl->tpl_vars['_action']->value;?>

                                    </label>
                                <?php } ?>
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        <?php } ?>
    </fieldset>


    <input type="hidden" name="action" value="<?php echo $_smarty_tpl->tpl_vars['action']->value;?>
">
    <input type="hidden" name="token" value="<?php echo $_smarty_tpl->tpl_vars['token']->value;?>
">
    <input type="hidden" name="a" value="1">
</form><?php }} ?>
