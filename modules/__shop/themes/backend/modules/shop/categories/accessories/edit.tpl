<div class="form-group">
    <label class="col-sm-3 control-label">Select feature</label>
    <div class="col-sm-9">
        <select id="acc_categories_features" class="form-control">
            <option value="">-- виберіть --</option>
            {foreach $features as $item}
                <option value="{$item.id}">{$item.name}</option>
            {/foreach}
        </select>
    </div>
    <div id="acc_categories_features_list"></div>
</div>

{literal}
    <script type="text/template" id="acc_categories_features_tpl">
        <table class="table-bordered table">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Func</th>
            </tr>
            <% items.forEach(function(item) { %>
            <tr>
                <td><%- item.features_id %></td>
                <td style="text-align: left;"><%- item.name %></td>
                <td style="width: 100px;">
                    <button type="button" class="btn b-accessories-categories-features-edit" title="Властивості" data-id="<%- item.id %>" data-features_id="<%-item.features_id%>"><i class="fa fa-cog"></i></button>
                    <button type="button" class="btn btn-danger b-accessories-categories-features-delete" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                </td>
            </tr>
            <% }); %>
        </table>
    </script>
{/literal}