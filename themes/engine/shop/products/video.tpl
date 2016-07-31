<fieldset>
    <legend>Відео</legend>
    <p>Вставте сюди посилання на відео з Youtube або його ІД. Наприклад https://www.youtube.com/watch?v=AVJA70zcU50 , ІД: AVJA70zcU50 </p>
    <div class="form-group">
        <label for="video_1" class="col-md-2 control-label">Відео (1)</label>
        <div class="col-md-10">
            {assign var ='video_1' value=$app->contentMeta->get($content.id, 'video_1', true)}
            <div class="yt-img yt-im-video_1" style="position: relative;">
                {if $video_1 != ''}
                    <img style="max-width: 120px;" src="http://img.youtube.com/vi/{$video_1}/0.jpg" alt="">
                    <a href="javascript:;" title="Видалити" class="yt-remove" data-id="video_1" style="position: absolute; top:5px; right:5px;"><i class="fa fa-remove"></i></a>
                {/if}
            </div>
            <input name="content_meta[video_1]" id="video_1" class="form-control yt-video" placeholder="https://www.youtube.com/watch?v=AVJA70zcU50" value="{$video_1}" >
        </div>
    </div>
    <div class="form-group">
        <label for="video_2" class="col-md-2 control-label">Відео (2)</label>
        <div class="col-md-10">
            {assign var ='video_2' value=$app->contentMeta->get($content.id, 'video_2', true)}
            <div class="yt-img yt-im-video_2" style="position: relative;">
                {if $video_2 != ''}
                    <img style="max-width: 120px;" src="http://img.youtube.com/vi/{$video_2}/0.jpg" alt="">
                    <a href="javascript:;" title="Видалити" class="yt-remove" data-id="video_2" style="position: absolute; top:5px; right:5px;"><i class="fa fa-remove"></i></a>
                {/if}
            </div>
            <input name="content_meta[video_2]" id="video_2" class="form-control yt-video" placeholder="https://www.youtube.com/watch?v=AVJA70zcU50" value="{$video_2}" >
        </div>
    </div>
    <div class="form-group">
        <label for="video_3" class="col-md-2 control-label">Відео (3)</label>
        <div class="col-md-10">
            {assign var ='video_3' value=$app->contentMeta->get($content.id, 'video_3', true)}
            <div class="yt-img yt-im-video_3" style="position: relative;">
                {if $video_3 != ''}
                    <img style="max-width: 120px;" src="http://img.youtube.com/vi/{$video_3}/0.jpg" alt="">
                    <a href="javascript:;" title="Видалити" class="yt-remove" data-id="video_3" style="position: absolute; top:5px; right:5px;"><i class="fa fa-remove"></i></a>
                {/if}
            </div>
            <input name="content_meta[video_3]" id="video_3" class="form-control yt-video" placeholder="https://www.youtube.com/watch?v=AVJA70zcU50" value="{$video_3}" >
        </div>
    </div>
</fieldset>
{literal}
<script>
    $(document).ready(function(){
        $(document).on('click', '.yt-remove', function(){
            var v = $(this).data('id');
            $('.yt-im-'+v).html('');
            $('input#'+v).val('');
        });

        $(document).on('change', '.yt-video', function(){
            var url = this.value, im = $(this).prev();
            var video_id = url.match(/(?:https?:\/{2})?(?:w{3}\.)?youtu(?:be)?\.(?:com|be)(?:\/watch\?v=|\/)([^\s&]+)/);
            if(video_id != null) {
                this.value = video_id[1];
                im.html('<img style="max-width: 120px;" src="http://img.youtube.com/vi/'+video_id[1]+'/0.jpg" alt="">');
            }
        });
    });
</script>
{/literal}