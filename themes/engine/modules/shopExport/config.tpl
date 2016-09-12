{*<pre>{print_r($adapters)}</pre>*}
{foreach $adapters as $adapter}
    <h3>Налаштування для {$adapter}</h3>

    <div class="form-group">
        <label for="adapter_group_id" class="col-sm-3 control-label">Група ціни</label>
        <div class="col-sm-9">
            <input name="adapter[group_id]" id="adapter_group_id"  class="form-control" value="" required>
        </div>
    </div>
    <div class="form-group">
        <label for="adapter_currency_id" class="col-sm-3 control-label">Валюта</label>
        <div class="col-sm-9">
            <input name="adapter[currency_id]" id="adapter_currency_id"  class="form-control" value="" required>
        </div>
    </div>
    <div class="form-group">
        <label for="adapter_languages_id" class="col-sm-3 control-label">Мова</label>
        <div class="col-sm-9">
            <input name="adapter[languages_id]" id="adapter_languages_id"  class="form-control" value="" required>
        </div>
    </div>
{/foreach}