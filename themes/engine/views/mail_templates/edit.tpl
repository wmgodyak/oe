<form action="./mailTemplates/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.mailTemplates.name}</label>
        <div class="col-sm-9">
            <input name="data[name]" id="data_name"  class="form-control" value="{$data.name}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="data_code" class="col-sm-3 control-label">{$t.mailTemplates.code}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="data_code"  class="form-control" value="{$data.code}" required>
        </div>
    </div>

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
            <label for="subject_{$lang.id}" class="col-sm-3 control-label">{$t.mailTemplates.subject}</label>
            <div class="col-sm-9">
                <input name="info[{$lang.id}][subject]"  placeholder="{$lang.name}" required id="subject_{$lang.id}"  class="form-control" value="{$data.info[$lang.id].subject}" >
            </div>
        </div>
        <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
            <label for="body_{$lang.id}" class="col-sm-3 control-label">{$t.mailTemplates.body}</label>
            <div class="col-sm-9">
                <textarea style="height: 500px;" name="info[{$lang.id}][body]"  placeholder="{$lang.name}" required id="info_body_{$lang.id}"  class="form-control ckeditor" >{$data.info[$lang.id].body}</textarea>
            </div>
        </div>
    {/foreach}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>