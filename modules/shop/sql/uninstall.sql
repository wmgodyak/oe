DELETE FROM __content_types WHERE `type` in ('products_categories','product', 'search', 'comparison');
DROP TABLE IF EXISTS __products_prices;

DROP TABLE IF EXISTS __products_variants_features;
DROP TABLE IF EXISTS __products_variants_prices;
DROP TABLE IF EXISTS __products_variants;

DROP TABLE IF EXISTS __kits_products;
DROP TABLE IF EXISTS __kits;

DROP TABLE IF EXISTS __products_accessories_features;
DROP TABLE IF EXISTS __products_accessories;

DROP TABLE IF EXISTS __search_history_stat;
DROP TABLE IF EXISTS __search_history;

