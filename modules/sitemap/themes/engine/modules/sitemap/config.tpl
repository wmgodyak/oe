<h3>Виберіть типи контенту або підтипи, які портібно завантажувати в Sitemap</h3>
{foreach $types->get() as $type}
    <div class="form-group">
        <div class="col-md-12" style="text-align: left;">
            <div class="row">
                <div class="col-md-4">
                    <input name="config[types][{$type.id}][id]" value="0" type="hidden">
                    <input name="config[types][{$type.id}][id]" id="type_{$type.id}" value="{$type.id}" type="checkbox" class="form-control" required {if isset($settings.modules.Sitemap.config.types[{$type.id}].id) && $settings.modules.Sitemap.config.types[{$type.id}].id == $type.id}checked{/if}>
                    <label for="">{$type.name}</label>
                </div>
                <div class="col-md-4">
                    <select name="config[types][{$type.id}][changefreq]">
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'always'}selected{/if}>always</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'hourly'}selected{/if}>hourly</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'daily'}selected{/if}>daily</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'weekly'}selected{/if}>weekly</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'monthly'}selected{/if}>monthly</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'yearly'}selected{/if}>yearly</option>
                        <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].changefreq) && $settings.modules.Sitemap.config.types[{$type.id}].changefreq == 'never'}selected{/if}>never</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <select name="config[types][{$type.id}][priority]">
                        {for $i=0; $i< 11; $i++}
                            <option {if isset($settings.modules.Sitemap.config.types[{$type.id}].priority) && str_replace(',', '.', $settings.modules.Sitemap.config.types[{$type.id}].priority) == ($i / 10)}selected{/if} value="{($i / 10)}">{($i / 10)}</option>
                        {/for}
                    </select>
                </div>
            </div>
        </div>
    </div>
    {if $type.isfolder}
        {foreach $types->get($type.id) as $subtype}
            <div class="form-group" style="text-align: left;">

                <div class="col-md-11 col-md-offset-1">

                    <div class="row">
                        <div class="col-md-4">
                            <input name="config[types][{$subtype.id}][id]" value="0" type="hidden">
                            <input name="config[types][{$subtype.id}][id]" id="type_{$subtype.id}" value="{$subtype.id}" type="checkbox" class="form-control" required {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].id) && $settings.modules.Sitemap.config.types[{$subtype.id}].id == $subtype.id}checked{/if}>
                            <label for="">{$subtype.name}</label>
                        </div>
                        <div class="col-md-4">
                            <select name="config[types][{$subtype.id}][changefreq]">
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'always'}selected{/if}>always</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'hourly'}selected{/if}>hourly</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'daily'}selected{/if}>daily</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'weekly'}selected{/if}>weekly</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'monthly'}selected{/if}>monthly</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'yearly'}selected{/if}>yearly</option>
                                <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].changefreq) && $settings.modules.Sitemap.config.types[{$subtype.id}].changefreq == 'never'}selected{/if}>never</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <select name="config[types][{$subtype.id}][priority]">
                                {for $i=0; $i< 11; $i++}
                                    <option {if isset($settings.modules.Sitemap.config.types[{$subtype.id}].priority) && str_replace(',', '.', $settings.modules.Sitemap.config.types[{$subtype.id}].priority) == ($i / 10)}selected{/if} value="{($i / 10)}">{($i / 10)}</option>
                                {/for}
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    {/if}
{/foreach}