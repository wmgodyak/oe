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
            App.alert(d.m);
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

    App.validateAjaxForm('#usersPasswordChangeForm', function (res) {
        if(res.s){
            App.alert(res.m, function(){

                var r = $('#usersPasswordChangeForm').data('href');
                if(typeof r != 'undefined'){
                    self.location.href = r;
                }
            });
        } else {
            var validator = $( "#usersPasswordChangeForm" ).validate();
            for (var inp in res.i){
                validator.showErrors(res.i[inp]);
            }
        }
    });
    App.validateAjaxForm('#usersPasswordResetForm', function (res) {
        if(res.s){
            App.alert(res.m, function(){

                var r = $('#usersPasswordResetForm').data('href');
                if(typeof r != 'undefined'){
                    self.location.href = r;
                }
            });
        } else {
            var validator = $( "#usersPasswordResetForm" ).validate();
            for (var inp in res.i){
                validator.showErrors(res.i[inp]);
            }
        }
    });


    App.validateAjaxForm('#usersProfileForm', function (res) {
        if(res.s){
            App.alert(res.m);
        } else {
            var validator = $( "#usersProfileForm" ).validate();
            for (var inp in res.i){
                validator.showErrors(res.i[inp]);
            }
        }
    });


    App.validateAjaxForm('#usersFpForm', function (res) {
        if(res.s){
            App.alert(res.m, function(){

                var r = $('#usersFpForm').data('href');
                if(typeof r != 'undefined'){
                    self.location.href = r;
                }
            });
        } else {
            var validator = $( "#usersFpForm" ).validate();
            for (var inp in res.i){
                validator.showErrors(res.i[inp]);
            }
        }
    });
});