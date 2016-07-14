<form action="./module/run/order/status/process/{$data.id}" method="post" id="form" class="form-horizontal">
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="info_{$lang.id}" class="col-sm-3 control-label">{$t.ordersStatus.status} ({$lang.code})</label>
            <div class="col-sm-9">
                <input name="info[{$lang.id}][status]"  placeholder="{$lang.name}" required id="info_{$lang.id}" class="form-control" value="{if isset($data.info[$lang.id].status)}{$data.info[$lang.id].status}{/if}">
            </div>
        </div>
    {/foreach}

    <div class="form-group">
        <label for="data_bg_color" class="col-sm-3 control-label">{$t.ordersStatus.bg_color}</label>
        <div class="col-sm-9">
            <input name="data[bg_color]" id="data_bg_color"  class="form-control" value="{if isset($data.bg_color)}{$data.bg_color}{/if}" type="color" required>
        </div>
    </div>

    <div class="form-group">
        <label for="data_txt_color" class="col-sm-3 control-label">{$t.ordersStatus.txt_color}</label>
        <div class="col-sm-9">
            <input name="data[txt_color]" id="data_txt_color"  class="form-control" value="{if isset($data.txt_color)}{$data.txt_color}{/if}" type="color" required>
        </div>
    </div>

    <div class="form-group">
        <label for="data_external_id" class="col-sm-3 control-label">{$t.ordersStatus.external_id}</label>
        <div class="col-sm-9">
            <input name="data[external_id]" id="data_external_id"  class="form-control" value="{if isset($data.external_id)}{$data.external_id}{/if}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_on_site" class="col-sm-3 control-label">{$t.ordersStatus.on_site}</label>
        <div class="col-sm-9">
            <input type="hidden"  name="data[on_site]"  class="form-control" value="0" >
            <input type="checkbox" {if isset($data.on_site) && $data.on_site == 1}checked{/if} name="data[on_site]" id="data_on_site" value="1" >
        </div>
    </div>
    <div class="form-group">
        <label for="data_is_main" class="col-sm-3 control-label">{$t.ordersStatus.is_main}</label>
        <div class="col-sm-9">
            <input type="hidden"  name="data[is_main]"  class="form-control" value="0" >
            <input type="checkbox" {if isset($data.is_main) && $data.is_main == 1}checked{/if} name="data[is_main]" id="data_is_main" value="1" >
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>