$(document).ready(function(){
    if($('#shopBlog').length == 0) return ;

    var post_id = $("#content_id").val();
    
    var getCategories = function(){
        engine.request.post({
            url: 'module/run/shopBlog/getCategories',
            data: {
                post_id: post_id
            },
            success: function(res){
                var cnt = $('#shop_blog_cat_cnt');
                var tmpl = _.template($('#shop_blog_cat_tpl').html());
                var d = tmpl({items: res.items});
                cnt.html(d);
            }
        });
    };
    var getProducts = function(){
        engine.request.post({
            url: 'module/run/shopBlog/getProducts',
            data: {
                post_id: post_id
            },
            success: function(res){
                var cnt = $('#shop_blog_product_cnt');
                var tmpl = _.template($('#shop_blog_product_tpl').html());
                var d = tmpl({items: res.items});
                cnt.html(d);
            }
        });
    };

    getCategories();
    getProducts();

    $(document).on
    (
        'click',
        '.s-b-add-cat',
        function()
        {
            engine.request.get('module/run/shopBlog/selectCategories/' + post_id, function(res){
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#sb_cat_form').submit();
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

                var $catTree = new engine.tree('syn_cat_tree');
                $catTree
                    .setUrl('module/run/shopBlog/catTree')
                    .init(function(event, data){
                        var n = data.selected;
                        event.preventDefault();
                        inp_selected_nodes.val(n.join(','))
                    });

                engine.validateAjaxForm('#sb_cat_form', function(d){
                    if(d.s){
                        getCategories();
                        dialog.dialog('destroy').remove();
                    }
                });
            });
        }
    );

    $(document).on('click', '.shop-blog-cat-del', function(e){
        e.preventDefault();
        var categories_id = $(this).data('id');
        engine.request.post({
            url: 'module/run/shopBlog/categoriesDelete/'+categories_id,
            data: {
                post_id    : post_id,
                categories_id : categories_id
            },
            success: getCategories
        })
    });

    $("#shop_blog_search_p").select2({
        placeholder: "пошук по ID SKU або назві",
        minimumInputLength: 3,
        ajax: {
            url: "module/run/shopBlog/searchProducts",
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
            url: 'module/run/shopBlog/addProduct',
            data:{
                products_id : e.params.args.data.id,
                token         : TOKEN,
                post_id: post_id
            },
            success: getProducts
        });
    });


    $(document).on('click', '.shop-blog-p-del', function(e){
        e.preventDefault();
        var products_id = $(this).data('id');
        engine.request.post({
            url: 'module/run/shopBlog/productsDelete/'+products_id,
            data: {
                post_id     : post_id,
                products_id : products_id
            },
            success: getProducts
        })
    });
});