<form id="form" action="translations/process" method="post" class="form-horizontal row">
    <div><br></div>
    {if $error}
        <div class="alert alert-error"><p>{$error}</p></div>
        {else}
        <div class="col-md-8 col-md-offset-2">
            <div id="translationsTabs" class="ui-tabs-vertical">
                <ul>
                    <li><a href="{$com_url}#common">Загальні</a></li>
                    {foreach $modules as $module=> $meta}
                        <li><a href="{$com_url}#{$module}">{$meta.name}</a></li>
                    {/foreach}
                </ul>
                <div id="common">
                    <table class="table">
                        <tr>
                            <th>Ключ</th>
                            {foreach $langs as $lang}
                                <th>{$lang.name}</th>
                            {/foreach}
                        </tr>
                        {foreach $common[$front] as $code => $a}
                            {foreach $a as $k=>$v}
                                <tr>
                                    <td>{$code}{if is_array($common[$lang.code][$code])}.{$k}{/if}</td>
                                    {foreach $langs as $lang}
                                        <td>
                                            <input
                                                    class="form-control"
                                                    name="common[{$lang.code}][{$code}]{if is_array($common[$lang.code][$code])}[{$k}]{/if}"
                                                    value="{if is_array($common[$lang.code][$code])}{$common[$lang.code][$code][$k]}{else}{$common[$lang.code][$code]}{/if}"
                                                    required>
                                        </td>
                                    {/foreach}
                                </tr>
                            {/foreach}
                        {/foreach}
                    </table>
                    {*{d($common)}*}
                </div>
                {foreach $modules as $module=> $meta}
                    <div id="{$module}">
                        <table class="table">
                            <tr>
                                <th>Ключ</th>
                                {foreach $langs as $lang}
                                    <th>{$lang.name}</th>
                                {/foreach}
                            </tr>
                            {foreach $meta.translations[$front] as $code => $a}
                                {foreach $a as $k=>$v}
                                    <tr>
                                        <td>{$code}{if is_array($meta.translations[$lang.code][$code])}.{$k}{/if}</td>
                                        {foreach $langs as $lang}
                                            <td>
                                                <input
                                                        class="form-control"
                                                        name="modules[{$module}][{$lang.code}][{$code}]{if is_array($meta.translations[$lang.code][$code])}[{$k}]{/if}"
                                                        value="{if is_array($meta.translations[$lang.code][$code])}{$meta.translations[$lang.code][$code][$k]}{else}{$meta.translations[$lang.code][$code]}{/if}"
                                                        required>
                                            </td>
                                        {/foreach}
                                    </tr>
                                {/foreach}
                            {/foreach}
                        </table>
                        {*{d($meta.translations)}*}
                    </div>
                {/foreach}
            </div>
            <div class="clearfix"></div>
        </div>
    {/if}
    <input type="hidden" name="token" value="{$token}">
</form>