<form class="form-horizontal" action="nav/updateItem/{$data.id}" method="post" id="itemForm">
    <div class="form-group">
        <label for="data_name" class="col-md-3 control-label required">{$t.nav.name}</label>
        <div class="col-md-9">
            <input type="text" class="form-control" name="data[name]" id="data_name" value="{if isset($data.name)}{$data.name}{/if}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>