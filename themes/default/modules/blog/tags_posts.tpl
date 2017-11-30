{extends 'layouts/blog_category.tpl'}
{block name="meta.title"}Блог / Мітка: {$category.tag.tag}{/block}
{block name="meta.description"}Пошук по мітці {$category.tag.tag}{/block}
{block name="meta.keywords"}мітка {$category.tag.tag}{/block}