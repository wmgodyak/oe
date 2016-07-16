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
                    <h1>Розташування офісу на мапі:</h1>

                    <div class="map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5146.129340183353!2d24.033310329508705!3d49.8412423779145!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x2145bb13cd192ef3!2z0JTQvtC80ZbQvdGW0LrQsNC90YHRjNC60LjQuSDRgdC-0LHQvtGA!5e0!3m2!1suk!2sua!4v1467293611024" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                    </div>
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