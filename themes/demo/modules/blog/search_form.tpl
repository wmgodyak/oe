<div class="search">
    <div class="search_button"><i class="fa fa-search"></i> <i class="fa fa-close"></i></div>
    <form role="form" id="search_form" action="11">
        <div class="form-group has-feedback">
            <input type="text" name="q" placeholder="{$t.blog.search_form_placeholder}" {if $smarty.get.q}value="{$smarty.get.q}"{/if} required class="form-control input-sm">
        </div>
    </form>
</div>