<fieldset>
    <div class="form-group">
        <div class="col-md-12">
            <label for="en_short_desc" class="">
            <input type="hidden" name="content_meta[en_short_desc]" value="0">
            <input class="switch" type="checkbox" name="content_meta[en_short_desc]"  id="en_short_desc" value="1" {if $app->contentMeta->get($content.id, 'en_short_desc', true)}checked{/if}>
                Вкл. короткі характеристики. Заповніть блок intro
            </label>
        </div>
    </div>
</fieldset>