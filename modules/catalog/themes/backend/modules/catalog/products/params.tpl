<div class="form-group">
    <div class="col-md-12">
        <label for="hit" class="">
            <input type="hidden" name="content_meta[hit]" value="0">
            <input class="switch" type="checkbox" name="content_meta[hit]"  id="hit" value="1" {if $app->contentMeta->get($content.id, 'hit', true)}checked{/if}>
            <span class="l-check">{$t.catalog.products.params.hit}</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="bestseller" class="">
            <input type="hidden" name="content_meta[bestseller]" value="0">
            <input class="switch" type="checkbox" name="content_meta[bestseller]"  id="bestseller" value="1" {if $app->contentMeta->get($content.id, 'bestseller', true)}checked{/if}>
            <span class="l-check">{$t.catalog.products.params.bestseller}</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="new" class="">
            <input type="hidden" name="content_meta[new]" value="0">
            <input class="switch" type="checkbox" name="content_meta[new]"  id="new" value="1" {if $app->contentMeta->get($content.id, 'new', true)}checked{/if}>
            <span class="l-check">{$t.catalog.products.params.newest}</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="new" class="">
            <input type="hidden" name="content_meta[discontinued]" value="0">
            <input class="switch" type="checkbox" name="content_meta[discontinued]"  id="discontinued" value="1" {if $app->contentMeta->get($content.id, 'discontinued', true)}checked{/if}>
            <span class="l-check">{$t.catalog.products.params.out_of_prod}</span>
        </label>
    </div>
</div>