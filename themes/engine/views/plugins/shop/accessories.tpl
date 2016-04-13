<fieldset>
    <legend>Аксесуари</legend>
    <div class="form-group">
        <label for="" class="col-md-3 control-label">Виберіть товар</label>
        <div class="col-md-9">
            <select class="form-control" id="selectAccessories"></select>
        </div>
    </div>
    <div id="selectedAccessories"></div>

    {*<pre>{print_r($selected_accessories)}</pre>*}
</fieldset>
<script>var selected_accessories = {json_encode($selected_accessories)}</script>

{literal}
    <script type="text/template" id="accessories" >
        <table class="table table-bordered">
            <tr>
                <th>Артикул</th>
                <th>Товар</th>
                <th>Видалити</th>
            </tr>
            <% for(var i=0;i < items.length; i++) { %>
            <tr id="cf-sf-<%- items[i].id %>">
                <td><%- items[i].code %></td>
                <td><img src="/<%- items[i].img %>" alt="<%- items[i].img %>" style="float: left; margin-right: 1em;max-width: 60px;"> <a href="content/<%- items[i].type %>/edit/<%- items[i].id %>"><%- items[i].name %></a></td>
                <td><a class="b-accessories-delete" data-id="<%- items[i].acc_id %>" title="Видалити" href="javascript:;"><i class="fa fa-remove"></i></a></td>
            </tr>
            <% } %>
        </table>
    </script>
<script>
$(document).ready(function(){

    var ss = $("#selectAccessories"), sa = $('#selectedAccessories'), content_id = $('#content_id').val();

    var tmpl = _.template($('#accessories').html());
    var d = tmpl({items: selected_accessories});
    sa.html(d);

    function refreshAccessories(){
        engine.request.get('plugins/productsAccessories/get/'+content_id, function(res){
            var tmpl = _.template($('#accessories').html());
            var d = tmpl({items: res.items});
            sa.html(d);
        });
    }

    ss.select2({
        placeholder: 'Введіть артикул або назву товару',
        ajax: {
            url: "plugins/productsAccessories/search",
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term
                    pid: content_id
                };
            },
            processResults: function (data, params) {
                return {
                    results: data.items
                };
            },
            cache: false
        },
        minimumInputLength: 1
    });

    ss.on("select2:select", function(e) {
       var opt = $(this).find('option:selected'), id = opt.val();
        engine.request.get('plugins/productsAccessories/add/'+content_id+'/'+id, function(s){
            if(s>0){
                refreshAccessories();
            }
        }, 'html');
    });

    $(document).on('click', '.b-accessories-delete', function(){
        var id = $(this).data('id');
        engine.request.post({
            url: 'plugins/productsAccessories/del',
            data: {
                id: id
            },
            success: function(d)
            {
                if(d>0){
                    refreshAccessories();
                }
            }
        })
    });
});
</script>
{/literal}