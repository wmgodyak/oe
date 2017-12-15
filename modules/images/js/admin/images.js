var images = {
    init: function () {
        if($('#imagesDz').length == 0) return;

        Dropzone.options.contentImagesDropzone = false; // Prevent Dropzone from auto discovering this element
        var content_id = $('#content_id').val();

        this.makeDropzone();

        $('.gallery-uploader').on('click', '.remove-item', function(event) {
            event.preventDefault();

            var id = $(this).data('id');
            images.removeImage(id, this);
        });

        $('.gallery-uploader').on('click', '.trash-item, .remove-cancel', function(event) {
            event.preventDefault();

            $(this).parents('.dz-preview').find('.controls').fadeToggle('150');
        });
        $('.gallery-uploader').on('click', '.add', function(event) {
            event.preventDefault();

            $(this).fadeOut(75, function () {
                $(this).parents('.gallery-uploader').toggleClass('active');
                $(this).siblings('.add').fadeIn(150);
            });
        });

        $('#edit-image-modal').on('click', '.btn-success', function(event) {
            $('.editing-item .dz-filename span').text($('#edit-image-modal #image-caption').val());
        });

        $(document).on('click', '.crop-image', function(){
            var id = $(this).data('id');
            images.crop(id);
        });

        var tpl = $('#dzTemplate').html(),
            cnt = $('.gallery-container');

        for (var i=0;i<imagesList.length; i++){
            var img = imagesList[i],
                item = tpl
                .toString()
                .replace (/{id}/g, img.id)
                .replace (/{src}/g, img.src);
            cnt.append(item);
        }

        this.initSortable();
    },
    initSortable: function(){
        var g =$( ".gallery-container" );

        g.sortable({
            //placeholder: "upload-placeholder",
            update: function( event, ui ) {
                var newOrder = $(this).sortable('toArray').toString();
                engine.request.post({
                    url:'module/run/images/sort',
                    data: {
                        order: newOrder
                    }
                });
            }
        });
        g.disableSelection();
    },
    removeImage: function(id, e)
    {
        engine.request.get('module/run/images/delete/'+id, function(d){
            $(e).parents('.dz-preview').fadeOut(250, function () {
                $(e).remove();
            });
        });
    },
    crop: function(id){
    },
    makeDropzone: function () {

        var imagesContainer = $('#imagesDz');
        var url = imagesContainer.data('target');
        //var template = _.template(document.getElementById('dzTemplate').innerHTML);
        var template = document.getElementById('dzTemplate').innerHTML;
        imagesContainer.dropzone({
            paramName: "image", // The name that will be used to transfer the file
            maxFilesize: 10, // MB
            acceptedFiles: '.jpg,.jpeg,.png,.gif',
            uploadMultiple: true,
            previewsContainer: '.gallery-container',
            previewTemplate: template,
            parallelUploads:1,
            url: url,
            thumbnailWidth: 125,
            thumbnailHeight: 125,
            sending:  function(file, xhr, formData){
                formData.append('token', TOKEN);
            },
            init: function() {
                this.on("addedfile", function(file) {
//                    console.log(file);
                });
//                this.on("success", function(file) {
//                    console.log(file);
//                });
            },
            success: function(file, data) {
                var div = $('.gallery-container > div:last');
                div.attr('id', data.id);

                var str = div.html()
                    .toString()
                    .replace (/{id}/g, data.id)
                //    .replace (/{imageName}/g, data.name);
                div.html(str);

                images.initSortable();
                return true;
            }
        });
    }
};
var imagesSizes = {
    init: function()
    {
        $(document).on('click', '.b-imagesSizes-create', function(){
            imagesSizes.create();
        });

        $(document).on('click', '.b-imagesSizes-edit', function(){
            imagesSizes.edit($(this).data('id'));
        });

        $(document).on('click', '.b-imagesSizes-delete', function(){
            imagesSizes.delete($(this).data('id'));
        });

        $(document).on('click', '.b-imagesSizes-crop', function(){
            imagesSizes.crop($(this).data('id'));
        });

    },
    crop: function(id)
    {
        function resizeSuccess(total)
        {
            engine.alert(
                t.images.imagesSizes.resize.success.title +
                t.images.imagesSizes.resize.success.resized + total + t.images.imagesSizes.resize.success.images,
                'success'
            );

            $("#resizeBox").hide();
        }

        function resize(sizes_id, total, start)
        {

            if (start >= total) {
                resizeSuccess(total);
                return false;
            }

            var percent =  100 / total, done = Math.round( start * percent ) ;
            $("#progress").find('div').css('width', done + '%');

            engine.request.post({
                url: './module/run/images/imagesSizes/resizeItems',
                data: {
                    start: start,
                    sizes_id: sizes_id
                },
                success: function(d){
                    if (d > 0){
                        start++;
                        resize(sizes_id, total, start);
                    } else {
                        resizeSuccess(total);
                    }
                }
            });

            return false;
        }

        var dw = engine.confirm(t.images.imagesSizes.crop_confirm, function(){
            $("#resizeBox").css('display', 'block');
            engine.request.post({
                url: './module/run/images/imagesSizes/resizeGetTotal',
                data: {
                    sizes_id: id
                },
                success: function(d){
                    resize(id, d, 0);
                }
            });
            dw.dialog('close');
        });
    },

    create: function()
    {
        engine.request.get('./module/run/images/imagesSizes/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.images.imagesSizes.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            $('#content_types').select2();

            $("#data_watermark").change(function(){
                if ($(this).is(':checked')){
                    $('.watermark-settings').show();
                } else {
                    $('.watermark-settings').hide();
                }
            });

            engine.validateAjaxForm('#form', function(d){
                if (d.s){
                    engine.refreshDataTable('imagesSizesList');
                    dialog.dialog('close');
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './module/run/images/imagesSizes/edit/' + id,
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
                    title: t.images.imagesSizes.action_edit,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#content_types').select2();
                $("#data_watermark").change(function(){
                    if ($(this).is(':checked')){
                        $('.watermark-settings').show();
                    } else {
                        $('.watermark-settings').hide();
                    }
                });

                engine.validateAjaxForm('#form', function(d){
                    if (d.s){
                        engine.refreshDataTable('imagesSizesList');
                        dialog.dialog('close');
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        var w = engine.confirm
        (
            t.images.imagesSizes.delete_question,
            function()
            {
                engine.request.get('./module/run/images/imagesSizes/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('imagesSizesList');
                        w.dialog('close');
                    }
                });

            }
        );
    }
};

$(document).ready(function() {
    images.init();
    imagesSizes.init();
});