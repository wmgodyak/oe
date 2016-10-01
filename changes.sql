delete from e_content_meta where content_id not in (select id from e_content);
delete from e_content_info where content_id not in (select id from e_content);
delete from e_products_prices where content_id not in (select id from e_content);
delete from e_content_features where content_id not in (select id from e_content);
delete from e_content_relationship where content_id not in (select id from e_content);