DELETE FROM __tags;
DELETE FROM __posts_tags;

DROP TABLE __posts_tags;
DROP TABLE __tags;

DELETE  FROM __content_types where type in ('post','posts_categories');