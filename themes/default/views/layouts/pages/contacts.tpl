{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T10:38:57+03:00
 * @name Контакти
 *}
{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T10:35:40+03:00
 * @name account
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
                                Наші контакти:
                            </div>
                        </div>
                        <div class="goods-list__main">

                            <div class="goods-list__row">

                                <div class="item item7">
                                    <h3>Головний офіс, вул. Наукова 7а <br><span>(Офісний центр “Оптіма Плаза”)</span></h3>

                                    <p>1 поверх, офіс №124</p>
                                    <p>Працюємо з 09:00 до 19:00</p>
                                    <p>Сб: 09:00 - 15:00, Нд: вихідний</p>
                                </div>

                                <div class="item item5">
                                    <img src="{$theme_url}/assets/img/contacts.jpg" alt="">
                                </div>

                            </div>
                            <div class="goods-list__row">
                                <div class="head">Телефонні номери, інтернет зв’язок:</div>
                                <div class="item item6">
                                    <div class="footer__contacts">

                                        <a class="ks" href="#">
                                            +38 (097) 59 88 666
                                        </a>

                                        <a class="vf" href="#">
                                            +38 (099) 25 88 666
                                        </a>

                                        <a class="lc" href="#">
                                            +38 (063) 59 88 666
                                        </a>

                                    </div>
                                </div>
                                <div class="item item6">
                                    <div class="footer__contacts">

                                        <a class="gm" href="#">
                                            sma.lviv@gmail.com
                                        </a>

                                        <a class="sk" href="#">
                                            sma_lviv
                                        </a>

                                    </div>
                                </div>

                            </div>
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
                                    <form class="form" action="">
                                        <div class="form-group">
                                            <label for="pass-modal">Ваше ім’я:</label>
                                            <input id="pass-modal" name="name" type="text">
                                        </div>
                                        <div class="form-group">
                                            <label for="email-modal">Електронна пошта:</label>
                                            <input id="email-modal" name="email" type="email">
                                        </div>
                                        <div class="form-group">
                                            <label for="asking">Питання</label>
                                            <textarea name="" id="asking" cols="20" rows="5"></textarea>
                                        </div>
                                        <button type="submit" class="btn md red" >Надіслати</button>
                                    </form>
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