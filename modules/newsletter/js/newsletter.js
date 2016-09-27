$(document).ready(function(){
    App.validateAjaxForm('.newsletter-subscribe', function(res){
        if(res.s){
            $('.newsletter-subscribe').resetForm();
        }
        if(res.m != ''){
            App.alert(res.m);
        }
    });
});