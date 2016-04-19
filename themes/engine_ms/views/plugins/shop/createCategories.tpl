<form action="./plugins/productsCategories/process/{$content.id}" method="post" id="productsCategoriesForm" class="form-horizontal">

    {include "content/blocks/main.tpl"}
    {include "content/blocks/meta.tpl"}

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="content[status]" value="published">
    <input type="hidden" name="content[owner_id]" value="{$admin.id}">
    <input type="hidden" name="content[parent_id]" value="{$content.parent_id}">
    <input type="hidden" name="action" value="{$action}">

</form>