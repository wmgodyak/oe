<form id="form" action="seo/process" method="post"  class="form-horizontal row">
    <div><br></div>
    <div class="col-md-8 col-md-offset-2">
        {literal}
            <pre>Ви можете використовувати наступні блоки:
                {title} - заголовок сторінки,
                {keywords} - ключові слова сторінки,
                {h1} - заголовок першого рвіня сторінки,
                {description} - опис сторінки,
                {company_name} - Назва компанії,
                {company_phone} - телефон,
                {category} - категорія,
                {delimiter} - розділювач, напр "/"
            </pre>
        {/literal}
        {*<pre>{print_r($data)}</pre>*}
        <div id="tabs_seo">
            <ul>
                {foreach $types as $type}
                    <li><a href="{$com_url}#{$type.type}">{$type.name}</a></li>
                {/foreach}
            </ul>
            {foreach $types as $type}
                <div id="{$type.type}">
                    {foreach $languages as $lang}
                        <div class="form-group">
                            <label for="seo_{$type.type}_{$lang.id}_title" class="col-md-3 control-label required">Title ({$lang.name})</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="seo[{$type.type}][{$lang.id}][title]" id="seo_{$type.type}_title" value="{$data[$type.type][$lang.id].title}" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="seo_{$type.type}_{$lang.id}_keywords" class="col-md-3 control-label required">Keywords ({$lang.name})</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="seo[{$type.type}][{$lang.id}][keywords]" id="seo_{$type.type}_keywords" value="{$data[$type.type][$lang.id].keywords}"  required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="seo_{$type.type}_{$lang.id}_description" class="col-md-3 control-label required">Description ({$lang.name})</label>
                            <div class="col-md-9">
                                <textarea class="form-control" name="seo[{$type.type}][{$lang.id}][description]" id="seo_{$type.type}_description" required>{$data[$type.type][$lang.id].description}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="seo_{$type.type}_{$lang.id}_h1" class="col-md-3 control-label required">Heading ({$lang.name})</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="seo[{$type.type}][{$lang.id}][h1]" id="seo_{$type.type}_h1" value="{$data[$type.type][$lang.id].h1}"  required>
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
            <h3>{$t.seo.sys_info}</h3>
            <ul>
                {foreach $sys_info as $k=>$v}
                    {assign var="name" value="sys_info_$k"}
                    <li>{$t.seo[$name]}: {$v}</li>
                {/foreach}
            </ul>

            <h3>{$t.seo.dir_perm}</h3>
            <ul>
                {foreach $dir_perm as $k=>$v}
                    <li>{$k}: {if $v == 1}{$t.seo.dir_perm_yes}{else}{$t.seo.dir_perm_no}{/if}</li>
                {/foreach}
            </ul>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
</form>