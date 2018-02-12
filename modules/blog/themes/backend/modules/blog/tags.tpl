<fieldset>
    <legend>Мітки</legend>
    {foreach $languages->get() as $lang}
        <div class="form-group">
            <label for="content_published" class="col-md-3 control-label">{$lang.name}</label>
            <div class="col-md-9">
                <input data-role="tagsinput" type="text" name="tags[{$lang.id}]" id="tags_{$lang.id}" value="{if isset($posts_tags[$lang.id])}{implode(',', $posts_tags[$lang.id])}{/if}" class="tags-input form-control">
            </div>
        </div>
    {/foreach}
</fieldset>