<div class="form-group">
    <label for="content_external_id" class="col-sm-2 control-label">{$t.guides.external_id}</label>
    <div class="col-sm-10">
        <input name="content[external_id]" id="content_external_id"  class="form-control" value="{if isset($content.external_id)}{$content.external_id}{/if}" placeholder="[a-z0-9_]+" required>
    </div>
</div>