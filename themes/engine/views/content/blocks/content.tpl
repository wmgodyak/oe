<fieldset>
    <legend>Опис</legend>
    {foreach $languages as $lang}
        <div class="form-group">
            <div class="col-md-12">
                <textarea class="form-control info-description" name="content_info[{$lang.id}][description]" id="content_info_{$lang.id}_description" required="" placeholder="[a-zA-Zа-яА-Я0-9]+"></textarea>
            </div>
        </div>
    {/foreach}
</fieldset>