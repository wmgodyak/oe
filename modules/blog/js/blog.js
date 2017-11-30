jQuery(function ($) {

   function more(params, success)
   {
       var defaults = {
           start: 0,
           num: 5,
           category_id: 0,
           html: 0
       };

       params = $.extend(defaults, params);


       App.request.post({
          url: 'route/blog/more',
           data:params,
           success: success
       });
   }

   $(document).on('click', '.blog-more', function(){
        var t = $('.blog-post').length, num = 3;
        t = 0;
        more
        (
            {
                start: t,
                num: num,
                category_id: 0,
                html: 1
            },
            function(res)
            {
                if(res.html){
                    $(res.html).insertBefore($('.blog-main-more'));
                }
                t += num;
                console.log(t, res.total);
                if(res.total < t){
                    $('.blog-more').hide();
                }
            }
        );
   });
});