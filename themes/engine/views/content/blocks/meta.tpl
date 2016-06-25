<fieldset>
    <legend>{$t.content.legend_meta}</legend>

    {foreach $languages as $i=>$lang}
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_h1" class="col-md-2 control-label">{$t.content.h1}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-h1" name="content_info[{$lang.id}][h1]" id="content_info_{$lang.id}_h1" placeholder="{$t.content.h1_i}" value="{$content.info[$lang.id].h1}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_title" class="col-md-2 control-label">{$t.content.title}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-title" name="content_info[{$lang.id}][title]" id="content_info_{$lang.id}_title" placeholder="{$t.content.title_i}" value="{$content.info[$lang.id].title}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_keywords" class="col-md-2 control-label">{$t.content.keywords}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-keywords tags-input" data-role="tagsinput" name="content_info[{$lang.id}][keywords]" id="content_info_{$lang.id}_keywords" placeholder="{$t.content.keywords_i}" value="{$content.info[$lang.id].keywords}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_description" class="col-md-2 control-label">{$t.content.description}</label>
            <div class="col-md-10">
                <textarea class="form-control info-description" name="content_info[{$lang.id}][description]" id="content_info_{$lang.id}_description" placeholder="{$t.content.description_i}">{$content.info[$lang.id].description}</textarea>
            </div>
        </div>
    {/foreach}
    {$events->call('content.meta', array($content))}
</fieldset>