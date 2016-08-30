<form action="modules/process" method="post" id="modulesForm" class="form-horizontal">
    {foreach $config as $k=>$v}
    <div class="form-group">
        <label for="config_{$k}" class="col-sm-3 control-label" title="{$k}">{$t[lcfirst($module)].config[$k]}</label>
        <div class="col-sm-9">
            <input name="config[{$k}]" id="config_{$k}" value="{$v}" class="form-control" required>
        </div>
    </div>
    {/foreach}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="module" value="{$module}">
</form>