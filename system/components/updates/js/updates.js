$(document).ready(function(){
    var check = function()
    {
        engine.request.get('updates/check', function(res){
            if(res == '') return;

            engine.inlineNotify(res, 'info', '.inline-notifications', false);
        });
    };

    if($('body').hasClass('ct-dashboard')){
        setTimeout(function(){
            check();
        }, 1000);
    }


    $(document).on('click', '#b_update_core', function(){
        var b = $(this);
        b.attr('disabled', true);
        engine.request.get('updates/run', function(res){
            if(res == '') return;
            engine.inlineNotify(res.m, 'success', '.inline-notifications', false);
        });
    })
});