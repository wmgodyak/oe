<fieldset>
    <legend>{$t.content.legend_description}</legend>
    {foreach $languages as $i=>$lang}
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <div class="col-md-12">
                <textarea class="form-control info-content ckeditor  lang-{$lang.code}" name="content_info[{$lang.id}][content]" id="content_info_{$lang.code}_content" placeholder="[a-zA-Zа-яА-Я0-9]+">{$content.info[$lang.id].content}</textarea>
            </div>
        </div>
    {/foreach}
    {$events->call('content.content', $content)}
</fieldset>