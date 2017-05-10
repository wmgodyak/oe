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
                    title: 'Edit translation',
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });
            }
        })
    });
});