var app = {

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

        (function() {
            var logForm = $('#login');
            if(logForm.length){
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
                $('#show-value').on('click', function(){
                    var input =  $('#password');
                    var inputType =  input.attr('type');
                    $(this).toggleClass('visible');
                    if(inputType == 'password'){
                        input.attr('type','text');
                    }else{
                        input.attr('type','password');
                    }

                });
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



    }


};

$(document).ready(function(){
    app.init();
    app.toggleSidebar();
    app.toggleNav();
});

