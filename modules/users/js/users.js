$(document).ready(function(){

    App.validateAjaxForm('#usersRegisterForm', function (res) {

        if(res.s){

            var r = $('#usersRegisterForm').data('href');
            if(typeof r == 'undefined'){
                location.reload(true);
            }

            self.location.href = r;

        } else {
            var errors = {};
            var validator = $( "#usersRegisterForm" ).validate();
            for (var inp in res.i){
                errors['data['+ inp +']'] = res.i[inp];
                validator.showErrors(errors);
            }
        }
    });

    App.validateAjaxForm('#usersLoginForm', function (res) {
        if(res.s){

            var r = $('#usersLoginForm').data('href');
            if(typeof r == 'undefined'){
                location.reload(true);
            }

            self.location.href = r;

        } else {
            var validator = $( "#usersLoginForm" ).validate();
            for (var inp in res.i){
                validator.showErrors(res.i[inp]);
            }
        }
    });

    App.validateAjaxForm('#usersFpForm', function (d) {
        App.alert(d.m, 'success', $("#usersFp .response"));
        setTimeout(function(){
            self.location.href="/";
        }, 3000);
    });


    App.validateAjaxForm('#accountProfile', function () {
        App.alert('Дані оновлено.', 'success', $("#accountProfile .response"));
    });

    App.validateAjaxForm('#accountChangePassword', function () {
        App.alert('Дані оновлено.', 'success', $("#accountChangePassword .response"));
    });

    App.validateAjaxForm('#usersNewPsw', function (d) {
        App.alert(d.m, 'success', $("#usersNewPsw .response"));
        setTimeout(function(){
            self.location.href = $('#usersNewPsw').data('href');
        }, 3000);
    });
});