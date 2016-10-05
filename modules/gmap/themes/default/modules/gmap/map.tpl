<h1>Ми на карті:</h1>
<div class="map">
    <div id="gmap" style="width:100%;height:500px;"></div>
</div>

<script>
    var markers = {$mod->gmap->getMarkers()};
    console.log(markers);
{literal}
    function initMap() {
        //49.80280099999999, 24.000503999999978
        var myLatLng = {lat: 49.80, lng: 24.000};

        var map = new google.maps.Map(document.getElementById('gmap'), {
            zoom: 13,
            center: myLatLng
        });

        var m ={}, iw = {};
        for(var i=0; i < markers.length; i++){


            m.i = new google.maps.Marker({
                position: markers[i].position,
                map: map,
                title: markers[i].title
            });

            iw.i = new google.maps.InfoWindow({
                content: "<p>"+markers[i].title+"</p>"
            });

            m.i.addListener('click', function() {
                map.setZoom(15);
                map.setCenter(m.i.getPosition());
                iw.i.open(map, m.i);
            });
        }

//        var marker = new google.maps.Marker({
//            position: myLatLng,
//            map: map,
//            title: 'Hello World!'
//        });
    }
{/literal}
</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key={$mod->gmap->getApikey()}&signed_in=true&callback=initMap"></script>