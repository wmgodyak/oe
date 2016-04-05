<fieldset id="contentFeaturesFs" data-id="{$content.id}">
    <legend>{$t.features.legend_features}
        {*<pre>{print_r($content)}</pre>*}
        <script>var features_settings = {json_encode($content.settings.type.features)}</script>
        <a href="javascript:;" type="button" class="b-ct-features-add" data-id="{$content.id}" data-parent="0" >
            <i class="fa fa-plus-circle"></i> Додати
        </a>
    </legend>
    <div id="content_features_0">
        {$content_features}
    </div>
</fieldset>