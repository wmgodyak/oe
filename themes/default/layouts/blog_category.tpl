{*
 * OYiEngine 7
 * @author VH mailto:vh@otakoyi.com
 * @copyright Copyright (c) 2017
 * Date: 2017-10-08T12:32:29+03:00
 * @name Services
 *}
{extends 'layouts/index.tpl'}
{block name='container'}

    {include file="modules/breadcrumbs.tpl"}

    <section class="main-content">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-sm-12">

                    {block name="blog.content"}

                        {foreach $category.posts as $post}
                            {include file="modules/blog/category/post.tpl"}
                        {/foreach}

                        <div class="blog-pagination text-center clearfix">
                            {if $category.pagination}{$category.pagination->display()}{/if}
                        </div>

                    {/block}

                </div> <!--  end col-sm-8 -->

                <div class="col-md-4 col-sm-12">

                    {include file="modules/blog/sidebar/search.tpl"}
                    {include file="modules/blog/sidebar/categories.tpl"}
                    {include file="modules/blog/sidebar/tags.tpl"}

                </div> <!-- end .col-sm-4  -->

            </div> <!--  end row  -->

        </div> <!--  end container -->

    </section> <!-- end .main-content  -->
    <!-- START FOOTER  -->
    <a id="backTop">Вгору</a>
{/block}