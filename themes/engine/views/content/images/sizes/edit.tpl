<form action="./contentImagesSizes/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_size" class="col-sm-3 control-label">{$t.contentImagesSizes.size}</label>
        <div class="col-sm-9">
            <input {if $action == 'edit'}readonly{/if} name="data[size]" id="data_size"  class="form-control" value="{if isset($data.size)}{$data.size}{/if}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_width" class="col-sm-3 control-label">{$t.contentImagesSizes.width}</label>
        <div class="col-sm-9">
            <input name="data[width]" id="data_width"  class="form-control" value="{if isset($data.width)}{$data.width}{/if}" required onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0">
        </div>
    </div>
    <div class="form-group">
        <label for="data_height" class="col-sm-3 control-label">{$t.contentImagesSizes.height}</label>
        <div class="col-sm-9">
            <input name="data[height]" id="data_height"  class="form-control" value="{if isset($data.height)}{$data.height}{/if}" required onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0">
        </div>
    </div>
    <div class="form-group">
        <label for="types" class="col-sm-3 control-label">{$t.contentImagesSizes.types}</label>
        <div class="col-sm-9">
            <select name="types[]" multiple id="content_types"  class="form-control" required>
                {foreach $types as $t}
                    <option  {if in_array($t.id, $data.types)}selected{/if} value="{$t.id}">{$t.name}</option>
                    {if $t.isfolder}
                        {foreach $t.items as $item}
                            <option {if in_array($item.id, $data.types)}selected{/if} value="{$item.id}">{$t.name} / {$item.name}</option>
                        {/foreach}
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>