<form action="module/run/newsletter/campaigns/process" method="post" id="form" class="form-horizontal">
    {$events->call('newsletter.campaigns.form.top', $data)}
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            {$events->call('newsletter.campaigns.form.main.top', $data)}
            <fieldset>
                <legend>Settings</legend>
                <div class="form-group">
                    <label for="data_name" class="col-md-3 control-label">Name</label>
                    <div class="col-md-9">
                        <input name="data[name]" id="data_name" class="form-control" required value="{$data.name}">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-3 col-md-9">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label for="data_smtp" class="">
                                    <input type="hidden" name="data[smtp]" value="0">
                                    <input class="switch" type="checkbox" name="data[smtp]" id="data_smtp" value="1" {if $data.smtp==1 }checked{/if}>
                                    <span class="l-check">Use SMTP</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_sender_name" class="col-md-3 control-label">Sender Name</label>
                    <div class="col-md-9">
                        <input name="data[sender_name]" id="data_sender_name" class="form-control check-smtp" required value="{$data.sender_name}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_sender_email" class="col-md-3 control-label">Sender Email</label>
                    <div class="col-md-9">
                        <input name="data[sender_email]" id="data_sender_email" type="email" required class="form-control  check-smtp" value="{$data.sender_email}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_sender_email" class="col-md-3 control-label">Subscribers groups</label>
                    <div class="col-md-9">
                        <select name="groups[]" multiple id="groups" required class="form-control">
                            {foreach $groups as $group}
                                <option value="{$group.id}" {if $data.groups && in_array($group.id, $data.groups)}selected{/if}>{$group.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>Message</legend>
                {if count($languages) > 1}
                    <div class="form-group">
                        <label class="col-md-2 control-label">{$t.common.lang}</label>
                        <div class="btn-group col-md-6" id="switchLanguages" role="group">
                            {foreach $languages as $i=>$lang}
                                {if $lang.is_main == 1}{assign var='mainLang' value=$lang }{/if}
                                <button type="button" class="btn {if $i == 0}btn-primary{/if}" data-code="{$lang.code}">{$lang.code}</button>
                            {/foreach}
                            {$events->call('data.main.languages.switcher', $mainLang)}
                        </div>
                    </div>
                {/if}
                {*<pre>{print_r($data)}</pre>*}
                {foreach $languages as $i=>$lang}
                    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
                        <label for="info_{$lang.id}_subject" class="col-md-2 control-label">Subject</label>
                        <div class="col-md-10">
                            <input type="text" class="form-control info-subject lang-{$lang.code}" name="info[{$lang.id}][subject]" id="info_{$lang.id}_subject" required="" placeholder="[a-zA-Zа-яА-Я0-9]+" value="{if isset($data.info[$lang.id].subject)}{$data.info[$lang.id].subject}{/if}" data-lang="{$lang.code}">
                        </div>
                    </div>
                    <legend>Html body</legend>
                    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
                        <div class="col-md-12">
                            <textarea class="form-control info-htmlbody ckeditor  lang-{$lang.code}" name="info[{$lang.id}][htmlbody]" id="info_{$lang.code}_body">{$data.info[$lang.id].htmlbody}</textarea>
                        </div>
                    </div>
                    <legend>Text body</legend>
                    <div class="form-group lang-{$lang.code} switch-lang" {if $i>0}style="display:none"{/if}>
                        <div class="col-md-12">
                            <textarea style="height: 500px;" class="form-control info-textbody lang-{$lang.code}" name="info[{$lang.id}][textbody]" id="info_{$lang.code}_body">{$data.info[$lang.id].textbody}</textarea>
                        </div>
                    </div>
                {/foreach}
                {$events->call('data.main', $data)}
            </fieldset>
            {$events->call('newsletter.campaigns.form.main.bottom', $data)}
        </div>
    </div>
    {$events->call('newsletter.campaigns.form.bottom', $data)}
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="{$action}">
    {if isset($data.id)}
        <input type="hidden" name="id" value="{$data.id}">
    {/if}
</form>