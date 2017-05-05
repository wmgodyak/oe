<div class="col-sm-3 col-sm-offset-1 blog-sidebar">
    {include file="modules/blog/sidebar.tpl"}
    {$events->call('sidebar.right', $page)}
</div><!-- /.blog-sidebar -->