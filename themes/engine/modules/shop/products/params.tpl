<div class="form-group">
    <div class="col-md-12">
        <label for="hit" class="">
            <input type="hidden" name="content_meta[hit]" value="0">
            <input class="switch" type="checkbox" name="content_meta[hit]"  id="hit" value="1" {if $app->contentMeta->get($content.id, 'hit', true)}checked{/if}>
            <span class="l-check">Хіт продаж</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="bestseller" class="">
            <input type="hidden" name="content_meta[bestseller]" value="0">
            <input class="switch" type="checkbox" name="content_meta[bestseller]"  id="bestseller" value="1" {if $app->contentMeta->get($content.id, 'bestseller', true)}checked{/if}>
            <span class="l-check">Супер ціна</span>
        </label>
    </div>
</div>