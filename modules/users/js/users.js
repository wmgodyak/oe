App.users = {
    init: function(){
        App.validateAjaxForm('#usersLogin', function () {
            var r = $('#usersLogin').data('href');
            if(typeof r == 'undefined'){
                location.reload(true);
            }

            self.location.href = r;
        });

        App.validateAjaxForm('#usersFp', function (d) {
            App.alert(d.m, 'success', $("#usersFp .response"));
            setTimeout(function(){
                self.location.href="/";
            }, 3000);
        });

        App.validateAjaxForm('#usersRegister', function () {
            var r = $('#usersRegister').data('href');
            if(typeof r == 'undefined'){
                location.reload(true);
            }

            self.location.href = r;
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
    },
    login: function(){},
    register: function(){}
};
$(document).ready(function(){
   App.users.init();
});