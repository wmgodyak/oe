<form action="module/run/currency/process/{if isset($data.id)}{$data.id}{/if}" method="post" id="form" class="form-horizontal">
   <div class="form-group">
        <label for="data_name" class="col-md-2 control-label">{$t.currency.name}</label>
        <div class="col-md-10">
            <input name="data[name]" id="data_name"  class="form-control" value="{if isset($data.name)}{$data.name}{/if}" placeholder="Гривня">
        </div>
    </div>
   <div class="form-group">
        <label for="data_code" class="col-md-2 control-label">{$t.currency.code}</label>
        <div class="col-md-10">
            <input name="data[code]" id="data_code"  class="form-control" value="{if isset($data.code)}{$data.code}{/if}" placeholder="UAH">
        </div>
    </div>
   <div class="form-group">
        <label for="data_rate" class="col-md-2 control-label">{$t.currency.rate}</label>
        <div class="col-md-10">
            <input name="data[rate]" id="data_rate"  class="form-control" value="{if isset($data.rate)}{$data.rate}{/if}" placeholder="1">
        </div>
    </div>
    <div class="form-group">
        <label for="data_symbol" class="col-md-2 control-label">{$t.currency.symbol}</label>
        <div class="col-md-10">
            <input name="data[symbol]" id="data_symbol"  class="form-control" value="{if isset($data.symbol)}{$data.symbol}{/if}" placeholder="грн.">
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden"  name="data[is_main]"  class="form-control" value="0" >
                    <input type="checkbox" {if isset($data.is_main) && $data.is_main}checked{/if} name="data[is_main]" id="data_is_main" value="1" > {$t.currency.is_main}
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden"  name="data[on_site]"  class="form-control" value="0" >
                    <input type="checkbox" {if isset($data.on_site) && $data.on_site}checked{/if} name="data[on_site]" id="data_on_site" value="1" > {$t.currency.on_site}
                </label>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>