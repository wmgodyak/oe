<form action="themes/uploadFile" method="post" id="form" enctype="multipart/form-data">
    <div class="form-group">
        <label for="file" class="col-md-3 control-label required">{$t.nav.name}</label>
        <div class="col-md-9">
            <input type="file" class="form-control" name="file[]" multiple id="file" required>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="create">    
    <input type="hidden" name="path" value="{$path}">
</form>