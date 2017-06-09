{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:wmgodyak@gmail.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-07-07T10:35:40+03:00
 * @name account
 *}

{include file="chunks/head.tpl"}

<div class="wrapper">

    {include file="chunks/header.tpl"}


    <div class="product-page">

        {include file="modules/breadcrumbs.tpl"}

        <div class="container clearfix">
            {if ! $user.id}
                <div class="bs-callout bs-callout-danger">
                    <p>{$t.users.e_not_logged_in}</p>
                </div>
                {else}

                <aside class="aside">
                    {include file="modules/users/profile_nav.tpl"}
                </aside>


                <!--Begin content of profile-->
                <div class="profile-content {if $page.id == 31} one-sb-sl{/if}">

                    {if $page.id == 26 || $page.id==28}

                        {$mod->users->profile()}
                        {include file="modules/users/meta.tpl"}

                        {$mod->users->changePassword()}

                        {elseif $page.id == 31}
                        {$mod->order->history()}
                        {$mod->order->pagination()}
                    {elseif $page.id == 32}
                        {include file="modules/users/barcode.tpl"}
                    {/if}

                    {$events->call('user.account.content', $page)}
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


</div>

{include file="chunks/footer.tpl"}