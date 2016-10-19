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
                    <div class="col-md-12">
                        <div class="form-group">
                            <div class="dd" id="navItems"></div>
                        </div>
                    </div>
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
    <style>.dd{ max-width:100%; }</style>
    <script type="text/template" id="nav_items">
        <ol class="dd-list">
            <% _.each(items, function (item) { %>
            <li class="dd-item dd3-item" data-id="<%- item.id %>">
                <div class="dd-handle dd3-handle">Drag</div>
                <div class="dd3-content">
                    <% if(item.published == 0){ %><span style="text-decoration: line-through"><% } %><%- item.id %> <%- item.name %><% if(item.published == 0){ %></span><% } %>
                    <a class="b-nav-item-edit dd-remove" style="right: 25px" data-id="<%- item.id %>" href="javascript:void(0)" title="Редагувати"><i class="fa fa-pencil"></i></a>
                    <a class="b-nav-item-delete dd-remove" data-id="<%- item.id %>" href="javascript:void(0)" title="Видалити"><i class="fa fa-trash"></i></a>
                </div>
                <% if (item.isfolder) { %>
                    <%= templateFn({ items: item.items, templateFn: templateFn }) %>
                <% } %>
            </li>
            <% }); %>
        </ol>
    </script>
{/literal}