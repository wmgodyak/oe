<fieldset>
    <legend>Мета дані</legend>

    {foreach $languages as $lang}
        <div class="form-group">
            <label for="info_{$lang.id}_title" class="col-md-3 control-label">Title:</label>
            <div class="col-md-9">
                <input type="text" class="form-control info-title" name="content_info[{$lang.id}][title]" id="content_info_{$lang.id}_title" required="" placeholder="[a-z0-9]+">
            </div>
        </div>

        <div class="form-group">
            <label for="info_{$lang.id}_keywords" class="col-md-3 control-label">Keywords:</label>
            <div class="col-md-9">
                <input type="text" class="form-control info-keywords" name="content_info[{$lang.id}][keywords]" id="content_info_{$lang.id}_keywords" required="" placeholder="[a-z0-9]+">
            </div>
        </div>

        <div class="form-group">
            <label for="info_{$lang.id}_description" class="col-md-3 control-label">Description</label>
            <div class="col-md-9">
                <textarea class="form-control info-description" name="content_info[{$lang.id}][description]" id="content_info_{$lang.id}_description" required="" placeholder="[a-zA-Zа-яА-Я0-9]+"></textarea>
            </div>
        </div>
    {/foreach}
</fieldset>