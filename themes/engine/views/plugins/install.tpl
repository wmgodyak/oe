<form action="./plugins/install" method="post" id="pluginsInstall">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.plugins.install_label_place}</label>
        <div class="col-sm-9">
            <input type="text" name="data[place]" required value="{$data.place}">
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="c" value="{$component}">
    <input type="hidden" name="action" value="install">
</form>