var engine = {
    request:  {
        /**
         * send get request
         * @param url
         * @param success
         * @param dataType
         * @returns {*}
         */
        get: function(url, success, dataType)
        {
            var data =  {token: TOKEN};
            return $.ajax({
                url      : url,
                data     : data,
                success  : success,
                dataType : dataType,
                type     : 'get'
            })
        },
        post: function(data)
        {
            data['data']['token'] = TOKEN;
            data['type'] = 'post';
            return $.ajax(data)
        }
    },
    toggleSidebar: function(){
        var page = $('.page');
        var sidebarBtn = $('.sidebar .toggle-btn');
        var dashboard = $('.dashboard-content');
        if(sidebarBtn.length){
            sidebarBtn.on('click', function(){
               dashboard.removeClass('no-sidebar');
               $(this).parents('.sidebar').toggleClass('sidebar-open');
               dashboard.toggleClass('sidebar-open');
           });
        }else{
           dashboard.addClass('no-sidebar');
        }
    },

    toggleNav: function(){
        var nav =  $('.side-nav');
        nav.hover(function(){
            if(!$(this).hasClass('nav-open')){
                $(this).addClass('nav-open').removeClass('nav-close');
            }
        },function(){
            if($(this).hasClass('nav-open')){
                $(this).removeClass('nav-open').addClass('nav-close');
            }
        });

    },

    init: function(){

        (function(){
            var button = $(".btn");
            if(button.length){
                button.materialripple();
            }
        })();

        (function(){
            $('.side-nav').find('.has-child').on('click', function(){
                var drop = $(this).find('.second-level');
                var icon = $(this).find('.toggle-child');
                toggleAll(icon);
                drop.stop().slideToggle(250);
                icon.toggleClass('active');
            });

            function toggleAll(icon){
                $('.side-nav').find('.second-level').each(function(){
                    $(this).stop().slideUp(250);
                });
                $('.side-nav').find('.toggle-child').each(function(){
                    $(this).not(icon).removeClass('active');
                });
            }

        })();

        (function(){
            $( "#dialog" ).dialog();
            $( "#datepicker" ).datepicker();
            $('#example').DataTable();
        })();

        (function(){
            var treeList = $('#tree');
            if(treeList.length){
                treeList.jstree({
                    "plugins" : [ "themes", "html_data", "ui", "crrm", "contextmenu" ],
                    "contextmenu": {
                        "items": function () {
                            return {
                                "Create": {
                                    "label": "Додати сторінку",
                                    'icon': "fa fa-plus"
                                },
                                "Edit": {
                                    "label": "Редагувати сторінгку",
                                    'icon':'fa fa-pencil'
                                },
                                "List": {
                                    "label": "Список підсторінок",
                                    'icon': 'fa fa-list'
                                },
                                "Delete": {
                                    "label": "Видалити сторінку",
                                    'icon': 'fa fa-times-circle-o'
                                }
                            };
                        }
                    }
                });
            }
        })();
    },
     validateError: function(form, inp)
    {
        var $validator = $(form).validate(), e = [];

        $(inp).each(function(k, i){
            $validator.showErrors(i);
        });
    }
};

$(document).ready(function(){
    engine.init();
    engine.toggleSidebar();
    engine.toggleNav();
    engine.admin.init();
});

engine.admin = {
    init : function()
    {
        var logForm = $('#adminLogin'), fpForm = $('#adminFp');
        if(logForm.length == 0) return ;

        logForm.find('.input-group').each(function(){
            $(this).find('input').on('focus', function(){
                $(this).parent().addClass('transformed');
            });
            $(this).find('input').on('focusout', function(){
                if($(this).val()==''){
                    $(this).parent().removeClass('transformed');
                }
            });
        });

        $(document).on('click', '#show-pass', function(){
            var input =  $('#password');
            var inputType =  input.attr('type');
            $(this).toggleClass('visible');
            if(inputType == 'password'){
                input.attr('type','text');
            }else{
                input.attr('type','password');
            }

        });

        logForm.validate({
            rules: {
                'data[email]': {
                    required: true,
                    email: true
                }
            },
            submitHandler: function(form) {

                var bSubmit = $('.b-submit');
                $(form).ajaxSubmit({
                    dataType: 'json',
                    beforeSend: function()
                    {
                        bSubmit.attr('disabled', true);
                        return true;
                    },
                    success: function(d)
                    {
                        bSubmit.removeAttr('disabled');
                        if(d.s){
                            self.location.href = "/engine/dashboard";
                        } else {
                            engine.validateError(form, d.i)
                        }
                    }
                });
            }
        });

        fpForm.validate({
            rules: {
                'data[email]': {
                    required: true,
                    email: true
                }
            },
            submitHandler: function(form) {

                var bSubmit = $('.b-submit');
                $(form).ajaxSubmit({
                    dataType: 'json',
                    beforeSend: function()
                    {
                        bSubmit.attr('disabled', true);
                        return true;
                    },
                    success: function(d)
                    {
                        bSubmit.removeAttr('disabled');
                        engine.validateError(form, d.i);
                        if(d.s){
                            setTimeout(function(){$('.b-admin-login').click();}, 1500);
                        }
                    }
                });
            }
        });

        $(document).on('change', '#adminLang', function(e){
            e.preventDefault();
            var l = this.value;
            self.location.href= '/engine/admin/login/'+l;
        });
        $(document).on('click', '.b-admin-fp', function(e){
            e.preventDefault();
            logForm.slideUp(300, function(){
                fpForm.slideDown(300);
            });
        });
        $(document).on('click', '.b-admin-login', function(e){
            e.preventDefault();
            fpForm.slideUp(300, function(){
                logForm.slideDown(300);
            });
        });
    }
};