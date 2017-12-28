$(document).ready(function(){
    $(document).on('click', '.b-translations-edit', function(){
        var id = $(this).data('id'), path = $(this).data('path');

        engine.request.post({
            url: './translations/edit',
            data:{
                id: id,
                path: path
            },
            success: function(res){
                var bi = "Save";
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: res,
                    title: t.translations.action_edit + " - " + id,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        dialog.dialog('close');
                        engine.refreshDataTable('translations');
                    }
                });
            }
        })
    });
});