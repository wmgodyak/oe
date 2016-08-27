<fieldset>
    <legend>
        Комплекти
        <a href="javascript:;" class="b-kits-add"><i class="fa-plus-circle fa" title="Додати"></i></a>
    </legend>
    <div id="kits_list"></div>
    {literal}
        <script type="text/template" id="kits_tpl">

            <% if(items.length) { %>
            <table class="table-bordered table">
                <tr>
                    <th>ID</th>
                    <th>Назва</th>
                    <th>Функц</th>
                </tr>
                <% items.forEach(function(item) { %>
                <tr>
                    <td><%- item.id %></td>
                    <td><%- item.name %></td>
                    <td style="width: 100px;">
                        <button type="button" class= "b-kits-edit btn" title="Вибрати товари" data-id="<%- item.id %>"><i class="fa fa-cog"></i></button>
                        <button type="button" class="btn btn-danger b-kits-delete" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></button>
                    </td>
                </tr>
                <% }); %>
            </table>
            <% }else { %>
                <p style="text-align: center">немає комплектів</p>
            <% } %>
        </script>
    {/literal}
</fieldset>
