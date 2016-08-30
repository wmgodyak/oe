$(document).ready(function(){
    $('#fb_data_phone').mask('+38(999)99-99-999');
    App.validateAjaxForm('#feedback', function (res) {
        if(res.s){
            $("#feedback").resetForm();
            App.alert(res.m);
        }
    });
});