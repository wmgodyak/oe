<fieldset>
    <legend>{$t.common.legend_main}</legend>
    {if count($languages) > 1}
    <div class="form-group">
        <label class="col-md-2 control-label">{$t.common.lang}</label>
        <div class="btn-group col-md-10" id="switchLanguages" role="group">
            {foreach $languages as $i=>$lang}
                <button type="button" class="btn {if $i == 0}btn-primary{/if}" data-code="{$lang.code}">{$lang.code}</button>
            {/foreach}
        </div>
    </div>
    {/if}
    {foreach $languages as $i=>$lang}
    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
        <label for="info_{$lang.id}_name" class="col-md-2 control-label">{$t.content.name}</label>
        <div class="col-md-10">
            <input type="text" class="form-control info-name" name="content_info[{$lang.id}][name]" id="content_info_{$lang.id}_name" required="" placeholder="[a-zA-Zа-яА-Я0-9]+" value="{$content.info[$lang.id].name}" data-lang="{$lang.code}">
        </div>
    </div>

    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
        <label for="info_{$lang.id}_url" class="col-md-2 control-label">{$t.content.url}</label>
        <div class="col-md-10">
            <input type="text" data-parent-url="{$content.parent_url[$lang.id]}" class="form-control info-url" name="content_info[{$lang.id}][url]" id="content_info_{$lang.id}_url" placeholder="[a-z0-9]+ max:160" value="{$content.info[$lang.id].url}" required>
        </div>
    </div>
    {/foreach}
    {if isset($plugins.main)}{implode("\r\n", $plugins.main)}{/if}
</fieldset>