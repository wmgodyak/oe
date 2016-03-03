<form action="./plugins/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="components" class="col-sm-3 control-label">{$t.plugins.install_label_components}</label>
        <div class="col-sm-9">
            <select name="components[]" id="components" multiple required class="form-control">
                {foreach $components as $c}
                    <option {if in_array($c.id, $data.components)}selected{/if} value="{$c.id}">{$c.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_place" class="col-sm-3 control-label">{$t.plugins.install_label_place}</label>
        <div class="col-sm-9">
            <select name="data[place]" id="data_place" required class="form-control">
                {foreach $place as $k=>$c}
                    <option {if $data.place == $c}selected{/if} value="{$c}">{$c}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="update">
</form>