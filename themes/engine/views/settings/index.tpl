<form id="form" action="settings/process" method="post"  class="form-horizontal row">
    <div><br></div>
    <div class="col-md-8 col-md-offset-2">
        <div id="tabs_settings">
            <ul>
                {foreach $items as $group=>$a}
                    {assign var="item_name" value="tab_$group"}
                    <li><a href="{$com_url}#{$group}">{$t.settings[$item_name]}</a></li>
                {/foreach}
            </ul>
            {foreach $items as $group=>$item}
                <div id="{$group}">
                    {foreach $item as $a}
                        {assign var="title" value="title_`$a.name`"}
                        {assign var="desc" value="desc_`$a.name`"}
                        <div class="form-group">
                            <label for="settings_{$a.name}" class="col-md-3 control-label required">{$t.settings[$title]}</label>
                            <div class="col-md-9">
                                {if $a.type == 'text'}
                                    <input type="text" class="form-control" name="settings[{$a.name}]" id="settings_{$a.name}" value="{$a.value}" {if $a.required}required{/if}>
                                {elseif $a.type=='textarea'}
                                    <textarea class="form-control" name="settings[{$a.name}]" id="settings_{$a.name}" {if $a.required}required{/if}>{$a.value}</textarea>
                                {/if}
                                <p class="help-block">{$t.settings[$desc]}</p>
                            </div>
                        </div>
                    {/foreach}
                </div>
            {/foreach}
        </div>
        <div class="clearfix"></div>
    </div>

    <div class="col-md-8 col-md-offset-2">
        <div class="alert">
            <h3>{$t.settings.sys_info}</h3>
            <ul>
                {foreach $sys_info as $k=>$v}
                    {assign var="name" value="sys_info_$k"}
                    <li>{$t.settings[$name]}: {$v}</li>
                {/foreach}
            </ul>

            <h3>{$t.settings.dir_perm}</h3>
            <ul>
                {foreach $dir_perm as $k=>$v}
                    <li>{$k}: {if $v == 1}{$t.settings.dir_perm_yes}{else}{$t.settings.dir_perm_no}{/if}</li>
                {/foreach}
            </ul>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
</form>