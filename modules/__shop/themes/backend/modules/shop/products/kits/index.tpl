<fieldset>
    <legend>
        {$t.shop.kits.action_index} {$content.info[$languages[0].id].name}
        <a href="javascript:;" class="b-kits-add"><i class="fa-plus-circle fa" title="{$t.common.create}"></i></a>
    </legend>
    <div id="kits_list"></div>
    <script>
            var tr = {json_encode($t.shop.kits)};
    </script>
    {literal}
        <script type="text/template" id="kits_tpl">
            <% if(items.length) { %>
            <table class="table-bordered table">
                <tr>
                    <th><%- tr.name%></th>
                    <th><%- tr.func%></th>
                </tr>
                <% items.forEach(function(item) { %>
                <tr>
                    <td>
                        <p style="font-weight: bold; margin-bottom: 1em; margin-top: 0.5em;"><%- item.name %></p>
                        <% if (item.products.length) { %>
                        <table class="table-bordered table">
                            <tr>
                                <th>ID</th>
                                <th><%- tr.name%></th>
                                <th><%- tr.discount%></th>
                            </tr>
                            <% item.products.forEach(function(product) { %>
                            <tr>
                                <td><%- product.id %></td>
                                <td><%- product.name %></td>
                                <td><%- product.discount %></td>
                            </tr>
                            <% }); %>
                        </table>
                        <% } %>
                    </td>
                    <td style="width: 100px;">
                        <button type="button" class= "b-kits-products btn" title="Select products" data-id="<%- item.id %>"><i class="fa fa-cog"></i></button>
                        <button type="button" class="btn btn-danger b-kits-delete" title="Delete" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                    </td>
                </tr>
                <% }); %>
            </table>
            <% }else { %>
                <p style="text-align: center"><%- tr.empty %></p>
            <% } %>
        </script>
        <script type="text/template" id="kits_tpl1">

            <% if(items.length) { %>
            <table class="table-bordered table">
                <tr>
                    <th>ID</th>
                    <th><%- tr.name%></th>
                    <th><%- tr.func%></th>
                </tr>
                <% items.forEach(function(item) { %>
                <tr>
                    <td><%- item.id %></td>
                    <td><%- item.name %></td>
                    <td style="width: 100px;">
                        <button type="button" class= "b-kits-products btn" title="Select products" data-id="<%- item.id %>"><i class="fa fa-cog"></i></button>
                        <button type="button" class="btn btn-danger b-kits-delete" title="Delete" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                    </td>
                </tr>
                <% }); %>
            </table>
            <% } else { %>
                <p style="text-align: center"><%- tr.empty %></p>
            <% } %>
        </script>
    {/literal}
</fieldset>
