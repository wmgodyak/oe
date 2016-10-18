{function name=renderSelect}
    {foreach $items as $item}
        {assign var='name' value="`$parent` / `$item.name`" }
        <option value="{$item.id}">{$name}</option>
        {if $item.isfolder}
            {call renderSelect items=$mNav->tree($type.id, $item.id) parent=$name}
        {/if}
    {/foreach}
{/function}
<form class="form-horizontal" action="nav/process/{$data.id}"  method="post" id="form" data-id="{$data.id}" data-success="engine.nav.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-3 control-label required">{$t.nav.name}</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{if isset($data.name)}{$data.name}{/if}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_code" class="col-md-3 control-label required">{$t.nav.code}</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="data[code]" id="data_code" value="{if isset($data.code)}{$data.code}{/if}" required placeholder="[a-z]+">
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>{$t.nav.items}</legend>
                <div class="form-group">
                    <div class="col-md-12">
                        <select id="selItems" class="form-control" data-nav="{$data.id}">
                            <option value="">{$t.common.select}</option>
                            {foreach $mNav->buildTree() as $type}
                                <optgroup label="{$type.name}">
                                    {call renderSelect items=$mNav->tree($type.id, 0)}
                                </optgroup>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" id="navItems"></div>
                </div>
            </fieldset>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="data[id]" value="{$data.id}">
    <input type="hidden" name="pos" id="pos" value="">
</form>

{*<script>var selected_items = {json_encode($data.items)}</script>*}

{literal}
    <script type="text/template" id="nav_items">
        <ol class="dd-list">
            <% _.each(items, function (item) { %>
            <li class="dd-item dd3-item" data-id="<%- item.id %>">
                <div class="dd-handle dd3-handle">Drag</div>
                <div class="dd3-content">
                    <%- item.name %>
                    <a class="b-nav-item-edit dd-remove" style="right: 25px" data-id="<%- item.id %>" href="javascript:void(0)" title="Редагувати"><i class="fa fa-pencil"></i></a>
                    <a class="b-nav-item-delete dd-remove"  data-id="<%- item.id %>" href="javascript:void(0)" title="Видалити"><i class="fa fa-trash"></i></a>
                </div>
                <% if (item.isfolder) { %>
                    <%= templateFn({ items: item.items, templateFn: templateFn }) %>
                <% } %>
            </li>
            <% }); %>
        </ol>
    </script>
    <script type="text/template" id="nav_items__1">
        <div class="dd" id="nestable3">
            <ol class="dd-list">
                <li class="dd-item dd3-item" data-id="13">
                    <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 13</div>
                </li>
                <li class="dd-item dd3-item" data-id="14">
                    <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 14</div>
                </li>
                <li class="dd-item dd3-item" data-id="15">
                    <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 15</div>
                    <ol class="dd-list">
                        <li class="dd-item dd3-item" data-id="16">
                            <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 16</div>
                        </li>
                        <li class="dd-item dd3-item" data-id="17">
                            <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 17</div>
                        </li>
                        <li class="dd-item dd3-item" data-id="18">
                            <div class="dd-handle dd3-handle">Drag</div><div class="dd3-content">Item 18</div>
                        </li>
                    </ol>
                </li>
            </ol>
        </div>
    </script>
    <script type="text/template" id="nItems" >
        <table class="table table-bordered" id="tblItems">
            <thead>
                <tr>
                    <th style="width: 20px;"><i class="fa fa-list"></i></th>
                    <th style="width: 20px;">#</th>
                    <th>Назва</th>
                    <th style="width: 20px;">Вид.</th>
                </tr>
            </thead>
            <tbody>
                <% for(var i=0;i < items.length; i++) { %>
                <tr id="nav-item-<%- items[i].id %>">
                    <td class="sort" style="cursor: move;"><i class="fa fa-list"></i></td>
                    <td><%- items[i].content_id %></td>
                    <td><%- items[i].name %></td>
                    <td style="text-align: center"><a class="b-nav-item-delete" data-id="<%- items[i].id %>" title="Видалити" href="javascript:;"><i class="fa fa-remove"></i></a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </script>
{/literal}