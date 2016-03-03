<fieldset>
    <legend>Мета дані</legend>

    {foreach $languages as $i=>$lang}
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_h1" class="col-md-3 control-label">Заголовок:</label>
            <div class="col-md-9">
                <input type="text" class="form-control info-h1" name="content_info[{$lang.id}][h1]" id="content_info_{$lang.id}_h1" placeholder="Наслідувати від назви" value="{$content.info[$lang.id].h1}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_title" class="col-md-3 control-label">Title:</label>
            <div class="col-md-9">
                <input type="text" class="form-control info-title" name="content_info[{$lang.id}][title]" id="content_info_{$lang.id}_title" placeholder="Текст макс 250 символів. Оптимально 160." value="{$content.info[$lang.id].title}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_keywords" class="col-md-3 control-label">Keywords:</label>
            <div class="col-md-9">
                <input type="text" class="form-control info-keywords" name="content_info[{$lang.id}][keywords]" id="content_info_{$lang.id}_keywords" placeholder="Текст макс 250 символів через кому. Оптимально 160." value="{$content.info[$lang.id].keywords}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_description" class="col-md-3 control-label">Description</label>
            <div class="col-md-9">
                <textarea class="form-control info-description" name="content_info[{$lang.id}][description]" id="content_info_{$lang.id}_description" placeholder="Текст макс 250 символів. Оптимально 160.">{$content.info[$lang.id].description}</textarea>
            </div>
        </div>
    {/foreach}
</fieldset>