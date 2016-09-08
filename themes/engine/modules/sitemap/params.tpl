<fieldset>
    <legend>Налаштування Sitemap</legend>
    <div class="form-group">
        <div class="col-md-10">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="content_meta[sitemap_hide]" value="0">
                    <input name="content_meta[sitemap_hide]" id="sitemap_hide" type="checkbox" class="form-control" value="1" {if $app->contentMeta->get($content.id, 'sitemap_hide', true) == 1}checked{/if}>
                    Не показувати в Sitemap
                </label>
            </div>
        </div>
    </div>
</fieldset>