<fieldset>
    <legend>Аксесуари для товарів</legend>

    <div class="form-group">
        <label for="prepayment" class="col-sm-3 control-label">Виберіть категорію</label>
        <div class="col-sm-9">
            <select id="acc_categories" class="form-control"></select>
        </div>
    </div>
    <div id="acc_categories_list"></div>
</fieldset>
{literal}
<script type="text/template" id="acc_categories_tpl">
    <table class="table-bordered table">
        <tr>
            <th>ID</th>
            <th>Назва</th>
            <th>Функц</th>
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
                <button type="button" class="btn b-accessories-categories-edit" title="Властивості" data-id="<%- item.id %>" data-category="<%-item.categories_id%>"><i class="fa fa-cog"></i></button>
                <button type="button" class="btn btn-danger b-accessories-categories-delete" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
            </td>
        </tr>
        <% }); %>
    </table>
</script>
{/literal}