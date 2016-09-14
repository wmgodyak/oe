<div id="tabs_adapters">
    <ul>
        {foreach $adapters as $adapter}
            <li><a href="modules#{$adapter}">{$adapter}</a></li>
        {/foreach}
    </ul>
    {foreach $adapters as $adapter}
        <div id="{$adapter}" class="tab-adapter">
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="config[adapter][{$adapter}][enabled]" value="0">
                            <input {if isset($config.adapter[$adapter].enabled) && $config.adapter[$adapter].enabled == 1}checked{/if} type="checkbox" id="adapter_{$adapter}_enabled" data-adapter="{$adapter}" class="toggle-analytics-config" name="config[adapter][{$adapter}][enabled]" value="1">
                            Увімкнуто
                        </label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_group_id" class="col-sm-3 control-label">Група ціни</label>
                <div class="col-sm-9">
                    <select name="config[adapter][{$adapter}][group_id]" id="adapter_group_id"  class="form-control" required>
                        {foreach $users_group as $group}
                            <option {if isset($config.adapter[$adapter].group_id) && $config.adapter[$adapter].group_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_currency_id" class="col-sm-3 control-label">Валюта</label>
                <div class="col-sm-9">
                    <select name="config[adapter][{$adapter}][currency_id]" id="adapter_currency_id"  class="form-control">
                        {foreach $currency as $c}
                            <option {if isset($config.adapter[$adapter].currency_id) && $config.adapter[$adapter].currency_id == $c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_languages_id" class="col-sm-3 control-label">Мова</label>
                <div class="col-sm-9">
                    <select name="config[adapter][{$adapter}][languages_id]" id="adapter_languages_id"  class="form-control">
                        {foreach $langs as $c}
                            <option {if isset($config.adapter[$adapter].languages_id) && $config.adapter[$adapter].languages_id == $c.id}selected{/if} value="{$c.id}">{$c.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_markup" class="col-sm-3 control-label">Націнка (%)</label>
                <div class="col-sm-9">
                    <input name="config[adapter][{$adapter}][markup]" id="adapter_markup"  class="form-control" value="{if isset($config.adapter[$adapter].markup)}{$config.adapter[$adapter].markup}{/if}">
                </div>
            </div>
            <div class="form-group">
                <label for="adapter_{$adapter}_categories" class="col-sm-3 control-label">Групи товарів <a href="javascript:;" title="Додати" class="se-select-cat" data-adapter="{$adapter}"><i class="fa fa-plus-circle"></i></a></label>
                <div class="col-sm-9">
                    {*<input name="config[adapter][{$adapter}][markup]" id="adapter_markup"  class="form-control" value="">*}
                    <div class="form-control-static" id="ex_cat_tpl{$adapter}" style="text-align: left;">всі</div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3">
                    <div class="checkbox">
                        <label>
                            <input type="hidden" name="config[adapter][{$adapter}][track]" value="0">
                            <input type="checkbox" {if isset($config.adapter[$adapter].track) && $config.adapter[$adapter].track == 1}checked{/if}  id="adapter_{$adapter}_track" data-adapter="{$adapter}" class="toggle-analytics-config" name="config[adapter][{$adapter}][track]" value="1">
                            Відслідковувати
                        </label>
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
</div>
{literal}
    <script type="text/template" id="ex_cat_tpl">
        <% if (items.length) { %>
            <% items.forEach(function(item){ %>
                <span class="badge badge-info">
                    <a href="module/run/shop/categories/edit/<%- item.id %>" title="Переглянути" target="_blank"><%- item.name %></a>
                    <a href="javascript:;" title="Видалити" data-adapter="<%- adapter %>" class="se-s-c-d-s" data-id="<%- item.id %>"><i class="fa fa-remove"></i></a>
                </span>
            <% }); %>
        <% } else { %>
            <p>Всі</p>
        <% } %>
    </script>
    <script>
        $(document).ready(function(){

            var getSelectedCategories = function(adapter)
            {
                engine.request.post({
                    url: 'module/run/shopExport/getSelectedCategories',
                    data: {
                        adapter    : adapter
                    },
                    success: function(res){
                        var cnt = $('#ex_cat_tpl' + adapter);
                        var tmpl = _.template($('#ex_cat_tpl').html());
                        var d = tmpl({items: res.items, adapter:adapter});
                        cnt.html(d);
                    }
                });
            };

            $('#tabs_adapters').tabs();

            $('.tab-adapter').each(function(){
                var a = $(this).attr('id');
                    getSelectedCategories(a);
            });

            $('.se-select-cat').click(function()
            {
                var adapter = $(this).data('adapter');
                engine.request.get('module/run/shopExport/selectCategories/' + adapter, function(res){
                    var bi = t.common.button_save;
                    var buttons = {};

                    buttons[bi] =  function(){
                        $('#syn_cat_form').submit();
                    };

                    var dialog = engine.dialog({
                        content: res,
                        title: "Вибір категорії",
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    var inp_selected_nodes = $("#selected_nodes");

                    $.jstree.defaults.state.key = 'jstree_msextr';
                    var $catTree = new engine.tree('syn_cat_tree');
                    $catTree
                            .setUrl('module/run/categorySynonym/tree')
                            .init(function(event, data){
                                var n = data.selected;
                                event.preventDefault();
                                inp_selected_nodes.val(n.join(','))
                            });

                    engine.validateAjaxForm('#syn_cat_form', function(d){
                        if(d.s){
                            getSelectedCategories(adapter);
                            dialog.dialog('destroy').remove();
                        }
                    });
                });
            });

            $(document).on('click', '.se-s-c-d-s', function(){

                var id = $(this).data('id'), adapter = $(this).data('adapter');
                engine.request.post({
                   url: 'module/run/shopExport/deleteCategory',
                    data: {
                        adapter : adapter,
                        id: id
                    },
                    success: function(){
                        getSelectedCategories(adapter);
                    }
                });
            });
        });
    </script>
{/literal}