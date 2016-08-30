<div id="places">
    <ul>
        {foreach $places as $place}
        <li style="position: relative;"><a href="module/run/banners/place/{$place.id}">{$place.name} [{$place.code}]</a> <span style="position: absolute;top:0;right:0;;" class="b-banners-places-delete" title="Видалити" data-id="{$place.id}"><i class="fa fa-remove"></i></span></li>
        {/foreach}
        <li><a href="module/run/banners/places/create"><i class="fa fa-plus"></i></a></li>
    </ul>
</div>
