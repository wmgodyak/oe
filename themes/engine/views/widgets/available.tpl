<fieldset>
    <legend>Доступні віджети</legend>

    <div class="form-group">
        <label for="av_select_widget" class="col-md-2 control-label">Виберіть</label>
        <div class="col-md-10">
            <select id="inst_available_widgets">
                <option value=""> - Виберіть -</option>
                {foreach $available_widgets as $id=>$class}
                    <option value="{$id}">{$class->getName()}</option>
                {/foreach}
            </select>
            <input type="hidden" id="area" value="{$area}">
        </div>
    </div>
</fieldset>