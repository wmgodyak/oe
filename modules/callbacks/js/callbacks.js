$(document).ready(function(){
    $(document).on('click', '#callback', function(e) {
        e.preventDefault();

        var d = App.dialog({
            title: 'Передзвоніть мені',
            content: _.template($('#callbackTpl').html())({
                token : TOKEN
            }),
            buttons: {
                'Надіслати' : function(){
                    $('#callbackForm').submit();
                }
            }
        });
        $('.phone-mask').mask('+38(999)99-99-999');
        App.validateAjaxForm('#callbackForm', function (res) {
            if(res.s){
                d.dialog('close');
                App.alert('Вашу заявку прийнято, ми зателефонуємо вам найближчим часом!')
            }
        });
    });
});