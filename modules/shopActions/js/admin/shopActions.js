$(document).ready
(
    function()
    {
        $(document).on('click', '.b-actions-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити акцію?', function(){
                engine.content.delete(id, 'module/run/shopActions');
            });
        });

        $(document).on('click', '.b-actions-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id, 'module/run/shopActions');
        });

        $(document).on('click', '.b-actions-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id, 'module/run/shopActions');
        });

        $("#meta_expired").datepicker({
            minDate    : 0,
            dateFormat : 'dd.mm.yy'
        });

        if($('#sa_categories_cnt').length == 0) return ;

        var content_id = $("#content_id").val();

        var getCategories = function(){
            engine.request.post({
                url: 'module/run/shopActions/getCategories',
                data: {
                    content_id: content_id
                },
                success: function(res){
                    var cnt = $('#sa_categories_cnt');
                    var tmpl = _.template($('#sa_categories_tpl').html());
                    var d = tmpl({items: res.items});
                    cnt.html(d);
                }
            });
        };

        var getProducts = function(){
            engine.request.post({
                url: 'module/run/shopActions/getProducts',
                data: {
                    content_id: content_id
                },
                success: function(res){
                    var cnt = $('#sa_products_cnt');
                    var tmpl = _.template($('#sa_products_tpl').html());
                    var d = tmpl({items: res.items});
                    cnt.html(d);
                }
            });
        };

        getProducts();
        getCategories();

        $(document).on
        (
            'click',
            '.sa-b-add-cat',
            function()
            {
                engine.request.get('module/run/shopActions/selectCategories/' + content_id, function(res){
                    var bi = t.common.button_save;
                    var buttons = {};

                    buttons[bi] =  function(){
                        $('#sa_cat_form').submit();
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

                    $.jstree.defaults.state.key = 'jstree_msbct';

                    var $catTree = new engine.tree('sa_cat_tree');
                    $catTree
                        .setUrl('module/run/shopActions/catTree')
                        .init(function(event, data){
                            var n = data.selected;
                            event.preventDefault();
                            inp_selected_nodes.val(n.join(','))
                        });

                    engine.validateAjaxForm('#sa_cat_form', function(d){
                        if(d.s){
                            getCategories();
                            dialog.dialog('destroy').remove();
                        }
                    });
                });
            }
        );

        $(document).on('click', '.sa-c-d-s', function(e){
            e.preventDefault();
            var categories_id = $(this).data('id');
            engine.request.post({
                url: 'module/run/shopActions/categoriesDelete/'+categories_id,
                data: {
                    content_id    : content_id,
                    categories_id : categories_id
                },
                success: getCategories
            })
        });

        $("#sa_products").select2({
            placeholder: "пошук по SKU, назві",
            minimumInputLength: 3,
            ajax: {
                url: "module/run/shopActions/searchProducts",
                dataType: 'json',
                quietMillis: 250,
                type: 'POST',
                data: function (params) {
                    return {
                        q           : params.term, // search term
                        page        : params.page,
                        token       : TOKEN
                    };
                }
            }
        }).on("select2:selecting", function(e) {
            engine.request.post({
                url: 'module/run/shopActions/addProduct',
                data:{
                    products_id : e.params.args.data.id,
                    token         : TOKEN,
                    content_id: content_id
                },
                success: getProducts
            });
        });

        $(document).on('click', '.sa-p-del', function(e){
            e.preventDefault();
            var products_id = $(this).data('id');
            engine.request.post({
                url: 'module/run/shopActions/productsDelete/'+products_id,
                data: {
                    content_id  : content_id,
                    products_id : products_id
                },
                success: getProducts
            })
        });
    }
);