delete from e_content_meta where content_id not in (select id from e_content);
delete from e_content_info where content_id not in (select id from e_content);
delete from e_products_prices where content_id not in (select id from e_content);
delete from e_content_features where content_id not in (select id from e_content);
delete from e_content_relationship where content_id not in (select id from e_content);


SELECT DISTINCT
  c.id,
  ci.name,
  ci.title,
  c.in_stock,
  c.has_variants,
  crm.categories_id,
  ci.description,
  ci.url,
  CASE WHEN c.currency_id = 2
    THEN pp.price
  WHEN c.currency_id <> 2 AND c.currency_id = 1
    THEN pp.price * 26.000
  WHEN c.currency_id <> 2 AND c.currency_id <> 1
    THEN pp.price / cu.rate * 26.000 END AS price,
  pp.price                               AS pprice,
  'грн.'                                 AS symbol,
  'UAH'                                  AS currency_code,
  IF(c.in_stock = 1, 1, 0)               AS available
FROM e_content_meta cm JOIN e_content c ON c.types_id = 23 AND c.status = 'published' AND c.in_stock = 1
  JOIN e_content_relationship crm ON crm.content_id = c.id AND crm.is_main = 1
  JOIN e_products_prices pp ON pp.content_id = c.id AND pp.group_id = 7
  JOIN e_currency cu ON cu.id = c.currency_id
  JOIN e_content_info ci ON ci.content_id = c.id AND ci.languages_id = 1
WHERE cm.meta_k = 'hit' AND cm.meta_v = 1
LIMIT 0, 30;