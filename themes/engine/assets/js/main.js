var engine = {
    require: function(src)
    {
        var sc = document.createElement('script');
        sc.type = 'text/javascript';
        sc.async = true;
        sc.src = '/themes/engine/assets/js/bootstrap/' + src + '.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(sc, s);
    },
    validateAjaxForm: function(myForm, onSuccess, ajaxParams, rules){
        rules = typeof rules == 'undefined' ? [] : rules;
        function showError(form, inp)
        {
            var $validator = $(form).validate(), e = [];
            $(inp).each(function(k, i){
                $validator.showErrors(i);
            });
        }
        $(myForm).validate({
            errorElement: 'span',
            rules: rules,
            debug: true,
            submitHandler: function(form) {
                var bSubmit = $('.b-submit, .ui-button');
                var settings = {
                    dataType: 'json',
                    beforeSend: function()
                    {
                        bSubmit.attr('disabled', true);
                        return true;
                    },
                    success: function(d)
                    {
                        bSubmit.removeAttr('disabled');
                        if(! d.s ){
                            showError(form, d.i)
                        } else {
                            if(typeof onSuccess != 'undefined'){
                                onSuccess(d);
                            }
                        }
                    },
                    error: function(d)
                    {
                        alert(d.responseText);
                    }
                };

                if(typeof ajaxParams != 'undefined'){
                    settings = $.extend(settings, ajaxParams);
                }

                $(form).ajaxSubmit(settings);
            }
        });
    },
    dialog: function(args)
    {
        return $('<div></div>')
            .attr('id', 'modal' + Date.now())
            .html(args.content)
            .appendTo('body')
            .dialog(args)
        ;
    },
    confirm: function(msg, success)
    {
        return engine.dialog({
            content: msg,
            title: 'Увага',
            autoOpen: true,
            width: 500,
            modal: true,
            buttons: {
                "Так": success
            }
        });
    },
    alert: function(msg)
    {
        return engine.dialog({
            content: msg,
            title: 'Інфомація',
            autoOpen: true,
            width: 500,
            modal: true,
            buttons: {
                "Ok": function(){$(this).dialog('close');}
            }
        });
    },
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
            //var data =  {token: TOKEN};
            return $.ajax({
                url      : url,
                //data     : data,
                success  : success,
                dataType : dataType,
                type     : 'get'
            })
        },
        post: function(data)
        {
            if(typeof data['data'] == 'undefined') {
                alert('Post data is undefined');
            }
            data['data']['token'] = TOKEN;
            data['type'] = 'post';
            return $.ajax(data)
        }
    },
    /**
     * Refresh DataTables
     * @param tableId
     */
    refreshDataTable: function(tableId)
    {
        var oTable = $('#'+tableId).dataTable();
        oTable.fnDraw(oTable.fnSettings());
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
            //$( "#dialog" ).dialog();
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
    tree : function(id)
    {
        id = typeof id == 'undefined' ? 'tree' : id;

        var config = {
            'core': {
                'themes' : {
                    'responsive': false
                },
                'data': {
                    'url': "",
                    'type': 'GET',
                    'dataType': 'JSON',
                    'contentType':'application/json',
                    'data': function (node) {
                        return { token: TOKEN, id: node.id};
                    }
                }
            },
            'types' : {
                /*'default' : {
                    'icon' : 'fa fa-folder icon-state-info icon-md'
                },
                'model' : {
                    'icon' : 'fa fa-file icon-state-default icon-md'
                }*/
            },
            "contextmenu" : {
                items: {
                    "ccp" : false
                }
            },
            "plugins" : [ "wholerow" ]
        };

        return {
            setPlugin: function(plugin)
            {
                config.plugins.push(plugin);

                return this;
            },
            setType: function(type, args)
            {
                config.types[type] = args;

                this.setPlugin('types');

                return this;
            },
            setData : function(data)
            {
                config.core.data = $.extend(config.data, data);

                return this;
            },
            setUrl: function(url)
            {
                config.core.data.url = url;

                return this;
            },
            setConfig: function(c){
                config = $.extend(config, c);

                return this;
            },
            /**
             * action ecample "action": function (obj) {
                            var node_id= obj.reference[0].id;
                        }
             * @param name
             * @param label
             * @param icon
             * @param action
             * @returns {engine}
             */
            setContextMenu: function(name, label, icon, action)
            {

                //config.contextmenu.items.ccp = false;

                config.contextmenu.items[name] = {
                    "label" : label,
                    "icon" : 'fa ' + icon,
                    "action": action
                };

                //this.setPlugin('contextmenu');

                return this;
            },
            init: function()
            {
                console.dir(config);
                var $tree = $('#' + id);
                if($tree.length == 0) {
                    console.error('Tree #' + id + ' not found');
                    return ;
                }

                $tree.jstree(config);
            }
        };
    }
};

$(document).ready(function(){
    engine.init();
    engine.toggleSidebar();
    engine.toggleNav();
    engine.admin.init();

    var tree = new engine.tree('usersGroup');
    console.dir(tree);
    tree
        .setUrl('./plugins/UsersGroup/items')
        .setContextMenu('create', 'Додати', 'fa-file', function(o){
            var node_id= o.reference[0].id;

            }
        )
        .init();
});

engine.admin = {
    init : function()
    {
        var logForm = $('#adminLogin'), fpForm = $('#adminFp');
        //if(logForm.length == 0) return ;

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

        engine.validateAjaxForm('#adminLogin', function () {
            self.location.href = "/engine/dashboard";
        });

        engine.validateAjaxForm('#adminFp', function () {
            setTimeout(function(){$('.b-admin-login').click();}, 1500);
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

        $(document).on('click','.b-admin-profile', function(e){
            e.preventDefault();
            engine.admin.editProfile();
        });
    },
    editProfile: function()
    {
        engine.request.get('admin/profile', function(d){
           var pw = engine.dialog({
                content: d,
                title: 'Мій профіль',
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#editProfileForm').submit();
                    }
                }
            });
            engine.validateAjaxForm('#editProfileForm', function(d){
                if(d.a == null){
                    pw.dialog('close');
                } else{
                    $('.admin-avatar').attr('src' , d.a);
                }

            });
            $('#changeAvatar').click(function(){
                $('#adminAvatar')
                       .trigger('click')
                       .change(function(){
                           $('#editProfileForm').submit();
                       });
            });
        });
    }
};
