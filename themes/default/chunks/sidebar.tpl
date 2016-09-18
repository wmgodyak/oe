<!-- begin asider -->
<aside class="asider">
    <div id="vk_groups"></div>
    <br>
    <div id="fb-root"></div>
    <div class="fb-page" data-href="https://www.facebook.com/CMA.Company" data-width="255" data-height="400" data-small-header="false" data-adapt-container-width="true" data-hide-cover="true" data-show-facepile="true"><blockquote cite="https://www.facebook.com/CMA.Company" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/CMA.Company">Компанія СМА</a></blockquote></div>
    <br>
    <br>
    {include file="chunks/subscribe.tpl"}
    {*<div class="weather-widget"></div>*}
</aside>
<!-- end asider -->
{literal}
    <script type="text/javascript" src="//vk.com/js/api/openapi.js?129"></script>
    <script type="text/javascript">
        VK.Widgets.Group("vk_groups", {mode: 3, width: "255", height: "400", color1: 'ffffff', color2: '000000', color3: '5E81A8'}, 66620956);
    </script>


    <script>(function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/uk_UA/sdk.js#xfbml=1&version=v2.7&appId=1763511677233254";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
{/literal}