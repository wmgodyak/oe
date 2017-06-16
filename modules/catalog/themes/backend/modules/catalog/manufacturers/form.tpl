<form action="module/run/catalog/manufacturers/process/{if isset($content.id)}{$content.id}{/if}" method="post" id="catalogManufacturersForm" class="form-horizontal">

    {include "system/content/blocks/main.tpl"}
    {include "system/content/blocks/meta.tpl"}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="content[status]" value="published">
    <input type="hidden" name="content[owner_id]" value="{$admin.id}">
    <input type="hidden" name="content[parent_id]" value="{$content.parent_id}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="modal" value="1">

</form>