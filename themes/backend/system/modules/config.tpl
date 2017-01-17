<form action="modules/process" method="post" id="modulesForm" class="row form-horizontal">
    {foreach $config as $k=>$v}
        {if ! is_array($v)}
            <div class="form-group">
                <label for="config_{$k}" class="col-sm-3 control-label" title="{$k}">{$t[lcfirst($module)].config[$k]}</label>
                <div class="col-sm-9">
                    <input name="config[{$k}]" id="config_{$k}" value="{$v}" class="form-control" required>
                </div>
            </div>
        {/if}
    {/foreach}
    {$events->call("system.modules.config", $config)}
    {$events->call("system.modules.config.`$module`", $config)}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="module" value="{$module}">
</form>