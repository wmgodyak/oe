
var gmap = {
    
    createMap: function(){
        if($(".gmap-content").length){

            var $gmap = $(".gmap-content");
            var mark = $gmap.attr('data-marker');
            var coordinates = $gmap.attr('data-coordinates');

            if (map_data.length) {

                var styledMap = new google.maps.StyledMapType({},
                    {name: "Styled Map"});
                var bounds = new google.maps.LatLngBounds();

                var center = map_data[0].value.split(',');
                var latlng = new google.maps.LatLng(center[0], center[1]);
                var myOptions = {
                    zoom: 15,
                    center: latlng,
                    scrollwheel: false,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControlOptions: {
                        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
                    }, zoomControlOptions: {
                        position: google.maps.ControlPosition.LEFT_CENTER
                    },
                    streetViewControlOptions: {
                        position: google.maps.ControlPosition.LEFT_CENTER
                    }
                };

                var map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
                map.mapTypes.set('map_style', styledMap);
                map.setMapTypeId('map_style');
                var marker, i, ib = [];

                for (i = 0; i < map_data.length; i++) {
                    var gps = map_data[i].value.split(',');
                    var c1 = parseFloat(gps[0]), c2 = parseFloat(gps[1]);
                    //console.log(c1,c2);
                    var pos = new google.maps.LatLng(c1, c2);
                    bounds.extend(pos);

                    marker = new google.maps.Marker({
                        position: pos,
                        map: map,
                    ///    icon:'/themes/default/assets/img/pin.png'
                    });
                    //  console.log("/uploads/mapicon/"+map_data[i].icon);
                    //ib.i = map_data[i].name;

                    google.maps.event.addListener(marker, 'click', (function (marker, i) {
                        return function () {
                            // console.log(ib.i, marker, i, map_data[i].name);
                            if (ib.i) {
                                ib.i.close();
                            }
                            var label = $('.marker-title').html(map_data[i].name);
                                ib.i = new google.maps.InfoWindow({
                                    content: "<div style='padding-top: 15px;'><p>" + map_data[i].name+"</p><br><p>" +
                                    "<button type='button' class='btn  btn-default' onclick='gmap.editMarker("+map_data[i].id+");'>Редагувати</buttop>" +
                                    "<button type='button' class='btn btn-danger' style='margin-left: 10px;' onclick='gmap.deleteMarker("+map_data[i].id+");'>Видалити</button>"+
                                    "</p></div>"
                                });

                            ib.i.open(map, marker);
                            //setTimeout(function () {ib.i.close(); }, 5000);
                        }
                    })(marker, i));
                    map.fitBounds(bounds);
                    google.maps.event.addListener(map, 'click', function () {

                        for (var i = 0; i < ib.length; i++) {
                            ib[i].close();
                        }
                    });
                }
            } else {
                styledMap = new google.maps.StyledMapType({},
                    {name: "Styled Map"});
                latlng = new google.maps.LatLng(51.5248873, 24.103218);

                myOptions = {
                    zoom: 10,
                    center: latlng,
                    scrollwheel: false,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    mapTypeControlOptions: {
                        mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
                    }, zoomControlOptions: {
                        position: google.maps.ControlPosition.LEFT_CENTER
                    },
                    streetViewControlOptions: {
                        position: google.maps.ControlPosition.LEFT_CENTER
                    }
                };
                map = new google.maps.Map(document.getElementById("map_canvas"),myOptions);
                map.mapTypes.set('map_style', styledMap);
                map.setMapTypeId('map_style');
            }
        }
    },
    
    init: function(){
        this.createMap();
    },

    deleteMarker: function (id) {
        engine.request.get('module/run/gmap/delete/'+id, function(d)
        {
            location.reload();
        });
    },

    editMarker: function (id) {
        engine.request.get('module/run/gmap/edit/'+id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#addStreetForm').submit();
            };
            // console.log(d);
            var dialog = engine.dialog({
                content: d,
                title: t.gmap.action_create,
                autoOpen: true,
                width: 950,
                modal: true,
                buttons: buttons
            });

            initializeGmap();

            engine.validateAjaxForm('#addStreetForm', function(d){
                if(d.s){
                    // engine.refreshDataTable('routes');
                    location.reload();
                    dialog.dialog('close').dialog('destroy');
                }
            });
        });
    },

    loadForm: function () {
        engine.request.get('module/run/gmap/loadForm', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#addStreetForm').submit();
            };
            // console.log(d);
            var dialog = engine.dialog({
                content: d,
                title: t.gmap.action_create,
                autoOpen: true,
                width: 950,
                modal: true,
                buttons: buttons
            });

            initializeGmap();

            engine.validateAjaxForm('#addStreetForm', function(d){
                if(d.s){
                    // engine.refreshDataTable('routes');
                    location.reload();
                    dialog.dialog('close').dialog('destroy');
                }
            });
        });
    }
};



$(window).on('load', function(){
    gmap.init();
});



function initializeGmap() {
    var map = new google.maps.Map(document.getElementById('map-canvas'), {
        zoom: 7,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    google.maps.event.addListenerOnce(map, 'idle', function(){
        google.maps.event.trigger(map, 'resize');
        map.setCenter(location);
    });
    var marker;

    var defCoords = [49.839046, 24.0344];

    var c = document.getElementById('gps').value;

    if(c != ''){
        c=c.split(',');
        defCoords=c;
    }

    var defaultBounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(defCoords[0], defCoords[1]),
        new google.maps.LatLng(defCoords[0], defCoords[1]));
    map.fitBounds(defaultBounds);

    // Create the search box and link it to the UI element.
    var input = /** @type {HTMLInputElement} */(
        document.getElementById('pac-input'));
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(
        /** @type {HTMLInputElement} */(input));

    google.maps.event.addListener(searchBox, 'places_changed', function() {
        var places = searchBox.getPlaces();
        console.log(searchBox);
        if (places.length == 0) {
            return;
        }
        if(typeof marker != 'undefined'){
            marker.setMap(null);
        }

        var place = places[0];

        var bounds = new google.maps.LatLngBounds();
        marker = new google.maps.Marker({
            map: map,
            draggable: true,
            title: place.name,
            position: place.geometry.location
        });


        bounds.extend(place.geometry.location);

        var gps=document.getElementById('gps'), v;
        gps.value=place.geometry.location;
        v = gps.value;
        v = v.replace('(','').replace(')','');
        gps.value=v;

        google.maps.event.addListener(marker, 'dragend', function (event) {
            gps.value=this.getPosition().lat()+','+this.getPosition().lng();
        });

        map.fitBounds(bounds);
    });

    google.maps.event.addListener(map, 'bounds_changed', function() {
        var bounds = map.getBounds();
        searchBox.setBounds(bounds);
    });

    setTimeout(function(){
        var address = $('#options_3').val();
        if(address != ''){
            $('#pac-input').val(address);

            marker = new google.maps.Marker({
                map: map,
                draggable: true,
                title: address,
                position: new google.maps.LatLng(defCoords[0], defCoords[1])
            });
            var gps=document.getElementById('gps');
            google.maps.event.addListener(marker, 'dragend', function (event) {
                gps.value=this.getPosition().lat()+','+this.getPosition().lng();
            });
        }
    }, 1000);
}




