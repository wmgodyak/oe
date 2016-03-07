<fieldset>
    <legend>Основне</legend>
    {if count($languages) > 1}
    <div class="form-group">
        <label class="col-md-3 control-label">Мова:</label>
        <div class="btn-group col-md-9" id="switchLanguages" role="group">
            {foreach $languages as $i=>$lang}
                <button type="button" class="btn {if $i == 0}btn-primary{/if}" data-code="{$lang.code}">{$lang.code}</button>
            {/foreach}
        </div>
    </div>
    {/if}
    {foreach $languages as $i=>$lang}
    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
        <label for="info_{$lang.id}_name" class="col-md-3 control-label">Назва</label>
        <div class="col-md-9">
            <input type="text" class="form-control info-name" name="content_info[{$lang.id}][name]" id="content_info_{$lang.id}_name" required="" placeholder="[a-zA-Zа-яА-Я0-9]+" value="{$content.info[$lang.id].name}" data-lang="{$lang.code}">
        </div>
    </div>

    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
        <label for="info_{$lang.id}_url" class="col-md-3 control-label">URL:</label>
        <div class="col-md-9">
            <input type="text" class="form-control info-url" name="content_info[{$lang.id}][url]" id="content_info_{$lang.id}_url" placeholder="[a-z0-9]+ max:160" value="{$content.info[$lang.id].url}">
        </div>
    </div>
    {/foreach}
</fieldset>