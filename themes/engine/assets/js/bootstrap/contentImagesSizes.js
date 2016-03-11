engine.contentImagesSizes = {
    init: function()
    {
        console.log('Init contentImagesSizes');

        $(document).on('click', '.b-contentImagesSizes-create', function(){
            engine.contentImagesSizes.create();
        });

        $(document).on('click', '.b-contentImagesSizes-edit', function(){
            engine.contentImagesSizes.edit($(this).data('id'));
        });

        $(document).on('click', '.b-contentImagesSizes-delete', function(){
            engine.contentImagesSizes.delete($(this).data('id'));
        });

        $(document).on('click', '.b-contentImagesSizes-crop', function(){
            engine.contentImagesSizes.crop($(this).data('id'));
        });

    },
    crop: function(id)
    {
        function resize(sizes_id, total, start)
        {
            console.log('resize', sizes_id, total, start);
            if(start >= total) {
                engine.alert(
                    'Ресайз зображень завершено.',
                    'Зроблено ресайз 100 зображень',
                    'success'
                );

                $("#resizeBox").hide();

                return false;
            }

            var percent =  100 / total, done = Math.round( start * percent ) ;
            $("#progress").find('div').css('width', done + '%');

             setTimeout(function(){
             start++;
             resize(sizes_id, total, start);
             }, 1500);


            /*engine.request.post({
                url: './contentImagesSizes/crop',
                data: {
                    start: start,
                    sizes_id: sizes_id
                },
                success: function(d){
                    if(d > 0){
                        start++;
                        resize(sizes_id, total, start);
                    }
                }
            });*/

            return false;
        }

        var dw = engine.confirm(t.contentImagesSizes.crop_confirm, function(){
            $("#resizeBox").css('display', 'block');
            engine.request.post({
                url: './contentImagesSizes/cropGetTotal',
                data: {
                    sizes_id: id
                },
                success: function(d){
                    alert(d);
                }
            });
            //resize(id, 100, 0);
            dw.dialog('close');
        });
    },

    create: function()
    {
        engine.request.get('./contentImagesSizes/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.contentImagesSizes.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            $('#content_types').select2();

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('contentImagesSizes');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './contentImagesSizes/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.contentImagesSizes.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });
                $('#content_types').select2();
                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('contentImagesSizes');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.contentImagesSizes.delete_question,
            function()
            {
                engine.request.get('./contentImagesSizes/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('contentImagesSizes');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.contentImagesSizes.init();
});