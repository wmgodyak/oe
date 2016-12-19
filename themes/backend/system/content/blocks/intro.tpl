<fieldset>
    <legend>{$t.content.legend_intro}</legend>
    <div class="fieldset-wrapper">
        {foreach $languages as $i=>$lang}
            <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
                <div class="col-md-12">
                    <textarea class="form-control info-content editor" name="content_info[{$lang.id}][intro]" id="content_info_{$lang.code}_intro" placeholder="[a-zA-Zа-яА-Я0-9]+">{$content.info[$lang.id].intro}</textarea>
                </div>
            </div>
        {/foreach}
    </div>
    {$events->call('content.intro', $content)}
</fieldset>