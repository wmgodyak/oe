{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-17T17:31:12+02:00
 * @name Блог
 *}
{include file="chunks/head.tpl"}
<body id="blog">
{include file="modules/nav/top.tpl"}
<div id="posts">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                {include file="modules/blog/posts.tpl"}
                {include file="modules/pagiation.tpl"}
            </div>
            <div class="col-md-3 sidebar">
                <div class="search">
                    <form action="25">
                        <span class="icomoon-search"></span>
                        <input type="text" name="q" placeholder="Search on blog..." />
                    </form>
                </div>
                {include file="modules/blog/categories.tpl"}
            </div>
        </div>
    </div>
</div>

{include file="chunks/footer.tpl"}

<script type="text/javascript">
    $(function () {
        $(".search input:text").focus(function () {
            $(".icomoon-search").addClass("active");
        });
        $(".search input:text").blur(function () {
            $(".icomoon-search").removeClass("active");
        });
    });
</script>
</body>
</html>