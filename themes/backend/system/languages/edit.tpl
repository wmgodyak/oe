<form action="./languages/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="name" class="col-sm-3 control-label">{t('languages.name')}</label>
        <div class="col-sm-9">
            <input name="data[name]" id="name"  class="form-control" value="{$data.name}" required placeholder="{t('languages.placeholder_name')}">
        </div>
    </div>
    <div class="form-group">
        <label for="code" class="col-sm-3 control-label">{t('languages.code')}</label>
        <div class="col-sm-9">
            <input name="data[code]" id="code"  class="form-control" value="{$data.code}" required placeholder="en">
        </div>
    </div>
    <div class="form-group">
        <label for="hreflang" class="col-sm-3 control-label">{t('languages.hreflang')}</label>
        <div class="col-sm-9">
            <input name="data[hreflang]" id="hreflang"  class="form-control" value="{$data.hreflang}" required placeholder="en-us">
        </div>
    </div>
    <div class="form-group">
        <label for="dir" class="col-sm-3 control-label">{t('languages.dir')}</label>
        <div class="col-sm-9">
            <input name="data[dir]" id="dir"  class="form-control" value="{$data.dir}" required placeholder="en">
        </div>
    </div>
    <div class="form-group">
        <label for="lang" class="col-sm-3 control-label">{t('languages.lang')}</label>
        <div class="col-sm-9">
            <input name="data[lang]" id="lang"  class="form-control" value="{$data.lang}" required placeholder="en">
        </div>
    </div>
    <div class="form-group">
        <label for="is_main" class="col-sm-3 control-label"></label>
        <div class="col-sm-9">

            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[is_main]" value="0">
                    <input {if $data.is_main == 1}checked{/if} type="checkbox" name="data[is_main]" id="is_main" value="1"> {t('languages.is_main')}
                </label>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>