<form class="form-horizontal" action="nav/updateItem/{$id}" method="post" id="itemForm">
    <div class="form-group">
        <label for="data_url" class="col-md-3 control-label required">URL:</label>
        <div class="col-md-9">
            <input type="text" class="form-control" name="data[url]" id="data_url" value="{if isset($data.url)}{$data.url}{/if}" placeholder="[a-zA-Z0-9]+">
        </div>
    </div>
    <div class="form-group">
        <label for="data_css_class" class="col-md-3 control-label required">CSS Class:</label>
        <div class="col-md-9">
            <input type="text" class="form-control" name="data[css_class]" id="data_css_class" value="{if isset($data.css_class)}{$data.css_class}{/if}" placeholder="[a-zA-Z0-9]+">
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[display_children]" value="0">
                    <input {if $data.display_children == 1}checked{/if} type="checkbox" name="data[display_children]" id="data_display_children" value="1"> Показувати дочірні елементи
                </label>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div class="checkbox">
                <label>
                    <input type="hidden" name="data[published]" value="0">
                    <input {if $data.published == 1}checked{/if} type="checkbox" name="data[published]" id="data_published" value="1"> Опубліковано
                </label>
            </div>
        </div>
    </div>
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="info_name" class="col-md-3 control-label required">Name ({$lang.code})</label>
            <div class="col-md-9">
                <input type="text" class="form-control" name="info[{$lang.id}][name]" id="info_name" value="{if isset($info[$lang.id].name)}{$info[$lang.id].name}{/if}" placeholder="[a-zA-Z0-9]+">
            </div>
        </div>
        <div class="form-group">
            <label for="info_title" class="col-md-3 control-label required">Title ({$lang.code})</label>
            <div class="col-md-9">
                <input type="text" class="form-control" name="info[{$lang.id}][title]" id="info_title" value="{if isset($info[$lang.id].title)}{$info[$lang.id].title}{/if}" placeholder="[a-zA-Z0-9]+">
            </div>
        </div>
    {/foreach}
    <input type="hidden" name="token" value="{$token}">
</form>