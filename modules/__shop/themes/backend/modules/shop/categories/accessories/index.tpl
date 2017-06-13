<fieldset>
    <legend>{$t.shop.accessories.index}</legend>

    <div class="form-group">
        <label for="acc_categories" class="col-sm-3 control-label">{$t.shop.accessories.categories_select}</label>
        <div class="col-sm-9">
            <select id="acc_categories" class="form-control" data-placeholder="{$t.shop.accessories.categories_select_p}"></select>
        </div>
    </div>
    <div id="acc_categories_list"></div>
</fieldset>
<script>var t_sa = {json_encode($t.shop.accessories)}</script>
{literal}
<script type="text/template" id="acc_categories_tpl">
    <% if(items.length) { %>
    <table class="table-bordered table">
        <tr>
            <th><%-t_sa.items_id %></th>
            <th><%-t_sa.items_name %></th>
            <th><%-t_sa.items_func %></th>
        </tr>
        <% items.forEach(function(item) { %>
        <tr>
            <td><%- item.categories_id %></td>
            <td>
                <a href="module/run/shop/categories/edit/<%- item.categories_id %>" title="Редагувати" target="_blank"><%- item.name %></a>
                <% if(item.features.length) { %>
                    <br>
                    <% item.features.forEach(function(feature){ %>
                        <span style="font-size: 10px;">
                            <%-feature.name%>
                            <% if(feature.features_values.length) { %>:
                                <% feature.features_values.forEach(function(val){ %>
                                    <%- val.name %>,
                                <% }); %>
                            <% } %>
                        </span>
                    <% }); %>
                <% } %>
            </td>
            <td style="width: 100px;">
                <button type="button" class="btn b-accessories-categories-edit" title="<%- t_sa.items_features %>" data-id="<%- item.id %>" data-category="<%-item.categories_id%>"><i class="fa fa-cog"></i></button>
                <button type="button" class="btn btn-danger b-accessories-categories-delete" title="<%- t_sa.items_delete %>" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
            </td>
        </tr>
        <% }); %>
    </table>
    <% } else { %>
        <p style="text-align: center;"><%- t_sa.items_empty %></p>
    <% } %>
</script>
{/literal}