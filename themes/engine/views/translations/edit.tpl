<form action="./translations/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.languages.code}</label>
        <div class="col-sm-9">
            <input name="translations[code]" id="data_code"  class="form-control" value="{$data.code}" required placeholder="{$t.languages.placeholder_code}">
        </div>
    </div>
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="value_{$lang.id}" class="col-sm-3 control-label">{$t.languages.name} ({$lang.code})</label>
            <div class="col-sm-9">
                <textarea name="translations_info[{$lang.id}][value]"  placeholder="{$lang.name}" required id="value_{$lang.id}"  class="form-control" >{$data.info[$lang.id].value}</textarea>
            </div>
        </div>
    {/foreach}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>