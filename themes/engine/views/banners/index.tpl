<div id="places">
    <ul>
        {foreach $places as $place}
        <li><a href="module/run/banners/place/{$place.id}">{$place.name} [{$place.code}]</a></li>
        {/foreach}
        <li><a href="module/run/banners/places/create"><i class="fa fa-plus"></i></a></li>
    </ul>
</div>
