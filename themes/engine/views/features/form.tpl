<form action="features/process/{$data.id}" method="post" id="form" class="form-horizontal" >
    {if isset($plugins.top)}
        <div class="row">
            <div class="col-md-12">
                {implode("\r\n", $plugins.top)}
            </div>
        </div>
    {/if}
    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>Основне</legend>
                {foreach $languages as $lang}
                    <div class="form-group">
                        <label for="name_{$lang.id}" class="col-sm-3 control-label">{$t.features.name} ({$lang.code})</label>
                        <div class="col-sm-9">
                            <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="info_{$lang.id}"  class="form-control" value="{$data.info[$lang.id].name}">
                        </div>
                    </div>
                {/foreach}
                <div class="form-group">
                    <label for="guides_code" class="col-sm-3 control-label">{$t.features.code}</label>
                    <div class="col-sm-9">
                        <input name="guides[code]" id="guides_code"  class="form-control" value="{$data.code}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-md-3 control-label">{$t.features.type}</label>
                    <div class="col-md-9">
                        <select name="data[type]" id="data_type" class="form-control">
                            {foreach $data.types as $i=>$item}
                                <option {if $data.type == $item}selected{/if} value="{$item}">{$item}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                {if isset($plugins.main)}{implode("\r\n", $plugins.main)}{/if}
            </fieldset>
        </div>
        <div class="col-md-4">
            <fieldset>
                <legend>Параметри</legend>
                <div class="form-group">
                    <label for="data_status" class="col-md-3 control-label">{$t.features.status}</label>
                    <div class="col-md-9">
                        <select name="data[status]" id="data_status" class="form-control">
                            {foreach $data.statuses as $i=>$item}
                                {if $i > 0}
                                <option {if $data.status == $item}selected{/if} value="{$item}">{$item}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-9 col-md-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="data[on_filter]" value="0">
                                <input {if $data.on_filter == 1}checked{/if} type="checkbox" name="data[on_filter]" id="data_on_filter" value="1"> {$t.features.on_filter}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-9 col-md-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="data[multiple]" value="0">
                                <input {if $data.multiple == 1}checked{/if} type="checkbox" name="data[multiple]" id="data_multiple" value="1"> {$t.features.multiple}
                            </label>
                        </div>
                    </div>
                </div>
                {if isset($plugins.params)}{implode("\r\n", $plugins.params)}{/if}
            </fieldset>
        </div>
    </div>
    {if isset($plugins.bottom)}
        <div class="row">
            <div class="col-md-12">
                {implode("\r\n", $plugins.bottom)}
            </div>
        </div>
    {/if}
    <input type="hidden" name="token" value="{$token}">
</form>