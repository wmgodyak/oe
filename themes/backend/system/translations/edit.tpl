<form action="translations/process/0" method="post" id="form" class="form-horizontal" >
    {foreach $languages->get() as $lang}
        <div class="form-group">
            <label for="data_{$lang.code}" class="col-sm-3 control-label">{$lang.name}</label>
            <div class="col-sm-9">
                <input name="data[{$lang.code}]"  placeholder="{$lang.code}" id="data_{$lang.code}" class="form-control" value="{$data[$lang.code]}">
            </div>
        </div>
    {/foreach}
    <input type="hidden" name="id" value="{$id}">
    <input type="hidden" name="path" value="{$path}">
    <input type="hidden" name="token" value="{$token}">
</form>
