<div class="form-group">
    <div class="col-md-12">
        <label for="meta_clickable" class="">
            <input type="hidden" name="content_meta[clickable]" value="0">
            <input class="switch" type="checkbox" name="content_meta[clickable]" id="meta_clickable" value="1" {if $app->contentMeta->get($content.id, 'clickable', true) == 1}checked{/if} >
            <span class="l-check">Клікабельний банер</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="meta_counter" class="">
            <input type="hidden" name="content_meta[counter]" value="0">
            <input class="switch" type="checkbox" name="content_meta[counter]" id="meta_counter" value="1" {if $app->contentMeta->get($content.id, 'counter', true) == 1}checked{/if} >
            <span class="l-check">Зворотній лічильник</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="meta_show_on_products" class="">
            <input type="hidden" name="content_meta[show_on_products]" value="0">
            <input class="switch" type="checkbox" name="content_meta[show_on_products]" id="meta_show_on_products" value="1" {if $app->contentMeta->get($content.id, 'show_on_products', true) == 1}checked{/if} >
            <span class="l-check">Показувати в списку товарів</span>
        </label>
    </div>
</div>
<div class="form-group">
    <div class="col-md-12">
        <label for="meta_show_on_products_page" class="">
            <input type="hidden" name="content_meta[show_on_products_page]" value="0">
            <input class="switch" type="checkbox" name="content_meta[show_on_products_page]" id="meta_show_on_products_page" value="1" {if $app->contentMeta->get($content.id, 'show_on_products_page', true) == 1}checked{/if} >
            <span class="l-check">Показувати в карточці товару</span>
        </label>
    </div>
</div>
{foreach $languages as $lang}
    <div class="form-group">
        <label for="meta_image_{$lang.id}" class="col-md-4 control-label">Зображення({$lang.code}) </label>
        <div class="col-md-8">
            {assign var='img' value=$app->contentMeta->get($content.id, "image_`$lang.id`", true)}
            <img src="{if empty($img)}/uploads/noimage.png{else}{$img}{/if}" id="meta_image_src_{$lang.id}" alt="{$img}" style="max-width: 190px; max-height: 120px;">
            <input onchange="$('#meta_image_src_{$lang.id}').attr('src', this.value)" type="hidden" name="content_meta[image_{$lang.id}]" id="meta_image_{$lang.id}" class="form-control" value="{$img}" /><br>
            <button class="btn cf-file-browse" type="button" data-target="meta_image_{$lang.id}"><i class="fa fa-image"></i> Вибрати</button>
        </div>
    </div>
{/foreach}
<div class="form-group">
    <label for="content_position" class="col-md-4 control-label">Позиція</label>
    <div class="col-md-8">
        <input name="content[position]" id="content_position" onchange="this.value=parseInt(this.value); if (this.value == 'NaN') this.value=0;" class="form-control" value="{$content.position}">
    </div>
</div>
<div class="form-group">
    <label for="meta_expired" class="col-md-4 control-label">Дата закінчення акції</label>
    <div class="col-md-8">
        <input name="content_meta[expired]" id="meta_expired"  class="form-control" value="{$app->contentMeta->get($content.id, 'expired', true)}" />
    </div>
</div>
<div class="form-group">
    <label for="meta_place" class="col-md-4 control-label">Показувати на головній:</label>
    <div class="col-md-8">
        <select name="content_meta[place]" id="meta_place"  class="form-control">
            <option value="none" {if $app->contentMeta->get($content.id, 'place', true) == 'none'}selected{/if}>Не показувати</option>
            <option value="top"  {if $app->contentMeta->get($content.id, 'place', true) == 'top'}selected{/if}>Слайдер</option>
            <option value="bottom" {if $app->contentMeta->get($content.id, 'place', true) == 'bottom'}selected{/if}>Два блоки</option>
        </select>
    </div>
</div>
<div class="form-group">
    <label for="sa_categories" class="col-md-4 control-label">Привязка до категорій: <a href="javascript:void(0);" class="sa-b-add-cat" title="Додати категорії"><i class="fa fa-plus-circle"></i></a></label>
    <div class="col-md-8">
        <p id="sa_categories_cnt"></p>
    </div>
</div>
<div class="form-group">
    <label for="sa_products" class="col-md-4 control-label">Привязка до товарів:</label>
    <div class="col-md-8">
        <select id="sa_products" class="form-control no-s2"></select>
    </div>
    <div id="sa_products_cnt"></div>
</div>
{literal}
    <script type="text/template" id="sa_categories_tpl">
        <% if (items.length) { %>
            <% items.forEach(function(item){ %>
                <span class="badge badge-info">
                    <a href="module/run/shop/categories/edit/<%- item.id %>" title="Переглянути" target="_blank"><%- item.name %></a>
                    <a href="javascript:;" class="sa-c-d-s" title="Видалити" data-id="<%- item.id %>"><i class="fa fa-remove"></i></a>
                </span>
            <% }); %>
        <% } else { %>
            <p class="form-control-static">Немає</p>
        <% } %>
    </script>
    <script type="text/template" id="sa_products_tpl">
        <% if (items.length) { %>
        <table class="table" style="328px!important;">
            <tr>
                <th>Назва</th>
                <th>Вид.</th>
            </tr>
            <% items.forEach(function(item){ %>
            <tr>
                <td><%- item.name%></td>
                <td><a href="javascript:;" data-id="<%- item.id %>" class="sa-p-del" title="Видалити"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% }); %>
        </table>
        <% } else { %>
            <div class="row" style="float: none;padding-top: 50px;"><p style="text-align: center">Нічого не вибрано</p></div>
        <% } %>
    </script>
{/literal}