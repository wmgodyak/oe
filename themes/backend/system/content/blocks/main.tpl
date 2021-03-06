<fieldset>
    <legend>{$t.common.legend_main}</legend>
    <div class="fieldset-wrapper">
        {if $languages->total() > 1}
        <div class="form-group">
            <label class="col-md-2 control-label">{$t.common.lang}</label>
            <div class="btn-group switch-languages col-md-6" id="switchLanguages" role="group">
                {foreach $languages->get() as $i=>$lang}
                    {if $lang.is_main == 1}{assign var='mainLang' value=$lang }{/if}
                    <button type="button" class="btn {if $i == 0}btn-default active{/if}" data-code="{$lang.code}">{$lang.code}</button>
                {/foreach}
                {$events->call('content.main.languages.switcher', $mainLang)}
            </div>
        </div>
        {/if}
        {foreach $languages->get() as $i=>$lang}
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_name" class="col-md-2 control-label">{$t.content.name}</label>
            <div class="col-md-10">
                <input type="text" class="form-control info-name lang-{$lang.code}" name="content_info[{$lang.id}][name]" id="content_info_{$lang.id}_name" required="" placeholder="[a-zA-Zа-яА-Я0-9]+" value="{if isset($content.info[$lang.id].name)}{htmlspecialchars($content.info[$lang.id].name)}{/if}" data-lang="{$lang.code}">
            </div>
        </div>

        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="info_{$lang.id}_url" class="col-md-2 control-label">{$t.content.url}</label>
            <div class="col-md-10">
                <input type="text" data-parent-url="{if isset($content.parent_url[$lang.id])}{$content.parent_url[$lang.id]}{/if}" class="form-control info-url lang-{$lang.code}" name="content_info[{$lang.id}][url]" id="content_info_{$lang.id}_url" placeholder="[a-z0-9]+ max:160" value="{if isset($content.info[$lang.id].url)}{$content.info[$lang.id].url}{/if}"  {if $settings->get('home_id') != $content.id}required{/if}>
            </div>
        </div>
        {/foreach}
    </div>
    {$events->call('content.main', $content)}
</fieldset>
