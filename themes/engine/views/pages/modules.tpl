<div class="form-group">
    <label for="settings_parent_id" class="col-md-3 control-label">
        {$t.contentTypes.modules}
    </label>
    <div class="col-md-9">
        {*<pre>{print_r($content)}</pre>*}
        <select name="content[settings][modules][]" id="settingsModules" class="form-control" multiple>
            {foreach $modules as $module=>$a}
                <optgroup label="{$module}">
                    {foreach $a as $k=>$ac}
                        <option {if $ps.modules && in_array($ac, $ps.modules)}selected{/if} value="{$ac}">{$ac}</option>
                    {/foreach}
                </optgroup>
            {/foreach}
        </select>
        <p class="help-block">{$t.contentTypes.modules_i}</p>
    </div>
</div>