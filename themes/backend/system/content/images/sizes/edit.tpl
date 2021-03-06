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
        <label for="data_quality" class="col-sm-3 control-label">{$t.contentImagesSizes.quality}</label>
        <div class="col-sm-9">
            <input name="data[quality]" id="data_quality"  class="form-control" value="{if isset($data.quality)}{$data.quality}{/if}" required onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0; if(this.value > 100 ) this.value=100; if(this.value < 0) this.value=0;">
        </div>
    </div>
    <div class="form-group">
        <label for="types" class="col-sm-3 control-label">{$t.contentImagesSizes.types}</label>
        <div class="col-sm-9">
            <select name="types[]" multiple id="content_types"  class="form-control" required>
                {foreach $types as $type}
                    <option  {if in_array($type.id, $data.types)}selected{/if} value="{$type.id}">{$type.name}</option>
                    {if $type.isfolder}
                        {foreach $type.items as $item}
                            <option {if in_array($item.id, $data.types)}selected{/if} value="{$item.id}">{$type.name} / {$item.name}</option>
                        {/foreach}
                    {/if}
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div class="checkbox">
                <label>
                    <input type="hidden"   name="data[watermark]" value="0">
                    <input type="checkbox" id="data_watermark" name="data[watermark]" {if isset($data.watermark) && $data.watermark==1}checked{/if} value="1">
                    {$t.contentImagesSizes.watermark}
                </label>
            </div>
        </div>
    </div>
    <div class="watermark-settings" style="display: {if isset($data.watermark) && $data.watermark==1}block{else}none{/if} ">
        {* <div class="form-group">
            <label for="data_opacity" class="col-sm-3 control-label">{$t.contentImagesSizes.watermark_opacity}</label>
            <div class="col-sm-9">
                <input name="data[watermark_opacity]" id="data_opacity"  class="form-control" value="{if isset($data.watermark_opacity)}{$data.watermark_opacity}{/if}" onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0; if(this.value > 100 ) this.value=100; if(this.value < 0) this.value=0;">
            </div>
        </div> *}
        <div class="form-group">
            <label for="data_position" class="col-sm-3 control-label">{$t.contentImagesSizes.watermark_position}</label>
            <div class="col-sm-9">
                <select name="data[watermark_position]" id="data_position"  class="form-control">
                    <option value="0" {if isset($data.watermark_position) && $data.watermark_position == 0}selected{/if}>{$t.contentImagesSizes.watermark_position_tl}</option>
                    <option value="1" {if isset($data.watermark_position) && $data.watermark_position == 1}selected{/if}>{$t.contentImagesSizes.watermark_position_tr}</option>
                    <option value="2" {if isset($data.watermark_position) && $data.watermark_position == 2}selected{/if}>{$t.contentImagesSizes.watermark_position_br}</option>
                    <option value="3" {if isset($data.watermark_position) && $data.watermark_position == 3}selected{/if}>{$t.contentImagesSizes.watermark_position_bl}</option>
                    <option value="4" {if isset($data.watermark_position) && $data.watermark_position == 4}selected{/if}>{$t.contentImagesSizes.watermark_position_c}</option>
                </select>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>