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

    <!-- begin product-page -->
    <div class="product-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container clearfix">
            {if ! $user.id}
                <p>Увійдіть або зареєструйтесь, щоб продовжити</p>
                {else}

                <!-- begin aside -->
                <aside class="aside">
                    {include file="modules/users/profile_nav.tpl"}

                    <div class="m_discount-widget">
                        <div class="discount__heading1">
                            Ви у нас вперше?
                        </div>
                        <div class="discount__content">
                            <div class="discount__img-block">
                                <div class="discount__img" style="background-image: url('{$theme_url}/assets/img/discount-widget/img1.png');"></div>
                            </div>
                            <div class="discount__heading2">
                                Отримайте знижку!
                            </div>
                            <div class="discount__text">
                                Введіть свою електронну скриньку
                                та отримайте знижку у нашому
                                інтернет магазині, а також будьте
                                завжди в курсі наших новин.
                            </div>
                            <form action="#">
                                <div class="input-group">
                                    <input type="email" placeholder="Введіть свій e-mail">
                                </div>
                                <div class="btn-row">
                                    <button class="btn md red">Хочу знижку</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </aside>
                <!-- end aside -->

                <!--Begin content of profile-->
                <div class="profile-content">

                    {$mod->users->profile()}
                    {include file="modules/users/meta.tpl"}

                    {$mod->users->changePassword()}
                    {*{include file="modules/users/password.tpl"}*}

                </div>
                <!--End profile content-->

                <!--Begin right aside orders-->
                <aside class="aside-right">
                    <h3 class="head-red">Мої замовлення:</h3>
                    <div class="orders">
                        <div class="order">
                            <div class="header">
                                <ul>
                                    <li class="number-order">№ 234516</li>
                                    <li class="center-block">01.02.2016</li>
                                    <li class="right-block">
                                        <span class="text-right">Статус: </span><span class="green">Виконано</span>
                                    </li>
                                    <li class="clearfix"></li>
                                </ul>
                            </div>
                            <div class="content">
                                <div class="product">
                                    <div class="img">
                                        <img src="{$theme_url}/assets/img/TOVARS/3.jpg" alt="">
                                    </div>
                                    <div class="description">
                                        <a href="" class="link">Чохол-книжка універсальний Universal Book Cover Jeans Blue</a>
                                        <ul class="price">
                                            <li>86,00 грн</li>
                                            <li>2 шт.</li>
                                            <li class="text-right">172,00 грн</li>
                                            <li class="clearfix"></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="product">
                                    <div class="img">
                                        <img src="{$theme_url}/assets/img/TOVARS/powerbank.png" alt="">
                                    </div>
                                    <div class="description">
                                        <a href="" class="link">Чохол-книжка універсальний Universal Book Cover Jeans Blue</a>
                                        <ul class="price">
                                            <li>86,00 грн</li>
                                            <li>2 шт.</li>
                                            <li class="text-right">172,00 грн</li>
                                            <li class="clearfix"></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="product-sum text-right">Разом до сплати: 2422,00 грн</div>
                            </div>
                        </div>
                        <div class="order">
                            <div class="header">
                                <ul>
                                    <li class="number-order">№ 234516</li>
                                    <li class="center-block">01.02.2016</li>
                                    <li class="right-block">
                                        <span class="text-right">Статус: </span><span class="green">Виконано</span>
                                    </li>
                                    <li class="clearfix"></li>
                                </ul>
                            </div>
                            <div class="content">
                                <div class="product">
                                    <div class="img">
                                        <img src="{$theme_url}/assets/img/TOVARS/3.jpg" alt="">
                                    </div>
                                    <div class="description">
                                        <a href="" class="link">Чохол-книжка універсальний Universal Book Cover Jeans Blue</a>
                                        <ul class="price">
                                            <li>86,00 грн</li>
                                            <li>2 шт.</li>
                                            <li class="text-right">172,00 грн</li>
                                            <li class="clearfix"></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="product">
                                    <div class="img">
                                        <img src="{$theme_url}/assets/img/TOVARS/powerbank.png" alt="">
                                    </div>
                                    <div class="description">
                                        <a href="" class="link">Чохол-книжка універсальний Universal Book Cover Jeans Blue</a>
                                        <ul class="price">
                                            <li>86,00 грн</li>
                                            <li>2 шт.</li>
                                            <li class="text-right">172,00 грн</li>
                                            <li class="clearfix"></li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="product-sum text-right">Разом до сплати: 2422,00 грн</div>
                            </div>
                        </div>
                    </div>
                    <div class="text-right"><button class="btn-edit">Змінити пароль</button></div>
                </aside>
                <!--End right aside-->

            {/if}
        </div>

    </div>
    <!-- end product-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}