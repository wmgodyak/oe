<form class="form-horizontal" action="contentTypes/process/{if isset($data.id)}{$data.id}{/if}"  method="post" id="form" data-success="engine.contentTypes.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-2 control-label required">{$t.contentTypes.name}</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{if isset($data.name)}{$data.name}{/if}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-md-2 control-label required">{$t.contentTypes.type}</label>
                    <div class="col-md-10">
                        <input {if isset($data.isfolder) && $data.isfolder == 1}readonly{/if} type="text" class="form-control" name="data[type]" id="data_type" value="{if isset($data.type)}{$data.type}{/if}" required placeholder="[a-z0-9]+">
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-4">
            {*<pre>{print_r($data)}</pre>*}
            <fieldset>
                <legend>{$t.common.params}</legend>
                <div class="form-group">
                    <div class="col-md-8 col-md-offset-4">
                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="data[settings][ext_url]" value="0">
                                <input {if isset($data.settings.ext_url) && $data.settings.ext_url == 1}checked{/if} id="data_settings_ext_url" type="checkbox" name="data[settings][ext_url]" value="1"> {$t.features.content_type_ext_url}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="data_settings_parent_id_cnt" style="display:{if isset($data.settings.ext_url) && $data.settings.ext_url == 1}block{else}none{/if}">
                    <label for="settings_parent_id" class="col-md-4 control-label">{$t.features.parent_page_id}</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="data[settings][parent_id]" id="settings_parent_id" value="{if isset($data.settings.parent_id)}{$data.settings.parent_id}{/if}" placeholder="[0-9]+">
                        <p class="help-block">{$t.features.parent_id_help}</p>
                    </div>
                </div>
                {if isset($data.parent_id) && $data.parent_id}
                <div class="form-group">
                    <div class="col-md-8 col-md-offset-4">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="data[settings][modules_ext]" value="0">
                                <input {if $data.settings.modules_ext == 1}checked{/if} id="data_settings_modules_ext" type="checkbox" name="data[settings][modules_ext]" value="1"> {$t.contentTypes.modules_ext}
                            </label>
                        </div>
                    </div>
                </div>
                {/if}
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>{$t.contentTypes.template_src}</legend>
                <div class="form-group">
                    <div class="col-md-12">
                        <textarea name="template" id="template" style="width: 100%; height: 900px;">{if isset($data.template)}{$data.template}{/if}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

     <input type="hidden" name="token" value="{$token}">
     <input type="hidden" name="action" value="{$action}">
     <input type="hidden" id="typesID" name="data[parent_id]" value="{if isset($data.parent_id)}{$data.parent_id}{/if}">
     <input type="hidden" id="subTypesID" name="data[id]" value="{if isset($data.id)}{$data.id}{/if}">
</form>

<link rel="stylesheet" href="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.css">
<script src="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.js"></script>
<script src="{$theme_url}assets/js/vendor/codemirror/mode/css.js"></script>
<script src="{$theme_url}assets/js/vendor/codemirror/mode/php.js"></script>
<script src="{$theme_url}assets/js/vendor/codemirror/mode/htmlmixed.js"></script>
<script src="{$theme_url}assets/js/vendor/codemirror/mode/sql.js"></script>
<script src="{$theme_url}assets/js/vendor/codemirror/mode/javascript.js"></script>
<script>
    var cm = CodeMirror.fromTextArea(document.getElementById('template'), {
        theme: 'neo',
        //                        mode: 'htmlmixed',
        styleActiveLine: true,
        lineNumbers: true,
        lineWrapping: true,
        autoCloseTags: true,
        matchBrackets: true
    });

    cm.on("change", function() {
        cm.save();
        var c = cm.getValue();
        $("textarea#template").html(c);
    });
</script>

<script type="text/template" id="sizesCreate" >
    <form action="./contentImagesSizes/process" method="post" id="formCreateSize" class="form-horizontal">
        <div class="form-group">
            <label for="data_size" class="col-sm-3 control-label">{$t.contentImagesSizes.size}</label>
            <div class="col-sm-9">
                <input name="data[size]" id="data_size"  class="form-control" required>
            </div>
        </div>
        <div class="form-group">
            <label for="data_width" class="col-sm-3 control-label">{$t.contentImagesSizes.width}</label>
            <div class="col-sm-9">
                <input name="data[width]" id="data_width"  class="form-control" required onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0">
            </div>
        </div>
        <div class="form-group">
            <label for="data_height" class="col-sm-3 control-label">{$t.contentImagesSizes.height}</label>
            <div class="col-sm-9">
                <input name="data[height]" id="data_height"  class="form-control" required onchange="this.value = parseInt(this.value); if (this.value == 'NaN') this.value=0">
            </div>
        </div>
        <input type="hidden" name="token" value="{$token}">
        <input type="hidden" name="action" value="{$action}">
    </form>
</script>