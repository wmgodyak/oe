<form class="form-horizontal" action="contentTypes/process/{$data.id}"  method="post" id="form" data-success="engine.contentTypes.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-2 control-label required">{$t.contentTypes.name}</label>
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-md-2 control-label required">{$t.contentTypes.type}</label>
                    <div class="col-md-10">
                        <input {if $data.isfolder}readonly{/if} type="text" class="form-control" name="data[type]" id="data_type" value="{$data.type}" required placeholder="[a-z0-9]+">
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
                                <input {if $data.settings.ext_url == 1}checked{/if} id="data_settings_ext_url" type="checkbox" name="data[settings][ext_url]" value="1"> {$t.features.content_type_ext_url}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="data_settings_parent_id_cnt" style="display:{if $data.settings.ext_url == 1}block{else}none{/if}">
                    <label for="settings_parent_id" class="col-md-4 control-label">{$t.features.parent_page_id}</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="data[settings][parent_id]" id="settings_parent_id" value="{$data.settings.parent_id}" placeholder="[0-9]+">
                        <p class="help-block">{$t.features.parent_id_help}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="settings_parent_id" class="col-md-4 control-label">
                        {$t.features.images_sizes}
                        <a href="javascript:;" class="ct-create-images-size" title="{$t.common.create}"><i class="fa fa-plus-circle"></i></a>
                    </label>
                    <div class="col-md-8">
                        <select name="ct_images_sizes[]" id="contentImagesSizes" class="form-control" multiple>
                            {foreach $imagesSizes as $item}
                                <option {if in_array($item.id, $data.images_sizes)}selected{/if} value="{$item.id}">{$item.size} ({$item.width}x{$item.height})</option>
                            {/foreach}
                        </select>
                        <p class="help-block">{$t.features.images_sizes_help}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="settings_parent_id" class="col-md-4 control-label">
                        {$t.contentTypes.modules}
                    </label>
                    <div class="col-md-8">
                        <select name="data[settings][modules][]" id="settingsModules" class="form-control" multiple>
                            {foreach $modules as $module=>$a}
                                <optgroup label="{$module}">
                                    {foreach $a as $k=>$ac}
                                    <option {if $data.settings.modules && in_array($ac, $data.settings.modules)}selected{/if} value="{$ac}">{$ac}</option>
                                    {/foreach}
                                </optgroup>
                            {/foreach}
                        </select>
                        <p class="help-block">{$t.contentTypes.modules_i}</p>
                    </div>
                </div>
                {if $data.parent_id}
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
    {if $action == 'edit'}
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>{$t.features.label_settings}</legend>
                <div class="row">

                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="settings_features_allowed_types" class="col-md-3 control-label">{$t.contentTypes.features_allowed}</label>
                            <div class="col-md-9">
                                <select name="data[settings][features][allowed_types][]" id="settings_features_allowed_types" multiple class="form-control" data-placeholder="{$t.common.all}">
                                    <option value="">{$t.common.select}</option>
                                    {foreach $features_types as $k=>$type}
                                        <option {if isset($data.settings.features.allowed_types) && in_array($type, $data.settings.features.allowed_types)}selected{/if} value="{$type}">{$type}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="data_settings_features_disable_values" class="col-md-3 control-label">{$t.contentTypes.features_disable_values}</label>
                            <div class="col-md-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="hidden" name="data[settings][features][disable_values]" value="0">
                                        <input id="data_settings_features_disable_values" {if isset($data.settings.features.disable_values) && $data.settings.features.disable_values == 1}checked{/if} type="checkbox" name="data[settings][features][disable_values]" value="1"> Так
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="settings_features_ex_types_id" class="col-md-3 control-label">{$t.contentTypes.features_ex_type}</label>
                            <div class="col-md-9">
                                <select name="data[settings][features][ex_types_id]" id="settings_features_ex_types_id" class="form-control">
                                    <option value="">{$t.common.select}</option>
                                    {foreach $content_types as $type}
                                        <option {if isset($data.settings.features.ex_types_id) && $data.settings.features.ex_types_id == $type.id }selected{/if} value="{$type.id}">{$type.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="form-group">
                            <label for="settings_parent_id" class="col-md-4 control-label">{$t.features.select_item}</label>
                            <div class="col-md-6">
                                <select name="features" id="features" class="form-control">
                                    <option value="">{$t.common.select}</option>
                                    {foreach $features as $item}
                                        <option value="{$item.id}">{$item.name}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <label class="col-md-2 control-label" style="text-align: left"><a data-id="{$data.id}" href="./features/create" target="_blank" class="ct-add-features" title=" {$t.common.create}"><i class="fa fa-plus-circle"></i></a></label>
                        </div>
                        <div id="content_features"></div>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    {/if}
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>{$t.contentTypes.template_src}</legend>
                <div class="form-group">
                    <div class="col-md-12">
                        <textarea name="template" id="template" style="width: 100%; height: 900px;">{$data.template}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

     <input type="hidden" name="token" value="{$token}">
     <input type="hidden" name="action" value="{$action}">
     <input type="hidden" id="typesID" name="data[parent_id]" value="{$data.parent_id}">
     <input type="hidden" id="subTypesID" name="data[id]" value="{$data.id}">
</form>
<script>var selected_features = {json_encode($data.features)}</script>

{literal}
    <script type="text/template" id="modules" >
        <table class="table table-bordered">
            <tr>
                <th>#</th>
                <th>Модуль</th>
                <th>Тип</th>
                <th>Видалити</th>
            </tr>
            <% for(var i=0;i < items.length; i++) { %>
            <tr id="cf-sf-<%- items[i].id %>">
                <td><%- items[i].id %></td>
                <td><%- items[i].name %></td>
                <td><%- items[i].type %></td>
                <td><a class="b-ct-delete-features" data-id="<%- items[i].id %>" title="Видалити" href="javascript:;"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% } %>
        </table>
    </script>
{/literal}

{literal}
    <script type="text/template" id="ftList" >
        <table class="table table-bordered">
            <tr>
                <th>#</th>
                <th>Назва</th>
                <th>Тип</th>
                <th style="width: 60px;">Вид.</th>
            </tr>
            <% for(var i=0;i < items.length; i++) { %>
            <tr id="cf-sf-<%- items[i].id %>">
                <td><%- items[i].id %></td>
                <td><%- items[i].name %></td>
                <td><%- items[i].type %></td>
                <td><a class="b-ct-delete-features" data-id="<%- items[i].id %>" title="Видалити" href="javascript:;"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% } %>
        </table>
    </script>
{/literal}


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