<fieldset id="shopBlog">
    <legend>Показувати в магазині</legend>
    <p style="font-size: 11px; line-height: 12px; margin-bottom: 0.5em;"><a href="javascript:;" title="Вибрати категорії" class="s-b-add-cat">Виберіть категорії</a>, в яких будуть відображатись статті</p>
    <p id="shop_blog_cat_cnt"></p>
    <p><br></p>
    <p style="font-size: 11px; line-height: 12px; margin-bottom: 0.5em;">Або окремі товари: </p>
    <div class="form-group">
        <div class="col-md-12">
            <select id="shop_blog_search_p" class="form-control no-s2"></select>
        </div>
    </div>
    <p id="shop_blog_product_cnt"></p>
</fieldset>
{literal}
    <script type="text/template" id="shop_blog_cat_tpl">
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
                <td><a href="javascript:;" data-id="<%- item.id %>" class="shop-blog-cat-del" title="Видалити"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% }); %>
        </table>
        <% } else { %>
        <p>Нічого не вибрано</p>
        <% } %>
    </script>
{/literal}
{literal}
    <script type="text/template" id="shop_blog_product_tpl">
        <% if (items.length) { %>
        <table class="table">
            <tr>
                <th>Назва</th>
                <th>Вид.</th>
            </tr>
            <% items.forEach(function(item){ %>
            <tr>
                <td><%- item.name%></td>
                <td><a href="javascript:;" data-id="<%- item.id %>" class="shop-blog-p-del" title="Видалити"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% }); %>
        </table>
        <% } else { %>
        <p>Нічого не вибрано</p>
        <% } %>
    </script>
{/literal}