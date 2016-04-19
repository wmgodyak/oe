<form action="./guides/process/{$data.id}" method="post" id="form" class="form-horizontal">
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="name_{$lang.id}" class="col-sm-3 control-label">{$t.languages.name} ({$lang.code})</label>
            <div class="col-sm-9">
                <textarea name="guides_info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="name_{$lang.id}"  class="form-control" >{$data.info[$lang.id].name}</textarea>
            </div>
        </div>
    {/foreach}
    <div class="form-group">
        <label for="guides_code" class="col-sm-3 control-label">{$t.guides.code}</label>
        <div class="col-sm-9">
            <input name="guides[code]" id="guides_code"  class="form-control" value="{$data.code}">
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="guides[parent_id]" value="{$data.parent_id}">
</form>