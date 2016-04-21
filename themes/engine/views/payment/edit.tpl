<form action="./payment/process/{$data.id}" method="post" id="form" class="form-horizontal">

    {foreach $languages as $lang}
        <div class="form-group">
            <label for="info_{$lang.id}" class="col-md-2 control-label">{$t.payment.name} ({$lang.code})</label>
            <div class="col-md-10">
                <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="info_{$lang.id}" class="form-control" value="{$data.info[$lang.id].name}">
            </div>
        </div>
        <div class="form-group">
            <label for="info_{$lang.id}" class="col-md-2 control-label">{$t.payment.description} ({$lang.code})</label>
            <div class="col-md-10">
                <textarea name="info[{$lang.id}][description]"  placeholder="{$lang.name}" id="info_{$lang.id}"  class="form-control" >{$data.info[$lang.id].description}</textarea>
            </div>
        </div>
    {/foreach}
    <div class="form-group">
        <label for="data_module" class="col-md-2 control-label">{$t.payment.module}</label>
        <div class="col-md-10">
            <select name="data[module]" id="data_module" class="form-control">
                <option value=''>Немає</option>
                {foreach $modules as $k=>$item}
                    <option {if $item == $data.module}selected{/if} value="{$item}">{$item}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div id="p_settings"></div>
    <div class="form-group">
        <label for="data_delivery" class="col-md-2 control-label">{$t.payment.delivery}</label>
        <div class="col-md-10">
            <select name="delivery[]" multiple id="data_delivery" required class="form-control">
                {foreach $delivery as $item}
                    <option {if isset($selected) && in_array($item.id,$selected)}selected{/if} value="{$item.id}">{$item.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10 col-md-offset-2">
            <div class="checkbox">
                <label>
                    <input type="hidden"  name="data[published]"  class="form-control" value="0" >
                    <input type="checkbox" {if $data.published}checked{/if} name="data[published]" id="data_published" value="1" > {$t.payment.published}
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
            <label for="" class="col-md-2 control-label"><%- items[i].name %></label>
            <div class="col-md-10">
                <input type="text" required name="data[settings][<%- items[i].name %>]" class="form-control" value="<%- items[i].value %>" >
            </div>
        </div>
        <% } %>
    </script>
{/literal}