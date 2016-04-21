<form action="./banners/process/{$data.id}" method="post" id="form" class="form-horizontal" enctype="multipart/form-data">
    <div class="row">
        <div class="col-md-5">
            <fieldset>
                <legend>Зображення</legend>
                <div class="form-group">
                    <div class="img" style="text-align: center">
                        <img src="{if $data.img}{$data.img}{else}/themes/engine/assets/img/no-image.png{/if}" alt="no-image" style="max-width:160px; cursor: pointer;" id="bannersImage">
                        <p>Розмір: {$sizes.width}x{$sizes.height}px</p>
                        <input type="file" name="image" style="display: none" id="bannersImageUpload" onchange="engine.banners.encodeImageFileAsURL();">
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-7">
            <fieldset>
                <legend>Параметри</legend>

                <div class="form-group">
                    <label for="data_name" class="col-md-3 control-label">{$t.banners.name}</label>
                    <div class="col-md-9">
                        <input name="data[name]" id="data_name"  class="form-control" value="{$data.name}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_languages_id" class="col-md-3 control-label">{$t.banners.lang}</label>
                    <div class="col-md-9">
                        <select class="form-control" name="data[languages_id]" id="data_languages_id">
                            {foreach $languages as $lang}
                                <option value="{$lang.id}">{$lang.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-9 col-md-offset-1">
                        <input type="hidden"  name="data[published]"  class="form-control" value="0" >
                        <input type="checkbox" {if $data.published || $action=='create'}checked{/if} name="data[published]" id="data_published" value="1" > {$t.banners.published}
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-9 col-md-offset-1">
                        <input type="hidden"  name="data[permanent]"  class="form-control" value="0" >
                        <input type="checkbox" {if $data.permanent || $action=='create'}checked{/if} name="data[permanent]" id="data_permanent" value="1" > {$t.banners.permanent}
                    </div>
                </div>
                <div class="row" id="permanent_period" style="{if $data.permanent == 0 && $action == 'edit'}display:block{else}display:none{/if}">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="data_df" class="col-md-3 control-label">{$t.banners.df}</label>
                            <div class="col-md-9">
                                <input name="data[df]" id="data_df"  class="form-control" value="{$data.df}">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="data_dt" class="col-md-3 control-label">{$t.banners.dt}</label>
                            <div class="col-md-9">
                                <input name="data[dt]" id="data_dt"  class="form-control" value="{$data.dt}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_url" class="col-md-3 control-label">{$t.banners.url}</label>
                    <div class="col-md-9">
                        <input name="data[url]" id="data_url"  class="form-control" value="{$data.url}" placeholder="[a-z0-9_]+" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-9 col-md-offset-3">
                        <input type="hidden"  name="data[target]"  class="form-control" value="_self" >
                        <input type="checkbox" {if $data.target =='_blank'}checked{/if} name="data[target]" value="_blank" >
                        {$t.banners.target}
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    {if $place_id > 0}
        <input type="hidden" name="data[banners_places_id]" value="{$place_id}">
    {/if}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
</form>