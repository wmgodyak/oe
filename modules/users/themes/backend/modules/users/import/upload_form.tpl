<form action="module/run/users/import/upload" method="post" enctype="multipart/form-data" id="usersImportUploadForm">
    <div class="form-group">
        <label for="file" class="col-md-3 control-label">Виберіть файл</label>
        <div class="col-md-9">
            <input type="file" name="file" required class="form-control">
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
</form>