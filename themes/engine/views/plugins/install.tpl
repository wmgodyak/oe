<form action="./plugins/install" method="post" id="pluginsInstall" class="form-horizontal">
    <div class="form-group">
        <label for="components" class="col-sm-3 control-label">{$t.plugins.install_label_components}</label>
        <div class="col-sm-9">
            <select name="components[]" id="components" multiple required class="form-control">
                {foreach $components as $c}
                    <option value="{$c.id}">{$c.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.plugins.install_label_place}</label>
        <div class="col-sm-9">
            <input type="text" name="data[place]" required value="{$data.place}" class="form-control" placeholder="{$t.plugins.install_label_place_ph}">
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="c" value="{$plugin}">
    <input type="hidden" name="action" value="install">
</form>