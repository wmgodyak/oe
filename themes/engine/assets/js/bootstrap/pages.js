/**
 * Created by wg on 29.02.16.
 */
engine.pages = {
    init: function()
    {
        $(".info-name").charCount({"counterText":"Залишилось:","allowed":200,"warning":25});
        $(".info-url").charCount({"counterText":"Залишилось:","allowed":160,"warning":25});
    }
};

$(document).ready(function(){
   engine.pages.init();
});
