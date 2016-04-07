/**
 * Created by wg on 29.02.16.
 */
engine.products = {
    init: function()
    {
        //engine.require('content');
        engine.require('bootstrap-tagsinput.min', '/themes/engine/assets/js/vendor/');

        this.variants.init();

        $(document).on('click', '.b-products-delete', function(){
            var id = $(this).data('id');
            engine.confirm('ДІйсно видалити сторінку?', function(){engine.content.delete(id);});
        });

        $(document).on('click', '.b-products-pub', function(){
            var id = $(this).data('id');
            engine.content.pub(id);
        });

        $(document).on('click', '.b-products-hide', function(){
            var id = $(this).data('id');
            engine.content.hide(id);
        });

        $(document).on('click', '.b-products-categories-create', function(){
            //self.location.href= "content/productsCategories/create";
            engine.products.categories.create(0);
        });

        $('#categories').select2();

        var $tree = new engine.tree('productsCategories');
        $tree
            .setUrl('./plugins/productsCategories/tree')
            .setContextMenu('create', t.products.tree_create, 'fa-file', function(o){
                    var node_id= o.reference[0].id;
                    engine.products.categories.create(node_id);
                }
            )
            .setContextMenu('edit', t.productsCategories.tree_edit, 'fa-pencil', function(o){
                var node_id= o.reference[0].id;
                engine.products.categories.edit(node_id);
                }
            )
            .setContextMenu('del', t.productsCategories.tree_delete, 'fa-remove', function(o){
                    var node_id= o.reference[0].id;
                    engine.confirm
                    (
                        'ДІйсно видалити Категорію?',
                        function()
                        {
                            engine.content.delete(node_id, function(d){
                                if(ACTION == 'create' || ACTION == 'edit'){
                                    self.location.href = 'content/products';
                                }
                            });
                            $tree.refresh();
                        });
                }
            )
            .move(function(e, data){
                engine.request.post({
                    url : './plugins/productsCategories/move',
                    data: {
                        id: data.node.id,
                        'old_parent' : data.old_parent,
                        'parent' : data.parent,
                        'position' : data.position
                    }
                });
            })
            .init();


    },
    variants: {
        init: function()
        {
            var content_id = $('#content_id').val();

            $(document).on('click', '.b-products-add-variant', function(){
                engine.products.variants.add(content_id);
            });
            $(document).on('click', '.b-products-rm-variant', function(){
               var id = $(this).data('id');
                engine.products.variants.delete(id);
            });
            $(document).on('click', '.variant-picture', function(){
               var id = $(this).data('id');
                $("#variantsUploadId").val(id);
                $("#variantsUploadFileInput").click();
            });
            var form = $('<form id="variantsUploadImage" action="plugins/productsVariants/uploadImage/" method="post" style="display: none" enctype="multipart/form-data">\
                <input type="file" name="image" id="variantsUploadFileInput">\
                <input type="hidden" name="variant_id" id="variantsUploadId">\
                <input type="hidden" name="token" value="'+TOKEN+'">\
                </form>');
                form.appendTo('body');
                engine.validateAjaxForm('#variantsUploadImage', function(d){
                    if(d.s){
                        var a = $('.variant-picture.variant-'+ d.variant_id);
                        a.html($('<img src="'+ d.img +'" style="max-width: 50px;">'));
                    } else{
                        engine.alert(d.m);
                    }
                });
                $(document).on('change', '#variantsUploadFileInput', function(){
                    $("#variantsUploadImage").submit();
                });
        },
        add: function(content_id)
        {
            engine.request.get
            (
                'plugins/productsVariants/add/'+content_id
                ,
                function(d)
                {
                    var pw = engine.dialog({
                        content: d,
                        title: 'Додати варіант',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Зберегти": function(){
                                $('#productsVariantsForm').submit();
                            }
                        }
                    });
                    var  tpl = $("#vCnt").html();
                    $(document).on('change', ".variants-feature", function(){

                        var features_id = this.value, $row = $(this).parents('.row:first'), variantsValues = $row.find(".variants-values");
                        if(typeof FV == 'undefined') return;


                        variantsValues.html('').attr('disabled', true);

                        for(var i=0; i< FV.length; i++){
                            if(FV[i].id == features_id){

                                var out = '', items = FV[i].items;
                                for(var c=0; c<items.length; c++){
                                    out += "<option value='"+items[c].id+"'>"+items[c].name+"</option>";
                                }

                                variantsValues.html(out).removeAttr('disabled');
                            }
                        }

                    });

                    $('.variants-feature').trigger('change');


                    $(document).on('click', '.b-variants-add-row', function(){
                        $(tpl).appendTo($('#productsVariantsForm'));
                    });

                    $(document).on('click', '.b-variants-rm-row', function(){
                        $(this).parents('.row:first').remove();
                    });

                    engine.validateAjaxForm('#productsVariantsForm', function(d){

                        if(d.s > 0){
                            engine.request.get('plugins/productsVariants/get/'+content_id, function(res)
                            {
                                $("#products_variants_cnt").html(res);
                                pw.dialog('close').dialog('destroy').remove();
                            });
                        }
                    });
                }
            );
        },
        delete: function(id)
        {
            engine.confirm
            (
                'Видалити варіант?',
                function()
                {
                    engine.request.get('plugins/productsVariants/del/' + id, function(d){
                        if(d > 0){
                            $('#variant-'+id).remove();
                        }
                    });
                    $(this).dialog('close').dialog('destroy').remove();
                }
            );
        },
        render: function(selected)
        {
            var cnt = $('#products_variants_cnt'), features = CFV;//, res = [],
            //var row = [];
            //
            //for(var i = 0; i < features.length; i++ ){
            //    if(selected.contains(parseInt(features[i].id))){
            //        row.push(features[i].name);
            //    }
            //}
            //
            //res.push(row);
            //
            //for(i = 0; i < features.length; i++ ){
            //    row[i] = [];
            //    if(selected.contains(parseInt(features[i].id))){
            //        for(var c=0;c<features[i].items.length; c++){
            //            row[i].push(features[i].items[c]);
            //        }
            //    }
            //
            //    res.push(row);
            //}


            //var tr = [];
            //for(var i = 0; i < features.length; i++ ){
            //    var row = [];
            //    for(var c=0;c<features[i].items.length; i++){
            //        row.push()
            //    }
            //}



            //res.th = []; res.tr = [];
            //for(var i = 0; i < features.length; i++ ){
            //    //console.log(features[i]);
            //    var row = [];
            //    res.th.push(features[i].name);
            //    for(var c=0;c< features[i].items.length; c++){
            //        //res.tr[features[i].id].push(features[i].items[c])
            //
            //    }
            //
            //    //row.name= features[i].name;
            //    //res.push(row);
            //}
/*
* <% for(var i=0;i < features.length; i++) {  %>
 <% if(selected.contains(parseInt(features[i].id)) != false) { %>
 <th><%= features[i].name %></th>
 <% } %>
 <% } %>
* */
            var tmpl = _.template($('#variantsTbl').html());
            var d = tmpl({features: features, selected: selected});
            cnt.html(d);
        }
    },
    categories: {
        before: function()
        {
            var infoName = $("#productsCategoriesForm .info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});

            $("#productsCategoriesForm .info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
            $("#productsCategoriesForm .info-title, #productsCategoriesForm .into-h1, #productsCategoriesForm .info-keywords, #productsCategoriesForm .info-description")
                .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

            infoName.each(function(i,e){
                var inp = $('#productsCategoriesForm .info-url:eq('+i+')'), title = $('#productsCategoriesForm .info-title:eq('+i+')'), lang = $(this).data('lang');
                var te = title.val() == '';
                $(this).keyup(function(){
                    var text = this.value;

                    if(te) {
                        title.val(text);
                    }

                    var url = engine.content.translit(text, lang);
                    inp.val(url).trigger('change');
                });
            });

            $('#productsCategoriesForm #switchLanguages').find('button').click(function(){
                $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
                var code = $(this).data('code');
                $('#productsCategoriesForm .switch-lang:not(.lang-'+code+')').hide();
                $('#productsCategoriesForm .switch-lang.lang-' + code).show();
            });

        },
        create: function(parent_id)
        {
            var $this = this;
            var $tree = $('#productsCategories');
            engine.request.get('./plugins/productsCategories/createCategories/' + parent_id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#productsCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.productsCategories.create_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#productsCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#productsCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        },
        edit: function(id)
        {
            var $this = this;
            var $tree = $('#productsCategories');
            engine.request.get('./plugins/productsCategories/editCategories/' + id, function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    $('#productsCategoriesForm').submit();
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.productsCategories.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#productsCategoriesForm', function(d){
                    if(d.s){
                        dialog.dialog('destroy').remove();
                        $tree.jstree('refresh');
                    } else {
                        engine.showFormErrors('#productsCategoriesForm', d.i);
                    }
                });

                $this.before();

            });
        }
    }
};

$(document).ready(function(){
   engine.products.init();
});
