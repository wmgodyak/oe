$(document).ready(function(){
    var timer = $('#a_timer');
    if(timer.length){
        var expired = timer.data('expired');
        //console.log(expired);
        timer.countdown(expired, function(event) {
            var $this = $(this).html(event.strftime(''
                + '<div>%d<span>днів</span></div>'
                + '<div>%H<span>год.</span></div>'
                + '<div>%M<span>хв.</span></div>'
                + '<div>%S<span>сек.</span></div>'));
        });
    }

    var ps = $('.products-actions-slider');

    if(ps.length){

        ps.owlCarousel({
            //rewindNav: true, todo fix it
            items: 1,
            loop: true,
            nav: true,
            autoPlay : 100,
            dots: true,
            autoplay: true,
            navText: ["",""]
        });
        ps.find('.timer').each(function(i, e){
            var expired = $(e).data('expired');
            //console.log(expired);
            $(e).countdown(expired, function(event) {
                $(this).html(event.strftime(''
                    + '<div>%d<span>днів</span></div>'
                    + '<div>%H<span>год.</span></div>'
                    + '<div>%M<span>хв.</span></div>'
                    + '<div>%S<span>сек.</span></div>'));
            });
        });
    }
});