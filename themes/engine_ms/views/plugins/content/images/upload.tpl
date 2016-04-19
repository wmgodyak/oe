<fieldset class="gallery-uploader">
    <legend>{$t.contentImages.image}
    <a href="javascript:;" class="add insert">
        <i class="fa fa-plus-circle"></i>
        <span>{$t.common.create}</span>
    </a>
    <a href="javascript:;" class="add finished">
        <i class="fa fa-minus-circle"></i>
        <span>{$t.contentImages.remove}</span>
    </a>
    </legend>
    <div class="list-group">
        <div class="list-group-item dropzone-container">
            <div class="form-group">
                <div id="contentImagesDz" data-target="plugins/contentImages/upload/{$id}">
                    <div class="dz-message clearfix">
                        <i class="fa fa-picture-o"></i>
                        <span>{$t.contentImages.upload_i}</span>
                        <div class="hover">
                            <i class="fa fa-download"></i>
                            <span>{$t.contentImages.dragHere}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="list-group-item preview-container">
            <div class="form-group">
                <div class="gallery-container"></div>
            </div>
        </div>
    </div>
</fieldset>
{literal}
<script type="text/template" id="dzTemplate" >
    <div class="dz-preview dz-file-preview" id='im-{id}'>
    <div class="dz-details">
            <img data-dz-thumbnail src="{src}"/>
            <div class="overlay">
                <div class="dz-filename text-overflow-hidden"><span data-dz-name></span></div>
                <div class="status">
                        <a class="dz-error-mark remove-item" href="javascript:;"><i class="icon-remove-sign"></i></a>
                        <div class="dz-error-message">Помилка <span data-dz-errormessage></span></div>
                </div>
                <div class="controls clearfix">
                        <a title="Обрізати" data-id="{id}" class="crop-image" href="javascript:;"><i class="fa fa-crop"></i></a>
                        <a title="Видалити" class="trash-item" href="javascript:;"><i class="fa fa-trash"></i></a>
                </div>
                <div class="controls confirm-removal clearfix">
                    <a data-id="{id}" class="remove-item" href="javascript:;">Так</a>
                    <a class="remove-cancel" href="javascript:;">Ні</a>
                </div>
                </div>
            </div>
            <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
    </div>
</script>
{/literal}

<script>
    var contentImagesList = {$images};
    $(document).ready(function(){
       engine.require('contentImages');
    });
</script>