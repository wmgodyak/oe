{extends 'layouts/blog_category.tpl'}
{block name="meta.title"}Результати пошуку по слову {$search.q}{/block}
{block name="meta.description"}Результати пошуку по слову {$search.q}{/block}
{block name="meta.keywords"}пошук по {$search.q}{/block}

{if $category.total == 0}
    {block name='blog.content'}
        <h3>Нажаль, по запиту <strong>{$search.q}</strong> нічого не знайдено.</h3>
        <h4>Повернутись до <a href="{$blog.id}">блогу</a></h4>
    {/block}
{/if}
{if $category.total > 0}
    {block name='blog.content' prepend}
        <h3>По запиту <strong>{$search.q}</strong> знайдено {$category.total} записів.</h3>
    {/block}
{/if}