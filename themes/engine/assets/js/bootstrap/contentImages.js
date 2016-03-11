engine.contentImages = {
    init: function () {
        if($('#contentImagesDz').length == 0) return;

        Dropzone.options.contentImagesDropzone = false; // Prevent Dropzone from auto discovering this element
        var content_id = $('#content_id').val();

        this.makeDropzone();

        $('.gallery-uploader').on('click', '.remove-item', function(event) {
            event.preventDefault();
            var id = $(this).data('id');
            engine.contentImages.removeImage(id, this);
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
            engine.contentImages.crop(id);
        });

        var tpl = $('#dzTemplate').html(),
            cnt = $('.gallery-container');
        for(var i=0;i<contentImagesList.length; i++){
            var img = contentImagesList[i];
            var item = tpl
                        .toString()
                        .replace (/{id}/g, img.id)
                        .replace (/{src}/g, img.src);
            cnt.append(item);
        }
    },
    removeImage: function(id, e)
    {
        engine.request.get('./plugins/ContentImages/delete/'+id, function(d){
            if(d == 1){
                $(e).parents('.dz-preview').fadeOut(250, function () {
                    $(e).remove();
                });
            }
        });
    },
    crop: function(id){

    },
    makeDropzone: function () {

        var imagesContainer = $('#contentImagesDz');
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
                return true;
            }
        });
    }
};

$(document).ready(function(){
    engine.contentImages.init();
});