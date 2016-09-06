$(document).ready(function(){
    var content_id = $("#content_id").val();

    var getSynonyms = function(){
        engine.request.post({
            url: 'module/run/categorySynonym/get',
            data: {
                content_id    : content_id
            },
            success: function(res){
                var cnt = $('#syn_cat_cnt');
                var tmpl = _.template($('#syn_cat_tpl').html());
                var d = tmpl({items: res.items});
                cnt.html(d);
            }
        });
    };

    getSynonyms();

    $(document).on('click', '.s-c-d-s', function(e){
        e.preventDefault();
        var categories_id = $(this).data('id');
        engine.request.post({
            url: 'module/run/categorySynonym/delete/'+categories_id,
            data: {
                content_id    : content_id,
                categories_id : categories_id
            },
            success: getSynonyms
        })
    });

    $(document).on
    (
        'click',
        '.s-c-a-s',
        function()
        {
            engine.request.get('module/run/categorySynonym/edit/' + content_id, function(res){
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
                        getSynonyms();
                        dialog.dialog('destroy').remove();
                    }
                });
            });
        }
    );
});