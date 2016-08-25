<style>
    html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
    }

    .controls {
        margin-top: 16px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
    }

    #pac-input {
        background-color: #fff;
        padding: 0 11px 0 13px;
        width: 400px;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        text-overflow: ellipsis;
    }

    #pac-input:focus {
        border-color: #4d90fe;
        margin-left: -1px;
        padding-left: 14px; /* Regular padding-left + 1. */
        width: 401px;
    }

    .pac-container {
        font-family: Roboto;
    }

    #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
    }

    #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
    }

    #target {
        width: 345px;
    }


</style>

<form accept-charset="utf-8" method="post" id="addStreetForm" action="module/run/gmap/processing" data-parsley-validate=""
      data-parsley-namespace="data-parsley-">
    <div id="ow_notification"></div>
    {foreach $languages as $language}
        <div class="form-group ">
                    <label for="info_name{$language.id}">Назва {$language.name}</label>
            <input type="text" id="info_name{$language.id}" required name="info[{$language.id}][name]" value="{$language.info}" class="form-control">
        </div>
    {/foreach}
    <div class="form-group">
        <input type="hidden" id="city_id_for_street" name="id_city" class="form-control"/><br/>
        <label>Координати GPS</label>
        <input placeholder="Координати об'єкту" readonly value="{$coords}" require type="text" id="gps" name="data[value]"
        class="form-control"/><br/>
        <input id="pac-input" class="controls" type="text" placeholder="Введіть адресу">

        <div id="map-canvas" style="width: 100%;height: 300px;"></div>
    </div>
    <input type="hidden" id="taction" name="action" value="{$action}" />
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="id" value="{$id}">
</form>
<div id="error_str"></div>
{literal}
<script>

    $('#data_transition').select2();

    $('#data_transition').on("change", function(e) {
        if (e.removed) {
            var id=e.removed.id;
            var content_id = $("#content_id").val();
            var street_id = $("#street_id").val();

            $.get('plugins/Transition/deleteItem/'+id+'/'+content_id+'/'+street_id,function(d){
                //if(d>0){self.parents('optinons').remove();}
                //console.log("GOOD");
            });
        }
    });
</script>
{/literal}