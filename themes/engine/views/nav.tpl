<!--side navigation-->
<div class="main-navigation">
    <nav class="side-nav">
        <ul class="first-level">
            <li class="active">
                <a href="#">
                    <i class="fa fa-home"></i>
                    <span>{$t.system.name}</span>
                </a>
            </li>
            {foreach $nav_items as $item}
            <li>
                <a href="./{$item.controller}">
                    <i class="fa {$item.icon}"></i>
                    <span>{$t[$item.controller].action_index}</span>
                </a>
            </li>
            {/foreach}
            {*
            <li class="has-child">
                <a href="#">
                    <div class="toggle-child">
                        <i class="fa fa-plus"></i>
                    </div>
                    <i class="fa fa-shopping-cart"></i>
                    <span>Магазин</span>
                </a>
                <ul class="second-level">
                    <li><a href="">Категорії</a></li>
                    <li><a href="">Виробники</a></li>
                    <li><a href="">Товари</a></li>
                    <li><a href="">Валюти</a></li>
                    <li><a href="">Промо коди</a></li>
                    <li><a href="">Доставка</a></li>
                    <li><a href="">Оплата</a></li>
                    <li><a href="">Зворотні дзвінки</a></li>
                </ul>
            </li>
            *}
            <li class="exit">
                <a href="admin/logout">
                    <i class="fa fa-power-off"></i>
                    <span>Вихід</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<!--end-->