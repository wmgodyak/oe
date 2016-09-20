$(document).ready(function(){
    var timer = $('#a_timer');
    if(timer.length == 0) return ;

    var expired = timer.data('expired');
    //console.log(expired);
    timer.countdown(expired, function(event) {
        var $this = $(this).html(event.strftime(''
            + '<div>%d<span>днів</span></div>'
            + '<div>%H<span>год.</span></div>'
            + '<div>%M<span>хв.</span></div>'
            + '<div>%S<span>сек.</span></div>'));
    });
});