<form action="guides/process/{if isset($content.id)}{$content.id}{/if}" method="post" id="guidesForm" class="form-horizontal">

    {include "content/blocks/main.tpl"}
    {include "content/blocks/meta.tpl"}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="content[status]" value="published">
    <input type="hidden" name="content[owner_id]" value="{$admin.id}">
    <input type="hidden" name="content[parent_id]" value="{$content.parent_id}">
    <input type="hidden" name="action" value="{$action}">
</form>