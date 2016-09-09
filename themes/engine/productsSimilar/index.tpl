<fieldset id="productsSimilar">
    <legend>
        Схожі товари
        <a title="Додати" class="b-sp-similar-sel-f" href="javascript:;"><i class="fa fa-plus-circle"></i></a>
    </legend>
    <div id="s_p_similar_list"></div>

</fieldset>
{literal}
<script type="text/template" id="p_similar_tpl">
    <% if (items.length) { %>
    <table class="table">
        <tr>
            <th>#</th>
            <th>Назва</th>
            <th>Вид.</th>
        </tr>
        <% items.forEach(function(item){ %>
        <tr>
            <td><%- item.id %></td>
            <td><%- item.name%></td>
            <td><a href="javascript:;" data-id="<%- item.id %>" class="b-similar-delete-feat" title="Видалити"><i class="fa fa-remove"></i></a></td>
        </tr>
        <% }); %>
    </table>
    <% } else { %>
        <p>Немає вибраних властивостей</p>
    <% } %>
</script>
{/literal}