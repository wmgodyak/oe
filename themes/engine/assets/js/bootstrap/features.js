/**
 * Created by wg on 08.02.16.
 */
engine.features = {
    init: function()
    {
        console.log('engine.features.init() -> OK');
        $(document).on('click', '.b-features-delete', function(){
            var id = $(this).data('id');
            engine.features.delete(id);
        });
        $(document).on('click', '.b-features-pub', function(){
            var id = $(this).data('id');
            engine.features.pub(id);
        });
        $(document).on('click', '.b-features-hide', function(){
            var id = $(this).data('id');
            engine.features.hide(id);
        });
        $(document).on('click', '.b-features-add-value', function(){
            var id = $(this).data('id');
            engine.features.addValue(id);
        });

        $(document).on('click', '.b-features-edit-value', function(){
            var id = $(this).data('id');
            engine.features.editValue(id);
        });

        $('#data_type')
            .change(function(){
                if(this.value == 'select'){
                    $('.fg-show-filter, .fg-multiple').show();
                } else {
                    $('.fg-show-filter, .fg-multiple').hide();
                }
            })
            .trigger('change');

        $(document).on('click', '.b-features-select-ct', function(){
            var id = $(this).data('id');
            engine.features.content.select(id);
        });
        $(document).on('click', '.b-features-delete-ct', function(){
            var id = $(this).data('id');
            engine.features.content.del(id);
        });

        // selected content
        var sc = selected_content || [];
        engine.features.content.refresh(sc)
    },
    content: {
        select : function(features_id)
        {
            engine.request.get('features/selectContent/' + features_id, function (d) {
                var pw = engine.dialog({
                    content: d,
                    title: 'Прикріпити до ...',
                    autoOpen: true,
                    width: 500,
                    modal: true,
                    buttons: {
                        "Зберегти": function(){
                            $('#formFeaturesContent').submit();
                        }
                    }
                });

                $('#data_content_id, #data_types_id, #data_subtypes_id').select2();

                $('#data_types_id')
                    .change(function(){
                        $("#data_subtypes_id,#data_content_id").html('').attr('disabled', true);
                        var parent_id = parseInt(this.value);
                            engine.request.get('features/getTypes/'+parent_id, function(d){
                                //if(d.o.length == 0){
                                //    return ;
                                //}
                                var out = '<option value="">Всі</option>';
                               $(d.o).each(function(i,e){
                                   out += '<option value="'+ e.id +'">'+ e.name +'</option>';
                               });
                               $("#data_subtypes_id").html(out).removeAttr('disabled').trigger('change');
                            });
                    })
                    .trigger('change');

                $("#data_subtypes_id").change(function(){
                    $("#data_content_id").html('').attr('disabled', true);
                    var type_id    = $('#data_types_id').find('option:selected').attr('value');
                    var subtype_id = this.value;
                    engine.request.get('features/getContent/'+type_id + '/' + subtype_id, function(d){
                        //if(d.o.length == 0){
                        //    return ;
                        //}
                        var out = '<option value="">Всі</option>';
                        $(d.o).each(function(i,e){
                            out += '<option value="'+ e.id +'">'+ e.name +'</option>';
                        });
                        $("#data_content_id").html(out).removeAttr('disabled');
                    });
                });


                engine.validateAjaxForm('#formFeaturesContent', function(d){
                    if(d.s){
                        pw.dialog('destroy').remove();
                        engine.features.content.refresh(d.sc);
                    }
                });
            });
        },
        del: function(id)
        {
           var w = engine.confirm("Дійсно видалити вибраний запис?", function(){
               engine.request.get('features/deleteSelectedContent/'+id, function(d)
               {
                   if(d.s){

                       w.dialog('destroy').remove();
                       $("#f-sc-"+id).remove();
                   }
               },'json');
            });
        },
        refresh: function(data)
        {
            if(data.length == 0) return ;
            var tmpl = _.template($('#ctList').html());
            $("#content_types").html(tmpl({items: data}));
        }
    },
    onCreateSuccess: function(d)
    {
        location.href = "./features";
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.features.delete_confirm,
            function()
            {
                engine.request.get('./features/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('features');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    pub: function (id) {
        engine.request.get('features/pub/' + id, function (d) {
            engine.refreshDataTable('features');
        });
    },
    hide: function (id) {
        engine.request.get('features/hide/' + id, function (d) {
            engine.refreshDataTable('features');
        });
    },
    addValue: function (id) {
        engine.request.get('features/addValue/' + id, function (d) {
           var pw = engine.dialog({
                content: d,
                title: 'Створення властивості',
                autoOpen: true,
                width: 500,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#formFeaturesValue').submit();
                    }
                }
            });

            engine.validateAjaxForm('#formFeaturesValue', function(d){
                if(d.s){
                    pw.dialog('destroy').remove();
                    engine.refreshDataTable('features');
                }
            });
        });
    },
    editValue: function (id) {
        engine.request.get('features/editValue/' + id, function (d) {
           var pw = engine.dialog({
                content: d,
                title: 'Редагування властивості',
                autoOpen: true,
                width: 500,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#formFeaturesValue').submit();
                    }
                }
            });

            engine.validateAjaxForm('#formFeaturesValue', function(d){
                if(d.s){
                    pw.dialog('destroy').remove();
                    engine.refreshDataTable('features');
                }
            });
        });
    }
};

$(document).ready(function(){
   engine.features.init();
});