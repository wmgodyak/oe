DROP TABLE IF EXISTS __orders_status_history;
DROP TABLE IF EXISTS __orders_status_info;
DROP TABLE IF EXISTS __orders_status;

DROP TABLE IF EXISTS __orders_kits_products
DROP TABLE IF EXISTS __orders_kits

DROP TABLE IF EXISTS __orders_products;
DROP TABLE IF EXISTS __orders;

DELETE FROM __content_types where type in ('checkout', 'cart');