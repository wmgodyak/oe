<form action="./delivery/process/{$data.id}" method="post" id="form" class="form-horizontal">

    {foreach $languages as $lang}
        <div class="form-group">
            <label for="info_{$lang.id}" class="col-sm-3 control-label">{$t.delivery.name} ({$lang.code})</label>
            <div class="col-sm-9">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="info_{$lang.id}" class="form-control" value="{$data.info[$lang.id].name}">
            </div>
        </div>
        <div class="form-group">
            <label for="info_{$lang.id}" class="col-sm-3 control-label">{$t.delivery.description} ({$lang.code})</label>
            <div class="col-sm-9">
                <textarea name="info[{$lang.id}][description]"  placeholder="{$lang.name}" id="info_{$lang.id}"  class="form-control" >{$data.info[$lang.id].description}</textarea>
            </div>
        </div>
    {/foreach}

    <div class="form-group">
        <label for="data_price" class="col-sm-3 control-label">{$t.delivery.price}</label>
        <div class="col-sm-9">
            <input name="data[price]" id="data_price"  class="form-control" value="{$data.price}">
        </div>
    </div>

    <div class="form-group">
        <label for="data_free_from" class="col-sm-3 control-label">{$t.delivery.free_from}</label>
        <div class="col-sm-9">
            <input name="data[free_from]" id="data_free_from"  class="form-control" value="{$data.free_from}">
        </div>
    </div>

    <div class="form-group">
        <label for="data_free_from" class="col-sm-3 control-label">{$t.delivery.payment}</label>
        <div class="col-sm-9">
            <select name="payment[]" multiple id="data_payment" required class="form-control">
                {foreach $payment as $item}
                    <option {if isset($selected) && in_array($item.id,$selected)}selected{/if} value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_module" class="col-sm-3 control-label">{$t.payment.module}</label>
        <div class="col-sm-9">
            <select name="data[module]" id="data_module" class="form-control">
                <option value=''>Немає</option>
                {foreach $modules as $k=>$item}
                    <option {if $item == $data.module}selected{/if} value="{$item}">{$item}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div id="d_settings"></div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden"  name="data[published]"  class="form-control" value="0" >
                    <input type="checkbox" {if $data.published}checked{/if} name="data[published]" id="data_published" value="1" > {$t.delivery.published}
                </label>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>
{literal}
    <script type="text/template" id="settingsList" >
        <% console.log(items); %>
        <% for(var i=0; i < items.length; i++) { %>
        <div class="form-group">
            <label for="" class="col-sm-3 control-label"><%- items[i].name %></label>
            <div class="col-sm-9">
                <input type="text" required name="data[settings][<%- items[i].name %>]" class="form-control" value="<%- items[i].value %>" >
            </div>
        </div>
        <% } %>
    </script>
{/literal}