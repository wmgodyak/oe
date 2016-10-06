$(document).ready(function(){
    $('#agree').change(function(){
        var next = $('#next');
       if($(this).is(':checked')){
           next.removeAttr('disabled').show();
       } else {
           next.attr('disabled', true).hide();
       }
    });
});