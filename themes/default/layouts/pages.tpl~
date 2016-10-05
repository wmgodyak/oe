{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-04T22:37:00+03:00
 * @name home
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}


    <!-- begin article-page -->
    <div class="article-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container">

            <!-- begin article-page__content -->
            <div class="article-page__content">
                <h1>{$page.name}{if $smarty.session.engine.admin.id > 0}&nbsp;<a title="Редагувати в адмінстративній частині" target="_blank" href="/engine/pages/edit/{$page.id}">
                            <img src="{$theme_url}/assets/img/pencil.png" alt=""></a>{/if}</h1>
                <div class="text cms-content">
                    {$page.content}
                    {$events->call('layouts.pages.content')}
                </div>
            </div>
            <!-- end article-page__content -->

            {include file="chunks/sidebar.tpl"}

        </div>

    </div>
    <!-- end article-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}