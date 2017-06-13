<div class="form-group">
    <label class="col-sm-3 control-label">select value</label>
    <div class="col-sm-9">
        <select id="acc_categories_features_values" class="form-control">
            <option value="">-- select --</option>
            {foreach $values as $item}
                <option value="{$item.id}">{$item.name}</option>
            {/foreach}
        </select>
    </div>
    <div id="acc_categories_features_values_list"></div>
</div>

{literal}
    <script type="text/template" id="acc_categories_features_values_tpl">
        <table class="table-bordered table">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Func</th>
            </tr>
            <% items.forEach(function(item) { %>
            <tr>
                <td><%- item.id %></td>
                <td style="text-align: left;"><%- item.name %></td>
                <td style="width: 100px;">
                    <button type="button" class="btn btn-danger b-accessories-categories-features-values-delete" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                </td>
            </tr>
            <% }); %>
        </table>
    </script>
{/literal}