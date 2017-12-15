<fieldset class="gallery-uploader">
    <legend>{t('images.general.image')}
        <a href="javascript:;" class="hide-fieldset-content">
            <i class="fa fa-angle-down" aria-hidden="true"></i>
        </a>
    </legend>
    <div class="fieldset-wrapper" style="padding: 0 0 15px 0;">
        <div class="list-group">
            <div class="list-group-item dropzone-container">
                <div class="form-group">
                    <div id="imagesDz" data-target="module/run/images/upload/{$id}">
                        <div class="dz-message clearfix">
                            <i class="fa fa-picture-o"></i>
                            <span>{t('images.general.upload_i')}</span>
                            <div class="hover">
                                <i class="fa fa-download"></i>
                                <span>{t('images.general.dragHere')}</span>
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
                    <div class="dz-error-message">{/literal}{t('images.general.error')}{literal} <span data-dz-errormessage></span></div>
                </div>
                <div class="controls clearfix">
                    <a title="{/literal}{t('images.general.delete')}{literal}" class="trash-item" href="javascript:;"><i class="fa fa-trash"></i></a>
                </div>
                <div class="controls confirm-removal clearfix">
                    <a data-id="{id}" class="remove-item" href="javascript:;">{/literal}{t('images.general.yes')}{literal}</a>
                    <a class="remove-cancel" href="javascript:;">{/literal}{t('images.general.no')}{literal}</a>
                </div>
            </div>
        </div>
        <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>
    </div>
</script>
{/literal}

<script>
    var imagesList = {$images};
</script>