App.users = {
    init: function(){

        function hideModal()
        {
            $('.modal').remove();
        }

        $(document).on('click', '.b-users-login', function(e){
            e.preventDefault();
            hideModal();
            App.request.get('route/users/login', function(res){
               $(res).appendTo('.header__activities');

                App.validateAjaxForm('#usersLogin', function () {
                    location.reload(true);
                    //self.location.href = $('#usersLogin').data('href');
                });
            });
        });
        $(document).on('click', '.b-users-register', function(e){
            e.preventDefault();
            hideModal();
            App.request.get('route/users/register', function(res){
               $(res).appendTo('.header__activities');

                App.validateAjaxForm('#usersRegister', function () {
                    //self.location.href = $('#usersRegister').data('href');
                    location.reload(true);
                });
            });
        });
        $(document).on('click', '.b-users-fp', function(e){
            e.preventDefault();
            hideModal();
            App.request.get('route/users/fp', function(res){
               $(res).appendTo('.header__activities');

                App.validateAjaxForm('#usersFp', function (d) {
                    App.alert(d.m, 'success', $("#usersFp .response"));
                    setTimeout(function(){
                        self.location.href="/";
                    }, 3000);
                });
            });
        });
        $(document).on('click', '.b-users-cancel', function(e){
            e.preventDefault();
            hideModal();
        });

        App.validateAjaxForm('#usersProfile', function () {
            App.alert('Дані оновлено.', 'success', $("#usersProfile .response"));
        });
        App.validateAjaxForm('#usersUpdatePassword', function () {
            App.alert('Дані оновлено.', 'success', $("#usersUpdatePassword .response"));
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