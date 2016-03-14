select *
from content_types_images_sizes ctis
join content c on c.subtypes_id=ctis.types_id and c.status='published'
join content_images_sizes cis on cis.id=ctis.images_sizes_id
join content_images ci on ci.content_id=c.id
where ctis.images_sizes_id=8
limit 0, 10;

select *
from content_types_images_sizes ctis
join content c on c.subtypes_id=ctis.types_id and c.status='published'
join content_images_sizes cis on cis.id=ctis.images_sizes_id
where ctis.images_sizes_id=0
