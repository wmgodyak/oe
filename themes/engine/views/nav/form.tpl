{function name=renderSelect}
    {foreach $items as $item}
        <option value="{$item.id}">{if $parent}{$parent} / {/if}{$item.name}</option>
        {if $item.isfolder}
            {call renderSelect items=$item.items parent=$item.name}
        {/if}
    {/foreach}
{/function}
<form class="form-horizontal" action="nav/process/{$data.id}"  method="post" id="form" data-success="engine.nav.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-3 control-label required">{$t.nav.name}</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_code" class="col-md-3 control-label required">{$t.nav.code}</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" name="data[code]" id="data_code" value="{$data.code}" required placeholder="[a-z]+">
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>{$t.nav.items}</legend>
                {if $action == 'create'}
                    <p>Створення, редагування , сортування пунктів меню досутпні при редагуванні</p>
                {else}
                    <div class="form-group">
                        <div class="col-md-12">
                            <select id="selItems" class="form-control" data-nav="{$data.id}">
                                <option value="">{$i.common.select}</option>
                                {call renderSelect items=$items}
                            </select>
                        </div>
                    </div>
                {/if}

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

<script>var selected_items = {json_encode($data.items)}</script>

{literal}
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