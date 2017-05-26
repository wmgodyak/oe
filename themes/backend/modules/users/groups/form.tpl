{extends 'system/admins/groups/form.tpl'}
{block name="system.admins.groups.form.action"}module/run/users/groups/process{if isset($data.id)}/{$data.id}{/if}{/block}
{block name="system.admins.groups.form.id"}usersGroupForm{/block}
{block name="system.admins.groups.form.full_access_group" hide}{/block}
{block name="system.admins.groups.form.access_to_components" hide}{/block}
{block name="system.admins.groups.form.access_to_modules" hide}{/block}