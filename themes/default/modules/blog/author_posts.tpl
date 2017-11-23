{extends 'layouts/blog_category.tpl'}
{block name="meta.title"}Блог / Автор: {$author.name}{/block}
{block name="meta.description"}Записи автора {$author.name}{/block}
{block name="meta.keywords"}автор {$author.name}{/block}

{if $category.total > 0}
    {block name='blog.content' prepend}
        <h3>Записи автора <strong>{$author.name}</strong></h3>
        <h4>Знайдено: {$category.total} записів</h4>
    {/block}
{/if}