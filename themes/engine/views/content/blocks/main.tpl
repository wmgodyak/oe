<fieldset>
    <legend>Основне</legend>
    {foreach $languages as $lang}
    <div class="form-group">
        <label for="info_{$lang.id}_name" class="col-md-3 control-label">Назва</label>
        <div class="col-md-9">
            <input type="text" class="form-control info-name" name="content_info[{$lang.id}][name]" id="content_info_{$lang.id}_name" required="" placeholder="[a-zA-Zа-яА-Я0-9]+">
        </div>
    </div>

    <div class="form-group">
        <label for="info_{$lang.id}_url" class="col-md-3 control-label">URL:</label>
        <div class="col-md-9">
            <input type="text" class="form-control info-url" name="content_info[{$lang.id}][url]" id="content_info_{$lang.id}_url" required="" placeholder="[a-z0-9]+">
        </div>
    </div>
    {/foreach}
</fieldset>