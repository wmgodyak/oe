{extends 'system/admins/form.tpl'}
{block name="system.admins.form.action"}module/run/users/process{if isset($data.id)}/{$data.id}{/if}{/block}