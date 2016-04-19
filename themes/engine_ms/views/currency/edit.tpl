<form action="./currency/process/{$data.id}" method="post" id="form" class="form-horizontal">
   <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.currency.name}</label>
        <div class="col-sm-9">
            <input name="data[name]" id="data_name"  class="form-control" value="{$data.name}" placeholder="Гривня">
        </div>
    </div>
   <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.currency.code}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="{$data.code}" placeholder="UAH">
        </div>
    </div>
   <div class="form-group">
        <label for="data_rate" class="col-sm-3 control-label">{$t.currency.rate}</label>
        <div class="col-sm-9">
            <input name="data[rate]" id="data_rate"  class="form-control" value="{$data.rate}" placeholder="1">
        </div>
    </div>
    <div class="form-group">
        <label for="data_symbol" class="col-sm-3 control-label">{$t.currency.symbol}</label>
        <div class="col-sm-9">
            <input name="data[symbol]" id="data_symbol"  class="form-control" value="{$data.symbol}" placeholder="грн.">
        </div>
    </div>
    <div class="form-group">
        <label for="data_is_main" class="col-sm-3 control-label">{$t.currency.is_main}</label>
        <div class="col-sm-9">
            <input type="hidden"  name="data[is_main]"  class="form-control" value="0" >
            <input type="checkbox" {if $data.is_main}checked{/if} name="data[is_main]" id="data_is_main" value="1" >
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>