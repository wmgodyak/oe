<div class="sidebar-module">
    <h4>Categories</h4>
    <ol class="list-unstyled">
        {foreach $app->module->blog->categories($blog_id) as $k=> $item}
            <li class="cat-item cat-item-{$k}"><a href="{$item.id}" title="{$item.title}">{$item.name}</a></li>
        {/foreach}
    </ol>
</div>
<div class="sidebar-module">
    <h4>Search</h4>
    <form role="search" method="get" id="search_form" class="search_form" action="4">
        <div class="row">
            <div class="col-md-8">
                <input class="form-control" type="text" value="" name="q"  required />
            </div>
            <div class="col-md-4">
                <button class="btn">Go</button>
            </div>
        </div>
    </form>
</div>