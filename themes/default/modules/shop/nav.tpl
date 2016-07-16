<!-- begin sidebar -->
<aside class="sidebar sidebar-collapse">
    <!-- begin m_goods-nav -->
    <nav class="m_goods-nav">
        <div class="goods-nav__header">
            <a href="javascript:;">КАТАЛОГ ТОВАРІВ</a>
        </div>
        <ul class="goods-nav__list">
            {foreach $mod->shop->categories() as $i=>$cat}
            <li class="goods-nav__item i{$i}">
                <a class="goods-nav__link" title="{$cat.title}" href="{$cat.id}">{$cat.name}</a>
                {*<div class="sub-menu">
                    <div class="content my-grid">
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                    </div>
                </div> *}
            </li>
            {/foreach}
            {*
            <li class="goods-nav__item i2">
                <a class="goods-nav__link" href="#">Запчастини для планшетів</a>
                <div class="sub-menu">
                    <div class="content my-grid">
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </li>
            <li class="goods-nav__item i3">
                <a class="goods-nav__link" href="#">Запчастини для Apple iPhone</a>
                <div class="sub-menu">
                    <div class="content my-grid">
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                        <div class="item">
                            <ul class="single-category">
                                <li><a class="text-head" href="">Категорія</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                                <li><a class="link" href="">Запчастини</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </li>
            <li class="goods-nav__item i4">
                <a class="goods-nav__link" href="#">Запчастини для Apple iPod</a>
            </li>
            <li class="goods-nav__item i5">
                <a class="goods-nav__link" href="#">Запчастини для Apple iPad</a>
            </li>
            <li class="goods-nav__item i6">
                <a class="goods-nav__link" href="#">Аксесуари для мобільних телефонів</a>
            </li>
            <li class="goods-nav__item i7">
                <a class="goods-nav__link" href="#">Аксесуари для Apple iPhone</a>
            </li>
            <li class="goods-nav__item i8">
                <a class="goods-nav__link" href="#">Аксесуари для Apple iPad</a>
            </li>
            <li class="goods-nav__item i9">
                <a class="goods-nav__link" href="#">Обладнання та інструменти</a>
            </li>
            <li class="goods-nav__item i10">
                <a class="goods-nav__link" href="#">Обладнання для програмування</a>
            </li>
            <li class="goods-nav__item i11">
                <a class="goods-nav__link" href="#">Витратні матеріали для ремонту</a>
            </li>
            <li class="goods-nav__item i12">
                <a class="goods-nav__link" href="#">Аксесуари по брендах</a>
            </li>
            *}
        </ul>
    </nav>
    <!-- end m_goods-nav -->

</aside>
<!-- end sidebar -->