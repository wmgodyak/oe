{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:13:48+02:00
 * @name index
 *}
<!DOCTYPE html>
<html data-id="{$page.id}" lang="{$page.languages_code}" data-type="{$page.types_id}" data-template="{$page.template}">
    {include file="chunks/head.tpl"}
    <body>
        <div class="container" style="margin-top: 50px;">
            {include file="chunks/nav.tpl"}

            {$events->call('body.before')}
            {block name=body}{$body}{/block}
            {$events->call('body.after')}

            {include file="chunks/footer.tpl"}
        </div><!-- /.container -->
        {include file="chunks/scripts.tpl"}
        {$events->call('body.bottom')}
    </body>
</html>