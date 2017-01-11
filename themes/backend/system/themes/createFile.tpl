<form action="themes/createFile" method="post" id="form">
    <div class="form-group">
        <label for="data_name" class="col-md-3 control-label required">{$t.nav.name}</label>
        <div class="col-md-9">
            <input type="text" class="form-control" name="data[name]" id="data_name" required placeholder="[a-z]+">
            <p class="help-block">Allowed .ini, .tpl, .txt</p>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="create">    
    <input type="hidden" name="path" value="{$path}">
</form>