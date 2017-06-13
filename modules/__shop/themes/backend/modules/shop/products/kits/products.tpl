
<div class="kits-notifications"></div>
<div class="form-group">
    <label for="prepayment" class="col-sm-3 control-label">Select product</label>
    <div class="col-sm-9">
        <select id="select_products{$kits_id}" class="form-control no-s2"></select>
    </div>
</div>

<div id="kits_products_list"></div>
{literal}
    <script type="text/template" id="kits_products_tpl">
        <form action="module/run/shop/products/kits/setDiscount" method="post" id="kitsDiscount">
        <% if(items.length) { %>
        <table class="table-bordered table">
            <tr>
                <th>ID</th>
                <th><%- tr.name%></th>
                <th><%- tr.discount%></th>
                <th><%- tr.func%></th>
            </tr>
            <% items.forEach(function(item) { %>
            <tr>
                <td><%- item.id %></td>
                <td><%- item.name %></td>
                <td><input type="text" required name="discount[<%- item.id %>]" value="<%- item.discount %>" class="form-control" onchange="this.value=parseInt(this.value); if(this.value == 'NaN') this.value = ''"></td>
                <td style="width: 100px;">
                    <button type="button" class="btn btn-danger b-kits-products-delete" title="Delete" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                </td>
            </tr>
            <% }); %>
        </table>
        <div style="padding-top: 10px ; text-align: right;">
            <button class="btn btn-success">Save</button>
        </div>
            <input type="hidden" name="token" value="<%-token%>">
        <% }else { %>
        <p style="text-align: center">there are no items in the kit</p>
        <% } %>
        </form>
    </script>
{/literal}