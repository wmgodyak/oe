<form action="features/process/{$data.id}" method="post" id="form" class="form-horizontal" >
    <div class="row">
        <div class="col-md-8">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                {foreach $languages as $lang}
                    <div class="form-group">
                        <label for="name_{$lang.id}" class="col-sm-3 control-label">{$t.features.name} ({$lang.code})</label>
                        <div class="col-sm-9">
                            <input name="info[{$lang.id}][name]"  placeholder="{$lang.name}" required id="info_{$lang.id}"  class="form-control" value="{$data.info[$lang.id].name}">
                        </div>
                    </div>
                {/foreach}
                <div class="form-group">
                    <label for="data_code" class="col-sm-3 control-label">{$t.features.code}</label>
                    <div class="col-sm-9">
                        <input name="data[code]" id="data_code"  class="form-control" value="{$data.code}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-md-3 control-label">{$t.features.type}</label>
                    <div class="col-md-9">
                        <select name="data[type]" id="data_type" class="form-control">
                            {foreach $data.types as $i=>$item}
                                {assign var="item_name" value="type_$item"}
                                <option {if $data.type == $item}selected{/if} value="{$item}">{$t.features[$item_name]}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-4">
            <fieldset>
                <legend>{$t.common.params}</legend>
                <div class="form-group">
                    <label for="data_status" class="col-md-3 control-label">{$t.features.status}</label>
                    <div class="col-md-9">
                        <select name="data[status]" id="data_status" class="form-control">
                            {foreach $data.statuses as $i=>$item}
                                {if $i > 0}
                                <option {if $data.status == $item}selected{/if} value="{$item}">{$item}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-9 col-md-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="data[required]" value="0">
                                <input {if $data.required == 1}checked{/if} type="checkbox" name="data[required]" value="1"> {$t.features.required}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group fg-multiple" style="display: none">
                    <div class="col-md-9 col-md-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="hidden" name="data[multiple]" value="0">
                                <input {if $data.multiple == 1}checked{/if} type="checkbox" name="data[multiple]" id="data_multiple" value="1"> {$t.features.multiple}
                            </label>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend style="text-align: left">{$t.features.show_on} <a href="javascript:;" data-id="{$data.id}" class="b-features-select-ct"><i class="fa fa-list"></i></a></legend>
                <div id="content_types"></div>
            </fieldset>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
</form>

<script>{if isset($selected_content)}var selected_content = {json_encode($selected_content)}{/if}</script>

{literal}
    <script type="text/template" id="ctList" >
        <table class="table table-bordered">
            <tr>
                <th>Тип</th>
                <th>Підтип</th>
                <th>Сторінка</th>
                <th>Видалити</th>
            </tr>
            <% for(var i=0;i < items.length; i++) { %>
            <tr id="f-sc-<%- items[i].id %>">
                <td><%- items[i].type %></td>
                <td><%- items[i].subtype %></td>
                <td><%- items[i].content %></td>
                <td><a class="b-features-delete-ct" data-id="<%- items[i].id %>" title="Видалити" href="javascript:;"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% } %>
        </table>
    </script>
{/literal}
