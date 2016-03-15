<form class="form-horizontal" action="contentTypes/process/{$data.id}"  method="post" id="form" data-success="engine.contentTypes.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>Основне</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-3 control-label required">{$t.contentTypes.name}</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-md-3 control-label required">{$t.contentTypes.type}</label>
                    <div class="col-md-9">
                        <input {if $data.isfolder}readonly{/if} type="text" class="form-control" name="data[type]" id="data_type" value="{$data.type}" required placeholder="[a-z0-9]+">
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-4">
            <fieldset>
                <legend>Параметри</legend>
                <div class="form-group">
                    <div class="col-md-8 col-md-offset-4">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="data[settings][ext_url]" value="0">
                                <input {if $data.settings.ext_url == 1}checked{/if} id="data_settings_ext_url" type="checkbox" name="data[settings][ext_url]" value="1"> Наслідувати Url
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="data_settings_parent_id_cnt" style="display:{if $data.settings.ext_url == 1}block{else}none{/if}">
                    <label for="settings_parent_id" class="col-md-4 control-label">Ід. ст. батька</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="data[settings][parent_id]" id="settings_parent_id" value="{$data.settings.parent_id}" placeholder="[0-9]+">
                        <p class="help-block">Введіть ід сторінки від якої наслідувати url</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="settings_parent_id" class="col-md-4 control-label">Розміри зображень</label>
                    <div class="col-md-8">
                        <select name="ct_images_sizes[]" id="contentImagesSizes" class="form-control" multiple>
                            {foreach $imagesSizes as $item}
                                <option {if in_array($item.id, $data.images_sizes)}selected{/if} value="{$item.id}">{$item.size} ({$item.width}x{$item.height})</option>
                            {/foreach}
                        </select>
                        <p class="help-block">Виберіть розміри на які автоматично нарізати зображення</p>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>Налаштування властивостей</legend>
                {if !empty($features)}
                <div class="form-group">
                    <label for="settings_parent_id" class="col-md-4 control-label">Виберіть властивість</label>
                    <div class="col-md-8">
                        <select name="features" id="features" class="form-control">
                            <option value="">Виберіть</option>
                            {foreach $features as $item}
                                <option value="{$item.id}">{$item.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div id="content_features"></div>
                {/if}
            </fieldset>
        </div>
        <div class="col-md-4">

        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Вміст шаблону на сайті</legend>
                <div class="form-group">
                    <div class="col-md-12">
                        <textarea name="template" id="template" style="width: 100%; height: 500px;">{$data.template}</textarea>
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
    <script type="text/template" id="ftList" >
        <table class="table table-bordered">
            <tr>
                <th>#</th>
                <th>Назва</th>
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