{if $posts|count}
    <div class="shop-posts">
        <div class="side__header">
            <span>Записи з блогу</span>
        </div>
        {foreach $posts as $post}
            <div class="item">
                <div class="title"><a href="{$post.id}" title="{$post.title}" target="_blank">{$post.name}</a></div>
                <div class="intro">{$post.intro}</div>
                <a href="{$post.id}" title="{$post.title}" target="_blank" class="more">Переглянути</a>
            </div>
        {/foreach}
    </div>
{/if}