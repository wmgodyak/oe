{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2017 Otakoyi.com
 * Date: 2017-03-21
 * @name index
 *}
<!DOCTYPE html>
<!--[if lt IE 9 ]> <html lang="en" dir="ltr" class="no-js ie-old"> <![endif]-->
<!--[if IE 9 ]> <html lang="en" dir="ltr" class="no-js ie9"> <![endif]-->
<!--[if IE 10 ]> <html lang="en" dir="ltr" class="no-js ie10"> <![endif]-->
<!--[if (gt IE 10)|!(IE)]><!-->
<html dir="ltr" class="no-js"  data-id="{$page.id}" lang="{$page.languages_code}" data-type="{$page.types_id}" data-template="{$page.template}">
<!--<![endif]-->
{include file="chunks/head.tpl"}

<body id="body" class="wide-layout preloader-active">
    {$events->call('body.top')}

    {$events->call('body.before')}
        {block name=body}{$body}{/block}
    {$events->call('body.after')}

    {include file="chunks/scripts.tpl"}
    {$events->call('body.bottom')}
</body>

</html>