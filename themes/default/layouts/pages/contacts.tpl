{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T10:38:57+03:00
 * @name Контакти
 *}
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}


    <!-- begin article-page -->
    <div class="article-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container contact-page">

            <!-- begin article-page__content -->
            <div class="contact-page__content">

                <div class="contacts goods-list">

                    <div class="goods-list">
                        <div class="goods-list__top-row">
                            <div class="item item1">
                                {$page.title}
                            </div>
                        </div>
                        <div class="goods-list__main">
                            {$page.content}
                        </div>
                    </div>

                </div>


                <div class="callback goods-list">

                    <div class="goods-list">
                        <div class="goods-list__top-row">
                            <div class="item">
                                Зворотній зв’язок
                            </div>
                        </div>
                        <div class="goods-list__main">

                            <div class="goods-list__row">
                                <div class="form-block">
                                    {include file="modules/feedback/form.tpl"}
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="item12">
                   {include file="modules/gmap/map.tpl"}
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