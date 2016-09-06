<fieldset>
    <legend>
        Синонім для категорії
        <a href="javascript:;" title="Додати" class="s-c-a-s"><i class="fa fa-plus-circle"></i></a>
    </legend>
    <p style="font-size: 11px; line-height: 12px; margin-bottom: 0.5em;">Виберіть категорії, товари яких будуть відображатись при перегляду цієї категрії</p>
    <p id="syn_cat_cnt"></p>
</fieldset>
{literal}
    <script type="text/template" id="syn_cat_tpl">
        <% if (items.length) { %>
            <% items.forEach(function(item){ %>
                <span class="badge badge-info">
                    <a href="module/run/shop/categories/edit/<%- item.id %>" title="Переглянути" target="_blank"><%- item.name %></a>
                    <a href="javascript:;" title="Видалити" class="s-c-d-s" data-id="<%- item.id %>"><i class="fa fa-remove"></i></a>
                </span>
            <% }); %>
        <% } else { %>
        <p>Немає</p>
        <% } %>
    </script>
{/literal}