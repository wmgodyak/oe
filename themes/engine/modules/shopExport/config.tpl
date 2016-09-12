<div id="tabs_adapters">
    <ul>
        {foreach $adapters as $adapter}
            <li><a href="modules#{$adapter}">{$adapter}</a></li>
        {/foreach}
    </ul>
    {foreach $adapters as $adapter}
        <div id="{$adapter}">
            <div class="form-group">
                <label for="adapter_{$adapter}_group_id" class="col-sm-3 control-label">Група ціни</label>
                <div class="col-sm-9">
                    <select name="adapter[{$adapter}][group_id]" id="adapter_group_id"  class="form-control" required>
                        {foreach $users_group as $group}
                            <option value="{$group.id}">{$group.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_currency_id" class="col-sm-3 control-label">Валюта</label>
                <div class="col-sm-9">
                    <select name="adapter[{$adapter}][currency_id]" id="adapter_currency_id"  class="form-control">
                        {foreach $currency as $c}
                            <option value="{$c.id}">{$c.code}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_languages_id" class="col-sm-3 control-label">Мова</label>
                <div class="col-sm-9">
                    <select name="adapter[{$adapter}][languages_id]" id="adapter_languages_id"  class="form-control">
                        {foreach $langs as $c}
                            <option value="{$c.id}">{$c.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_markup" class="col-sm-3 control-label">Націнка (%)</label>
                <div class="col-sm-9">
                    <input name="adapter[{$adapter}][markup]" id="adapter_markup"  class="form-control" value="">
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_categories" class="col-sm-3 control-label">Групи товарів</label>
                <div class="col-sm-9">
                    {*<input name="adapter[{$adapter}][markup]" id="adapter_markup"  class="form-control" value="">*}
                    <div class="form-control-static" id="#adapter_{$adapter}_categories" style="text-align: left;">
                        всі
                        <a href="javascript:;" title="Додати" class="se-select-cat" data-adapter="{$adapter}"><i class="fa fa-plus-circle"></i></a>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_file" class="col-sm-3 control-label">Назва файлу експорту</label>
                <div class="col-sm-9" style="text-align: left">
                    <input name="adapter[{$adapter}][file]" id="adapter_file"  class="form-control" value="{$adapter}.xml">
                    <p>Шлях: /tmp/{$adapter}.xml</p>
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="adapter[{$adapter}][track]" value="0">
                            <input type="checkbox" id="adapter_{$adapter}_track" data-adapter="{$adapter}" class="toggle-analytics-config" name="adapter[{$adapter}][track]" value="1">
                            Відслідковувати
                        </label>
                    </div>
                </div>
            </div>
            <div id="analitycs_{$adapter}_config" style="display: none;">

                <div class="form-group">
                    <label for="adapter_{$adapter}_utm_source" class="col-sm-3 control-label">utm_source</label>
                    <div class="col-sm-9" style="text-align: left">
                        <input name="adapter[{$adapter}][utm_source]" id="adapter_{$adapter}_utm_source"  class="form-control" value="{$adapter}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="adapter_{$adapter}_utm_medium" class="col-sm-3 control-label">utm_medium</label>
                    <div class="col-sm-9" style="text-align: left">
                        <input name="adapter[{$adapter}][utm_medium]" id="adapter_{$adapter}_utm_medium"  class="form-control" value="" placeholder="cpc or cpp">
                    </div>
                </div>
                <div class="form-group">
                    <label for="adapter_{$adapter}_utm_campaign" class="col-sm-3 control-label">utm_campaign</label>
                    <div class="col-sm-9" style="text-align: left">
                        <input name="adapter[{$adapter}][utm_campaign]" id="adapter_{$adapter}_utm_campaign"  class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="adapter_{$adapter}_utm_content" class="col-sm-3 control-label">utm_content</label>
                    <div class="col-sm-9" style="text-align: left">
                        <input name="adapter[{$adapter}][utm_content]" id="adapter_{$adapter}_utm_content"  class="form-control" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="adapter_{$adapter}_utm_term" class="col-sm-3 control-label">utm_term</label>
                    <div class="col-sm-9" style="text-align: left">
                        <input name="adapter[{$adapter}][utm_term]" id="adapter_{$adapter}_utm_term"  class="form-control" value="">
                    </div>
                </div>
                <p style="text-align: left">Детальніше про відслідковування кампаній тут: <br> <a href="https://support.google.com/analytics/answer/1033863?hl=ru">https://support.google.com/analytics/answer/1033863?hl=ru</a></p>
            </div>
        </div>
    {/foreach}
</div>

{literal}
    <script>
        $(document).ready(function(){
            $('#tabs_adapters').tabs();
            $('.toggle-analytics-config').change(function(){
               var adapter = $(this).data('adapter'); var cfg = $('#analitycs_'+adapter+'_config');
                if($(this).is(':checked')){
                    cfg.show();
                } else {
                    cfg.hide();
                }
            });
            $(document).on('click', ".se-select-cat", function(){
               alert('in progress');
            });
        });
    </script>
{/literal}