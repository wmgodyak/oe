$(function() {
    $(".categ").hover(
    	function () { $(this).addClass("active") },   //on mouse over
    	function () { $(this).removeClass("active") } //on mouse out
    );
});

$(function () {
    $("#slider").responsiveSlides({
        auto: false,
        pager: false,
        nav: true,
        speed: 500,
        namespace: "callbacks",
    });

});

$(function () {
    $('#star').starrr({
              change: function(e, value){
                if (value) {
                  $('.your-choice-was').show();
                  $('.choice').text(value);
                } else {
                  $('.your-choice-was').hide();
                }
              }
});
});

$(function () {
    var owl = $(".owl-carousel");
    owl.owlCarousel({
                items: 5,
                loop: true,
                navText: "",
    //            autoplay:true,
    //            autoplayTimeout:3000,
                responsiveClass: true,
                responsive:{
                    0:{
                        items:1,
                        nav:true
                    },
                    500:{
                        items:2,
                        nav:true
                    },
                    700:{
                        items:3,
                        nav:false
                    },
                    900:{
                        items:4,
                        nav:false
                    },
                    1110:{
                        items:5,
                        nav:true,
                        loop:false
                    }
                }
})
    $(".next").click(function(){
        owl.trigger('next.owl.carousel');
    })
    $(".prev").click(function(){
        owl.trigger('prev.owl.carousel');
    }) 
});

$(function () {
    $("#categories").click(function() {
//        $("#categories").css( 'border-bottom','none');
        $('.all-categories').fadeToggle("slow");
        e = $(this).closest('.search').find('.all-categories');
            if(!e.is(':visible')) {
                $('.all-categories').hide();
                e.show();
            }
    });
});