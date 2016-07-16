<fieldset id="contentFeaturesFs" data-id="{$content.id}">
    <legend>{$t.features.legend_features}
        {*<pre>{print_r($content)}</pre>*}
        <script>var features_settings = {if isset($content.settings.type.features)}{json_encode($content.settings.type.features)}{else}null{/if}</script>
        <a href="javascript:;" type="button" class="b-ct-features-add" data-id="{$content.id}" data-parent="0" title="Додати">
            <i class="fa fa-plus-circle"></i>
        </a>
    </legend>
    <div id="content_features_0">
        {if isset($content_features)}{$content_features}{/if}
    </div>
    {$events->call('content.features', array($content))}
</fieldset>