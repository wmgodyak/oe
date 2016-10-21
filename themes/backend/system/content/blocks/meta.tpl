<fieldset>
    <legend>{$t.content.legend_meta}</legend>

    {foreach $languages as $i=>$lang}
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_h1" class="col-md-2 control-label">{$t.content.h1}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-h1 lang-{$lang.code}" name="content_info[{$lang.id}][h1]" id="content_info_{$lang.id}_h1" placeholder="{$t.content.h1_i}" value="{if isset($content.info[$lang.id].h1)}{htmlspecialchars($content.info[$lang.id].h1)}{/if}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_title" class="col-md-2 control-label">{$t.content.title}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-title lang-{$lang.code}" name="content_info[{$lang.id}][title]" id="content_info_{$lang.id}_title" placeholder="{$t.content.title_i}" value="{if isset($content.info[$lang.id].title)}{htmlspecialchars($content.info[$lang.id].title)}{/if}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_keywords" class="col-md-2 control-label">{$t.content.keywords}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-keywords tags-input lang-{$lang.code}" data-role="tagsinput" name="content_info[{$lang.id}][keywords]" id="content_info_{$lang.id}_keywords" placeholder="{$t.content.keywords_i}" value="{if isset($content.info[$lang.id].keywords)}{htmlspecialchars($content.info[$lang.id].keywords)}{/if}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_description" class="col-md-2 control-label">{$t.content.description}</label>
            <div class="col-md-10">
                <textarea class="form-control info-description lang-{$lang.code}" name="content_info[{$lang.id}][description]" id="content_info_{$lang.id}_description" placeholder="{$t.content.description_i}">{if isset($content.info[$lang.id].description)}{htmlspecialchars($content.info[$lang.id].description)}{/if}</textarea>
            </div>
        </div>
    {/foreach}
    {$events->call('content.meta', $content)}
</fieldset>