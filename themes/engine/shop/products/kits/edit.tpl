<div class="form-group">
    <label for="prepayment" class="col-sm-3 control-label">Виберіть товар</label>
    <div class="col-sm-9">
        <select id="select_products" class="form-control"></select>
    </div>
</div>
<div id="kits_list"></div>
{literal}
    <script type="text/template" id="kits_tpl">
        <% if(items.length) { %>
        <table class="table-bordered table">
            <tr>
                <th>ID</th>
                <th>Назва</th>
                <th>Знижка</th>
                <th>Функц</th>
            </tr>
            <% items.forEach(function(item) { %>
            <tr>
                <td><%- item.products_id %></td>
                <td>
                    <a href="module/run/shop/products/edit/<%- item.products_id %>" title="Редагувати" target="_blank"><%- item.name %></a>
                </td>
                <td><input type="text" name="discount[<%-item.id%>]" required></td>
                <td style="width: 100px;">
                    <button type="button" class="btn btn-danger b-kits-delete" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                </td>
            </tr>
            <% }); %>
        </table>
        <% } %>
    </script>
{/literal}