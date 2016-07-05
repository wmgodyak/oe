
{include file="chunks/head.tpl"}
<!-- begin wrapper -->
<div class="wrapper">

    {include file="chunks/header.tpl"}

    <!-- begin newspage -->
    <div class="newspage">
        {include file="modules/breadcrumbs.tpl"}

        <div class="container">

            <!-- begin newspage__content -->
            <div class="newspage__content">

                <div class="newspage__filter">

                    {include file="modules/blog/categories.tpl"}
                    {include file="modules/blog/search_form.tpl"}

                </div>

                {include file="modules/blog/posts.tpl"}
            </div>
            <!-- end newspage__content -->

            {include file="chunks/sidebar.tpl"}

        </div>

    </div>
    <!-- end newspage -->

</div>
<!-- end wrapper -->
{include file="chunks/footer.tpl"}