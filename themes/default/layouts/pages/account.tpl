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
                </aside>
                <!-- end aside -->

                <!--Begin content of profile-->
                <div class="profile-content {if $page.id == 31} one-sb-sl{/if}">

                    {if $page.id == 26 || $page.id==28}

                        {$mod->users->profile()}
                        {include file="modules/users/meta.tpl"}

                        {$mod->users->changePassword()}

                        {elseif $page.id == 31}
                        {$mod->order->history()}
                        {$mod->order->pagination()}
                    {/if}
                </div>
                <!--End profile content-->
                {if $page.id != 31}
                <!--Begin right aside orders-->
                    <aside class="aside-right">
                        {$events->call('user.account.sidebar')}
                    </aside>
                <!--End right aside-->
                {/if}
            {/if}
        </div>

    </div>
    <!-- end product-page -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}