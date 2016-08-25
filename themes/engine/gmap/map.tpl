<section class="map">
    <div class="heading">
        <div class="container">
            <h2>{$t.common.partners}</h2>
        </div>
    </div>
    {literal}
        <script>
            var map_data = {/literal}{$items}{literal}
        </script>
    {/literal}
    <div class="body">
        <div class="gmap-content">
            <script src="https://maps.googleapis.com/maps/api/js?key={$gmap_api_key}&signed_in=true&libraries=places"></script>
            <div class="map-content">
                <div id="map_canvas" style="height: 525px;"></div>
            </div>
        </div>
    </div>
</section>
