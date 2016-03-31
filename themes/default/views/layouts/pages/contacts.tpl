{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-31T16:58:28+03:00
 * @name Контакти
 *}
{include file="chunks/head.tpl"}
<body id="contact-us">
{include file="modules/nav/top.tpl"}

<div id="map" style="height:400px;">

    <iframe width="100%" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com.mx/?ie=UTF8&amp;ll=32.689593,-117.18039&amp;spn=0.023259,0.038495&amp;t=m&amp;z=15&amp;output=embed"></iframe>

    <div class="marker-wrapper">
        <div class="marker-icon"></div>
        <div class="marker"></div>
    </div>

    <div id="directions">
        <p>Get directions to our office</p>
        <form>
            <div class="form-group">
                <input class="form-control" type="text" placeholder="Write your zip code" />
            </div>
            <button type="submit" class="button button-small">
                <span>Get directions</span>
            </button>
        </form>
    </div>
</div>

<div id="info">
    <div class="container">
        <div class="row">
            <div class="col-md-8 message">
                <h3>Send us a message</h3>
                <p>
                    You can contact us with anything related to React. <br/> We'll get in touch with you as soon as possible.
                </p>
                {include file="modules/feedback/form.tpl"}
            </div>
            <div class="col-md-4 contact">
                <div class="address">
                    <h3>Our Address</h3>
                    <p>
                        The Old Road Willington, <br />
                        7 Kings Road, <br />
                        Southshore, 64890
                    </p>
                </div>
                <div class="phone">
                    <h3>By Phone</h3>
                    <p>
                        1-800-346-3344
                    </p>
                </div>
                <div class="online-support">
                    <strong>Looking for online support?</strong>
                    <p>
                        Talk to us now with our online chat
                    </p>
                </div>
                <div class="social">
                    <a href="#" class="fb"><img src="{$theme_url}assets/images/social/fb.png" alt="facebook" /></a>
                    <a href="#" class="tw"><img src="{$theme_url}assets/images/social/tw.png" alt="twitter" /></a>
                </div>
            </div>
        </div>
    </div>
</div>

{include file="chunks/footer.tpl"}