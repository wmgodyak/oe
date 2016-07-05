<form class="search-form" action="">
    <input type="text" name="q" placeholder="{$t.blog.search_form_placeholder}" {if $smarty.get.q}value="{$smarty.get.q}"{/if} required>
    <button type="submit" class="search-btn"></button>
</form>