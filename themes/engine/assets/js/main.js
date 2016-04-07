var engine = {
    require: function(src, path)
    {
        path = typeof path == 'undefined' ? '/themes/engine/assets/js/bootstrap/' : path;
        var sc = document.createElement('script');
        sc.type = 'text/javascript';
        sc.async = true;
        sc.src = path + src + '.js';
        var s = document.getElementById('componentScript');
        s.parentNode.insertBefore(sc, s);
    },
    showFormErrors: function (form, inp)
    {
        var $validator = $(form).validate(), e = [];
        $(inp).each(function(k, i){
            $validator.showErrors(i);
        });
    },
    ckUpdate: function(){
        if(typeof CKEDITOR =='undefined') return ;
        for ( instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
    },
    validateAjaxForm: function(myForm, onSuccess, ajaxParams, rules, onBeforeSend){

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
                var bSubmit = $('.b-submit, .b-form-save');
                var settings = {
                    dataType: 'json',
                    beforeSend: function()
                    {
                        // console.log('OnBeforeSend >>');
                        bSubmit.attr('disabled', true);

                        if(typeof onBeforeSend == 'string'){
                            try {
                                onBeforeSend += '()';
                                var fn = new Function('', onBeforeSend);
                               return fn();
                            } catch (err) {
                                console.info(onBeforeSend + ' is undefined.');
                            }
                        } else if(typeof onBeforeSend != 'undefined'){
                           return onBeforeSend();
                        }
                        return true;
                    },
                    success: function(d)
                    {
                        bSubmit.removeAttr('disabled');
                        if(! d.s ){
                            showError(form, d.i)
                        } else {

                            if(typeof d.m != 'undefined'){
                                d.e = typeof d.e == 'undefined' ? null : d.e;
                                engine.notify(d.m, d.t, 'success');
                            }

                            if(typeof onSuccess == 'string'){
                                try {
                                    onSuccess += '(d)';
                                    var fn = new Function('d', onSuccess);
                                    fn(d);
                                } catch (err) {
                                    console.info(onSuccess + ' is undefined.');
                                }
                            } else if(typeof onSuccess != 'undefined'){
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
    closeDialog: function(){
      $(".ui-dialog-content").dialog("close");
      setTimeout(function(){
          $('.ui-dialog *').remove();
      }, 300);
        //$('.ui-dialog, .ui-widget-overlay').remove();
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
    notify: function(msg, title, status)
    {
        var c = $('.inline-notifications');
        title = typeof title   =='undefined' ?  'Інформація' : title;
        status = typeof status =='undefined' ? 'info' : status;
        c.html("<div class='alert alert-"+status+" alert-dismissible' role='alert'>\
            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\
            <strong>"+title+"</strong>"+status+"\
        </div>");
        setTimeout(function(){c.html('');}, 7000)
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

        var $form = $('#form') ;
        if($form.length){
            $('.datepicker').datepicker({
                dateFormat: 'dd.mm.yy'
            });

            //validateAjaxForm: function(myForm, onSuccess, ajaxParams, rules, onBeforeSend){
            engine.validateAjaxForm('#form', $form.data('success'), {}, $form.data('rules'), $form.data('beforesend'));
            $('.b-form-save').click(function()
            {
                engine.ckUpdate();
                setTimeout(function(){
                    $form.submit();
                },300);

            });
        }

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

    },
    tree : function(id)
    {
        id = typeof id == 'undefined' ? 'tree' : id;

        var config = {
            'core': {
                "check_callback" : true,
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
            "cookies" : {
                auto_save: true,
                cookie_options : {path: '/engine'}
            },
            'types' : {
                /*'default' : {
                    'icon' : 'fa fa-folder icon-state-info icon-md',
                },
                'file' : {
                    'icon' : 'fa fa-file icon-state-default icon-md'
                }*/
            },
            "contextmenu" : {
                items: {
                    "ccp" : false
                },
                hide_on_mouseleave: true
            },
            "plugins" : [ "wholerow",  "ui", 'crrm', "cookies" ]
        };

        var moveCallback;

        return {
            refresh : function()
            {
                $('#'+id).jstree("refresh");
            },
            setPlugin: function(plugin)
            {
                for(var i=0;i<config.plugins.length; i++){
                    if(config.plugins[i] == plugin){
                        return this;
                    }
                }
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
             * action example "action": function (obj) {
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
                config.contextmenu.items[name] = {
                    "label" : label,
                    "icon" : 'fa ' + icon,
                    "action": action
                };

                this.setPlugin('contextmenu');

                return this;
            },
            move: function(callback)
            {
                moveCallback = callback;
                this.setPlugin('dnd');

                return this;
            },
            init: function()
            {
                var $tree = $('#' + id);
                if($tree.length == 0) {
                    console.error('Tree #' + id + ' not found');
                    return ;
                }

                $tree.jstree(config)
                    .on('click', 'a', function(e) {
                        e.preventDefault();
                        var treeLink = $(this).attr("href");
                        if (treeLink !== "#"){
                            self.location.href = treeLink;
                        }
                    });

                    if(typeof moveCallback != 'undefined'){
                        $tree.bind("move_node.jstree", moveCallback);
                    }


                    //$tree.delegate('a', 'contextmenu', function(e) {
                    //    var id = $.jstree._focused()._get_node(this).attr('id');
                    //    $.cookie('jstree_select', '#'+id);
                    //    $('.jstree a').removeClass('jstree-clicked');
                    //    $('li#'+id).find('a:first').addClass('jstree-clicked');
                    //});
            }
        };
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

        if(logForm.length){

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
        }


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
/**
 * Components
 */
engine.components = {
    init: function()
    {
        $(document).on('click', '.b-component-pub', function(){
            engine.components.pub($(this).data('id'));
        });

        $(document).on('click', '.b-component-hide', function(){
            engine.components.hide($(this).data('id'));
        });

        $(document).on('click', '.b-component-install', function(){
            engine.components.install($(this).data('id'),$(this).data('type'));
        });

        $(document).on('click', '.b-component-uninstall', function(){
            engine.components.uninstall($(this).data('id'));
        });
        $(document).on('click', '.b-component-edit', function(){
            engine.components.edit($(this).data('id'), $(this).data('type'));
        });
        $(document).on('click', '.install-archive', function(){
            engine.components.install(null, 'archive');
        });
    },
    pub : function(id)
    {
        engine.confirm
        (
            t.components.pub_question,
            function()
            {
                engine.request.post({
                    url: './components/pub',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('components');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    hide : function(id)
    {
        engine.confirm
        (
            t.components.hide_question,
            function()
            {
                engine.request.post({
                    url: './components/hide',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('components');
                        }
                    }
                });
                engine.closeDialog();
            }
        );
    },
    install: function(component, type)
    {
        engine.request.post({
            url: './components/install',
            data: {c: component, t: type},
            success: function(d)
            {
                var bi = t.components.button_install;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#componentsInstall').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: 'Встановлення компоненту',
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });
                $('#data_parent_id').select2();

                engine.validateAjaxForm('#componentsInstall', function(d){
                    if(d.s){
                        engine.refreshDataTable('components');
                        engine.closeDialog();
                        if(typeof d.m != 'undefined' && d.m != ''){
                            engine.alert(d.m);
                        }

                    }
                });
            }
        })
    },
    uninstall: function(id)
    {
        engine.confirm
        (
            t.components.uninstall_question,
            function()
            {
                engine.request.post({
                    url: './components/uninstall',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('components');
                        }
                    }
                });
                engine.closeDialog();
            }
        );
    },
    edit: function(id, type)
    {
        engine.request.post({
            url: './components/edit/' + id,
            data: {id: id, c: type},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.components.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });
                $('#data_parent_id').select2();

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('components');
                        engine.closeDialog();
                    }
                });
            }
        })
    }
};
engine.admins = {
    init: function()
    {
        // console.log('Init admins');
        $(document).on('click', '.b-admins-create', function(){
            engine.admins.create();
        });

        $(document).on('click', '.b-admins-edit', function(){
            engine.admins.edit($(this).data('id'));
        });

        $(document).on('click', '.b-admins-delete', function(){
            engine.admins.delete($(this).data('id'));
        });
        $(document).on('click', '.b-admins-restore', function(){
            engine.admins.restore($(this).data('id'));
        });
        $(document).on('click', '.b-admins-remove', function(){
            engine.admins.remove($(this).data('id'));
        });
        $(document).on('click', '.b-admins-ban', function(){
            engine.admins.ban($(this).data('id'));
        });
        $(document).on('click', '.b-admins-group-create', function(){
            engine.admins.group.create(0);
        });

        $(document).on('click','#changeAdminAvatar',function(){
            $('#adminAvatar')
                .trigger('click')
                .change(function(){
                    $('#form').submit();
                });
        });
        if($('#usersGroup').length){

            engine.admins.group.tree = new engine.tree('usersGroup');
            engine.admins.group.tree
                .setUrl('./plugins/adminsGroup/tree')
                .setContextMenu('create', t.admins_group.tree_create, 'fa-file', function(o){
                        var node_id= o.reference[0].id;
                        engine.admins.group.create(node_id);
                    }
                )
                .setContextMenu('edit', t.admins_group.tree_edit, 'fa-pencil', function(o){
                        var node_id= o.reference[0].id;
                        engine.admins.group.edit(node_id);
                    }
                )
                .setContextMenu('del', t.admins_group.tree_delete, 'fa-remove', function(o){
                        var node_id= o.reference[0].id;
                        engine.admins.group.delete(node_id);
                    }
                )
                .move(function(e, data){
                    // console.log(data);

                    engine.request.post({
                        url : './plugins/adminsGroup/move',
                        data: {
                            id: data.node.id,
                            'old_parent' : data.old_parent,
                            //'old_position' : data.old_position,
                            'parent' : data.parent,
                            'position' : data.position
                        }
                    });
                })
                .init();
        }


    },
    create: function()
    {
        engine.request.get('./admins/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.admins.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            $('#data_phone').mask('+99 (999) 9999999');
            $('#data_group_id').select2();

            engine.validateAjaxForm
            (
                '#form',
                function(d){
                    if(d.s){
                        engine.refreshDataTable('admins');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                },
                {
                    'data[password]': {
                        equalTo: "#data_password"
                    }
                }
            );
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './admins/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.admins.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#data_phone').mask('+99 (999) 9999999');

                $('#data_group_id').select2();

                engine.validateAjaxForm('#form', function(d){
                        if(d.s){
                            engine.refreshDataTable('admins');
                            if(d.a == null){
                                dialog.dialog('close');
                                dialog.dialog('destroy').remove()
                            } else{
                                $('.edit-admin-avatar').attr('src', d.a);
                            }
                        }
                    },
                    {
                        'data[password]': {
                            equalTo: "#data_password"
                        }
                    });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.admins.delete_question,
            function()
            {
                engine.request.get('./admins/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('admins');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    ban: function(id)
    {
        engine.confirm
        (
            t.admins.ban_question,
            function()
            {
                engine.request.get('./admins/ban/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('admins');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    remove: function(id)
    {
        engine.confirm
        (
            t.admins.remove_question,
            function()
            {
                engine.request.get('./admins/remove/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('admins');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    restore: function(id)
    {
        engine.confirm
        (
            t.admins.restore_question,
            function()
            {
                engine.request.get('./admins/restore/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('admins');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    group: {
        tree: null,
        create: function(parent_id)
        {
            engine.request.post(
                {
                    url: './plugins/adminsGroup/create/'+parent_id,
                    data:{a:1},
                    success: function(d)
                    {
                        var bi = t.common.button_save;
                        var buttons = {};
                        buttons[bi] =  function(){
                            $('#adminsGroupForm').submit();
                        };
                        var dialog = engine.dialog({
                            content: d,
                            title: t.admins_group.create_title,
                            autoOpen: true,
                            width: 750,
                            modal: true,
                            buttons: buttons
                        });

                        $('#data_parent_id').select2();

                        engine.validateAjaxForm
                        (
                            '#adminsGroupForm',
                            function(d){
                                if(d.s){
                                    //engine.refreshDataTable('admins');
                                    engine.admins.group.tree.refresh();
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            }
                        );
                    }
                });
        },
        edit: function(id)
        {
            engine.request.post({
                url: './plugins/adminsGroup/edit/' + id,
                data: {id: id, a: 1},
                success: function(d)
                {
                    var bi = t.common.button_save;
                    var buttons = {};
                    buttons[bi] =  function(){
                        $('#adminsGroupForm').submit();
                    };
                    var dialog = engine.dialog({
                        content: d,
                        title: t.admins_group.edit_title,
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: buttons
                    });

                    $('#data_group_id').select2();

                    engine.validateAjaxForm('#adminsGroupForm', function(d){
                        if(d.s){
                            engine.admins.group.tree.refresh();
                            dialog.dialog('close');
                            dialog.dialog('destroy').remove()
                        }
                    });
                }
            })
        },
        delete: function(id)
        {
            var dialog = engine.confirm
            (
                t.admins_group.delete_question,
                function()
                {
                    engine.request.post(
                        {
                            url:'./plugins/adminsGroup/delete/' + id,
                            data: {a: 1},
                            success: function(d){
                                if(d > 0){

                                    engine.admins.group.tree.refresh();
                                    dialog.dialog('close');
                                    dialog.dialog('destroy').remove()
                                }
                            }
                        }
                    );
                }
            );
        }
    }
};

engine.chunks = {
    init: function()
    {
        // console.log('engine.chunks.init() -> OK');
        $(document).on('click', '.b-chunks-delete', function(){
            var id = $(this).data('id');
            engine.chunks.delete(id);
        });
    },
    onCreateSuccess: function(d)
    {
        location.href = "./chunks";
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.chunks.delete_confirm,
            function()
            {
                engine.request.get('./chunks/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('chunks');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};
/**
 * Created by wg on 29.02.16.
 */
engine.content = {
    init: function () {
        //// console.log('engine.content.init()');

        var infoName = $(".info-name");
        infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});


        $(".info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
        $(".info-title,.into-h1,.info-description") //.info-keywords,
            .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

        infoName.each(function(i,e){
            var inp = $('.info-url:eq('+i+')'), title = $('.info-title:eq('+i+')'), lang = $(this).data('lang');
            var te = title.val() == '', parent_url = inp.data('parent-url');
            if(parent_url != '') parent_url += '/';

            $(this).keyup(function(){
                var text = this.value;

                if(te) {
                    title.val(text);
                }

                var url = engine.content.translit(text, lang);
                inp.val(parent_url + url);
            });
        });

        $('#switchLanguages').find('button').click(function(){
            $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
            var code = $(this).data('code');
            $('.switch-lang:not(.lang-'+code+')').hide();
            $('.switch-lang.lang-' + code).show();
        });

        this.features.init();
    },
    delete: function (id, callback) {
        engine.request.get('content/delete/' + id, function (d) {
            if (d.s) {
                engine.refreshDataTable('content');
                engine.closeDialog();

                if(typeof callback != 'undefined'){
                    callback(d);
                }

            } else {
                engine.alert(d.m);
            }
        }, 'json')
    },
    pub: function (id) {
        engine.request.get('content/pub/' + id, function (d) {
            engine.refreshDataTable('content');
        });
    },
    hide: function (id) {
        engine.request.get('content/hide/' + id, function (d) {
            engine.refreshDataTable('content');
        });
    },
    translit: function (text, lang) {
        function trim(s) {
            s = s.replace(/^-/, '');
            return s.replace(/-$/, '');
        }


        var space = '-';
        text = text.toLowerCase();

        var transl = {};

        switch (lang){
            case 'uk':
                transl = {
                    'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'e', 'ж': 'zh',
                    'з': 'z', 'и': 'y', 'й': 'j', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'і' : 'i', 'ї' : 'i',
                    'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h',
                    'ц': 'c', 'ч': 'ch', 'ш': 'sh', 'щ': 'sh', 'ъ': space, 'ы': 'y', 'ь': space, 'э': 'e',
                    'ю': 'yu', 'я': 'ya', 'є': 'ye',
                    ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
                    '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
                    '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
                    ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
                    '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
                    '?': space, '<': space, '>': space, '№': space
                };
                break;
            //case 'ru':
            //    transl = {
            //        'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'e', 'ж': 'zh',
            //        'з': 'z', 'и': 'i', 'й': 'j', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'ї' : 'i',
            //        'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h',
            //        'ц': 'c', 'ч': 'ch', 'ш': 'sh', 'щ': 'sh', 'ъ': space, 'ы': 'y', 'ь': space, 'э': 'e', 'ю': 'yu', 'я': 'ya',
            //        ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
            //        '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
            //        '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
            //        ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
            //        '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
            //        '?': space, '<': space, '>': space, '№': space
            //    };
            //    break;
            default:
                transl = {
                    ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
                    '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
                    '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
                    ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
                    '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
                    '?': space, '<': space, '>': space, '№': space
                };
                break;
        }

        var result = '', c = '';

        for (var i = 0; i < text.length; i++) {
            if (transl[text[i]] != undefined) {
                if (c != transl[text[i]] || c != space) {
                    result += transl[text[i]];
                    c = transl[text[i]];
                }
            }
            else {
                result += text[i];
                c = text[i];
            }
        }

        return trim(result);
    },
    features: {
        init: function()
        {
            $(document).on('click', '.b-ct-features-add', function(){
                var content_id = $('#contentFeaturesFs').data('id');
                var parent_id  = $(this).data('parent');

                engine.content.features.add(content_id, parent_id);
            });

            $(document).on('click', '.b-cf-add-val', function(){
                var parent_id  = $(this).data('parent');

                engine.content.features.addValue(parent_id);
            });

            $(document).on('click', '.cf-file-browse', function(){
                var target = $(this).data('target');
                engine.content.features.fileBrowse(target);
            });

            $('.cf-feature-select').select2();

            $(document).on('change', '#main_categories_id', function(){
                var id= this.value;
                engine.content.features.get(id);
            });
            if($('html').data('action') == 'create'){
                $("#main_categories_id").trigger('change');
            }
        },
        get: function(categories_id)
        {
            var cnt = $("#content_features_0"), content_id=cnt.data('id');
            engine.request.get
            (
                'contentFeatures/index/'+categories_id + '/'+content_id,
                function(res)
                {
                    cnt.html(res);
                },
                'html'
            );
        },
        add: function(content_id, parent_id)
        {
            var FS = features_settings || [];
            engine.request.post({
                url: 'contentFeatures/create',
                data: {
                    content_id     : content_id,
                    parent_id      : parent_id,
                    allowed        : (typeof  FS.allowed_types == 'undefined' ? null : FS.allowed_types),
                    disable_values : (typeof  FS.disable_values == 'undefined' ? 0 : FS.disable_values)
                },
                success: function(res){
                    var pw = engine.dialog({
                        content: res,
                        title: 'Створення властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            if(res.f != null){
                                $("#content_features_" + parent_id).append(res.f);
                            }
                        }
                    });

                    $('.cf-feature-select').select2();

                    $('#data_type')
                        .change(function(){
                            if(this.value == 'select'){
                                $('.fg-show-filter, .fg-multiple').show();
                            } else {
                                $('.fg-show-filter, .fg-multiple').hide();
                            }
                        })
                        .trigger('change');

                    var inp = $('.f-info-name:first'), lang = inp.data('lang'), code = $('#f_data_code');
                    var ce = code.val() == '';
                    inp.keyup(function(){
                        var text = this.value;

                        if(ce) {
                            text = engine.content.translit(text, lang);
                            text = text.replace(/-/g, '_');
                            code.val(text);
                        }
                    });
                }
            });
        },
        addValue: function(parent_id)
        {
            engine.request.post({
                url: 'contentFeatures/createValue',
                data: {
                    parent_id  : parent_id
                },
                success: function(res){
                    var pw = engine.dialog({
                        content: res,
                        title: 'Створення значеня',
                        autoOpen: true,
                        width: 600,
                        modal: true,
                        buttons: {
                            "Зберегти": function(){
                                $('#formContentFeaturesValues').submit();
                            }
                        }
                    });

                    engine.validateAjaxForm('#formContentFeaturesValues', function(res){
                        if(res.s > 0){
                            if(res.v){
                                var opt = "<option selected value='"+ res.v.value +"'>"+ res.v.name +"</option>";
                                $('#content_features_' + parent_id).append(opt).select2();
                            }
                            pw.dialog('close').remove();
                        }
                    });
                }
            });
        },
        fileBrowse: function(targetID)
        {
            var frame = '<iframe width="100%" height="570" src="/vendor/filemanager/dialog.php?type=1&field_id='+targetID+'&token='+TOKEN+'" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>';
            engine.dialog({
                content: frame,
                title: 'Файловий менеджер',
                autoOpen: true,
                width: 880,
                modal: true,
                buttons: {}
            });
        }
    }
};
engine.contentImages = {
    init: function () {
        if($('#contentImagesDz').length == 0) return;

        Dropzone.options.contentImagesDropzone = false; // Prevent Dropzone from auto discovering this element
        var content_id = $('#content_id').val();

        this.makeDropzone();

        $('.gallery-uploader').on('click', '.remove-item', function(event) {
            event.preventDefault();
            var id = $(this).data('id');
            engine.contentImages.removeImage(id, this);
        });

        $('.gallery-uploader').on('click', '.trash-item, .remove-cancel', function(event) {
            event.preventDefault();
            $(this).parents('.dz-preview').find('.controls').fadeToggle('150');
        });
        $('.gallery-uploader').on('click', '.add', function(event) {
            event.preventDefault();
            $(this).fadeOut(75, function () {
                $(this).parents('.gallery-uploader').toggleClass('active');
                $(this).siblings('.add').fadeIn(150);
            });
        });

        $('#edit-image-modal').on('click', '.btn-success', function(event) {
            $('.editing-item .dz-filename span').text($('#edit-image-modal #image-caption').val());
        });

        $(document).on('click', '.crop-image', function(){
            var id = $(this).data('id');
            engine.contentImages.crop(id);
        });

        var tpl = $('#dzTemplate').html(),
            cnt = $('.gallery-container');
        for(var i=0;i<contentImagesList.length; i++){
            var img = contentImagesList[i];
            var item = tpl
                .toString()
                .replace (/{id}/g, img.id)
                .replace (/{src}/g, img.src);
            cnt.append(item);
        }
    },
    removeImage: function(id, e)
    {
        engine.request.get('./plugins/ContentImages/delete/'+id, function(d){
            if(d == 1){
                $(e).parents('.dz-preview').fadeOut(250, function () {
                    $(e).remove();
                });
            }
        });
    },
    crop: function(id){

    },
    makeDropzone: function () {

        var imagesContainer = $('#contentImagesDz');
        var url = imagesContainer.data('target');
        //var template = _.template(document.getElementById('dzTemplate').innerHTML);
        var template = document.getElementById('dzTemplate').innerHTML;
        imagesContainer.dropzone({
            paramName: "image", // The name that will be used to transfer the file
            maxFilesize: 10, // MB
            acceptedFiles: '.jpg,.jpeg,.png,.gif',
            uploadMultiple: true,
            previewsContainer: '.gallery-container',
            previewTemplate: template,
            parallelUploads:1,
            url: url,
            thumbnailWidth: 125,
            thumbnailHeight: 125,
            sending:  function(file, xhr, formData){
                formData.append('token', TOKEN);
            },
            init: function() {
                this.on("addedfile", function(file) {
//                    // console.log(file);
                });
//                this.on("success", function(file) {
//                    // console.log(file);
//                });
            },
            success: function(file, data) {
                var div = $('.gallery-container > div:last');
                div.attr('id', data.id);
                var str = div.html()
                    .toString()
                    .replace (/{id}/g, data.id)
                //    .replace (/{imageName}/g, data.name);
                div.html(str);
                return true;
            }
        });
    }
};
engine.contentImagesSizes = {
    init: function()
    {
        // console.log('Init contentImagesSizes');

        $(document).on('click', '.b-contentImagesSizes-create', function(){
            engine.contentImagesSizes.create();
        });

        $(document).on('click', '.b-contentImagesSizes-edit', function(){
            engine.contentImagesSizes.edit($(this).data('id'));
        });

        $(document).on('click', '.b-contentImagesSizes-delete', function(){
            engine.contentImagesSizes.delete($(this).data('id'));
        });

        $(document).on('click', '.b-contentImagesSizes-crop', function(){
            engine.contentImagesSizes.crop($(this).data('id'));
        });

    },
    crop: function(id)
    {
        function resizeSuccess(t)
        {
            engine.alert(
                'Ресайз зображень завершено.',
                'Зроблено ресайз '+t+' зображень',
                'success'
            );

            $("#resizeBox").hide();
        }

        function resize(sizes_id, total, start)
        {

            if(start >= total) {
                resizeSuccess();
                return false;
            }

            var percent =  100 / total, done = Math.round( start * percent ) ;
            $("#progress").find('div').css('width', done + '%');

            //setTimeout(function(){
            //start++;
            //resize(sizes_id, total, start);
            //}, 1500);


            engine.request.post({
                url: './contentImagesSizes/resizeItems',
                data: {
                    start: start,
                    sizes_id: sizes_id
                },
                success: function(d){
                    if(d > 0){
                        start++;
                        resize(sizes_id, total, start);
                    } else {
                        resizeSuccess();
                    }
                }
            });

            return false;
        }

        var dw = engine.confirm(t.contentImagesSizes.crop_confirm, function(){
            $("#resizeBox").css('display', 'block');
            engine.request.post({
                url: './contentImagesSizes/resizeGetTotal',
                data: {
                    sizes_id: id
                },
                success: function(d){
                    resize(id, d, 0);
                }
            });
            dw.dialog('close');
        });
    },

    create: function()
    {
        engine.request.get('./contentImagesSizes/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.contentImagesSizes.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            $('#content_types').select2();

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('contentImagesSizesList');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './contentImagesSizes/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.contentImagesSizes.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#content_types').select2();

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('contentImagesSizesList');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.contentImagesSizes.delete_question,
            function()
            {
                engine.request.get('./contentImagesSizes/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('contentImagesSizesList');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

engine.contentTypes = {
    init: function()
    {
        // console.log('engine.contentTypes.init() -> OK');

        $(document).on('click', '.b-contentTypes-delete', function(){
            var id = $(this).data('id');
            engine.contentTypes.delete(id);
        });

        $(document).on('change', '#data_settings_ext_url', function(){
            if($(this).is(':checked')){
                $("#data_settings_parent_id_cnt").show();
            } else{
                $("#data_settings_parent_id_cnt").hide();
            }
        });

        $("#contentImagesSizes,#settingsModules").select2();

        $(document).on('click', '.ct-create-images-size', function(){

            var tmpl = _.template($('#sizesCreate').html());
            var d = tmpl();
            var pw = engine.dialog({
                content: d,
                title: 'Створення розміру',
                autoOpen: true,
                width: 500,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#formCreateSize').submit();
                    }
                }
            });

            engine.validateAjaxForm('#formCreateSize', function(d){
                if(d.s){
                    engine.request.get('contentTypes/getImagesSizes', function(res){
                        var tmpl = _.template('<% for(var i=0;i < items.length; i++) { %><option value="<%- items[i].id %>"><%- items[i].size %></option>  <% } %>');
                        var d = tmpl({items: res.items});
                        $("#contentImagesSizes").html(d).select2();
                        pw.dialog('destroy').remove();
                    }, 'json');
                }
            });

        });

        this.features.init();
    },
    onCreateSuccess: function(d)
    {
        location.href = "./contentTypes";
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.contentTypes.delete_confirm,
            function()
            {
                engine.request.get('./contentTypes/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('contentTypes');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    features : {
        init: function()
        {
            var typesID = $('#typesID').val(),
                subTypesID = $('#subTypesID').val();

            //// console.log('contentTypes.features.init()');

            $(document).on('change', '#features', function()
            {
                if(typesID == ''){
                    engine.alert('Опція доступна тільки для редагування');
                    return ;
                }
                var features_id = this.value;
                engine.request.get
                (
                    'contentTypes/selectFeatures/'+typesID+'/'+subTypesID + '/' + features_id,
                    function(d)
                    {
                        if(d.s){
                            engine.contentTypes.features.refresh(d.sf);
                        }
                    },
                    'json'
                );

            });

            $(document).on('click', '.b-ct-delete-features', function(){
                var id = $(this).data('id');
                var w = engine.confirm('Дійсно видалити?', function(){
                    engine.request.get
                    (
                        'contentTypes/deleteFeatures/'+id,
                        function(d)
                        {
                            if(d){
                                $("#cf-sf-" + id).remove();
                                w.dialog('destroy').remove();
                            }
                        }
                    );
                });
            });
            var selected_features = selected_features || [];
            engine.contentTypes.features.refresh(selected_features);


            // features settings
            $("#settings_features_allowed_types,#settings_features_ex_types_id").select2();

        },
        refresh: function(data)
        {
            if(data.length == 0) return ;
            var tmpl = _.template($('#ftList').html());
            $("#content_features").html(tmpl({items: data}));
        }
    }
};
engine.dashboard = {};
/**
 * Created by wg on 08.02.16.
 */
engine.features = {
    init: function()
    {
        // console.log('engine.features.init() -> OK');
        $(document).on('click', '.b-features-delete', function(){
            var id = $(this).data('id');
            engine.features.delete(id);
        });
        $(document).on('click', '.b-features-pub', function(){
            var id = $(this).data('id');
            engine.features.pub(id);
        });
        $(document).on('click', '.b-features-hide', function(){
            var id = $(this).data('id');
            engine.features.hide(id);
        });
        $(document).on('click', '.b-features-add-value', function(){
            var id = $(this).data('id');
            engine.features.addValue(id);
        });

        $(document).on('click', '.b-features-edit-value', function(){
            var id = $(this).data('id');
            engine.features.editValue(id);
        });

        $('#data_type')
            .change(function(){
                if(this.value == 'select'){
                    $('.fg-show-filter, .fg-multiple').show();
                } else {
                    $('.fg-show-filter, .fg-multiple').hide();
                }
            })
            .trigger('change');

        $(document).on('click', '.b-features-select-ct', function(){
            var id = $(this).data('id');
            engine.features.content.select(id);
        });
        $(document).on('click', '.b-features-delete-ct', function(){
            var id = $(this).data('id');
            engine.features.content.del(id);
        });

        // selected content
        var sc = typeof selected_content == 'undefined' ? [] : selected_content;
        engine.features.content.refresh(sc);
    },
    content: {
        select : function(features_id)
        {
            engine.request.get('features/selectContent/' + features_id, function (d) {
                var pw = engine.dialog({
                    content: d,
                    title: 'Прикріпити до ...',
                    autoOpen: true,
                    width: 500,
                    modal: true,
                    buttons: {
                        "Зберегти": function(){
                            $('#formFeaturesContent').submit();
                        }
                    }
                });

                $('#data_content_id, #data_types_id, #data_subtypes_id').select2();

                $('#data_types_id')
                    .change(function(){
                        $("#data_subtypes_id,#data_content_id").html('').attr('disabled', true);
                        var parent_id = parseInt(this.value);
                        engine.request.get('features/getTypes/'+parent_id, function(d){
                            //if(d.o.length == 0){
                            //    return ;
                            //}
                            var out = '<option value="">Всі</option>';
                            $(d.o).each(function(i,e){
                                out += '<option value="'+ e.id +'">'+ e.name +'</option>';
                            });
                            $("#data_subtypes_id").html(out).removeAttr('disabled').trigger('change');
                        });
                    })
                    .trigger('change');

                $("#data_subtypes_id").change(function(){
                    $("#data_content_id").html('').attr('disabled', true);
                    var type_id    = $('#data_types_id').find('option:selected').attr('value');
                    var subtype_id = this.value;
                    engine.request.get('features/getContent/'+type_id + '/' + subtype_id, function(d){
                        //if(d.o.length == 0){
                        //    return ;
                        //}
                        var out = '<option value="">Всі</option>';
                        $(d.o).each(function(i,e){
                            out += '<option value="'+ e.id +'">'+ e.name +'</option>';
                        });
                        $("#data_content_id").html(out).removeAttr('disabled');
                    });
                });


                engine.validateAjaxForm('#formFeaturesContent', function(d){
                    if(d.s){
                        pw.dialog('destroy').remove();
                        engine.features.content.refresh(d.sc);
                    }
                });
            });
        },
        del: function(id)
        {
            var w = engine.confirm("Дійсно видалити вибраний запис?", function(){
                engine.request.get('features/deleteSelectedContent/'+id, function(d)
                {
                    if(d.s){

                        w.dialog('destroy').remove();
                        $("#f-sc-"+id).remove();
                    }
                },'json');
            });
        },
        refresh: function(data)
        {
            if(data.length == 0) return ;
            var tmpl = _.template($('#ctList').html());
            $("#content_types").html(tmpl({items: data}));
        }
    },
    onCreateSuccess: function(d)
    {
        location.href = "./features";
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.features.delete_confirm,
            function()
            {
                engine.request.get('./features/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('features');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    pub: function (id) {
        engine.request.get('features/pub/' + id, function (d) {
            engine.refreshDataTable('features');
        });
    },
    hide: function (id) {
        engine.request.get('features/hide/' + id, function (d) {
            engine.refreshDataTable('features');
        });
    },
    addValue: function (id) {
        engine.request.get('features/addValue/' + id, function (d) {
            var pw = engine.dialog({
                content: d,
                title: 'Створення властивості',
                autoOpen: true,
                width: 500,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#formFeaturesValue').submit();
                    }
                }
            });

            engine.validateAjaxForm('#formFeaturesValue', function(d){
                if(d.s){
                    pw.dialog('destroy').remove();
                    engine.refreshDataTable('features');
                }
            });
        });
    },
    editValue: function (id) {
        engine.request.get('features/editValue/' + id, function (d) {
            var pw = engine.dialog({
                content: d,
                title: 'Редагування властивості',
                autoOpen: true,
                width: 500,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        $('#formFeaturesValue').submit();
                    }
                }
            });

            engine.validateAjaxForm('#formFeaturesValue', function(d){
                if(d.s){
                    pw.dialog('destroy').remove();
                    engine.refreshDataTable('features');
                }
            });
        });
    }
};
engine.guides = {
    init: function()
    {
        // console.log('Init guides');
        $(document).on('click', '.b-guides-create', function(){
            var parent_id = $(this).data('parent_id');
            engine.guides.create(parent_id);
        });
        $(document).on('click', '.b-guides-edit', function(){
            engine.guides.edit($(this).data('id'));
        });
        $(document).on('click', '.b-guides-delete', function(){
            engine.guides.delete($(this).data('id'));
        });
    },
    create: function(parent_id)
    {
        engine.request.get('./guides/create/' + parent_id, function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.guides.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('guides');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './guides/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.guides.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('guides');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.guides.delete_question,
            function()
            {
                engine.request.get('./guides/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('guides');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};
engine.languages = {
    init: function()
    {
        // console.log('Init languages');
        $(document).on('click', '.b-languages-create', function(){
            engine.languages.create();
        });
        $(document).on('click', '.b-languages-edit', function(){
            engine.languages.edit($(this).data('id'));
        });
        $(document).on('click', '.b-languages-delete', function(){
            engine.languages.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./languages/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};
            buttons[bi] =  function(){
                $('#form').submit();
            };
            var dialog = engine.dialog({
                content: d,
                title: t.languages.create_title,
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: buttons
            });

            $('#data_code').mask('aa');

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('languages');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './languages/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.languages.edit_title,
                    autoOpen: true,
                    width: 600,
                    modal: true,
                    buttons: buttons
                });

                $('#data_code').mask('aa');

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('languages');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.languages.delete_question,
            function()
            {
                engine.request.get('./languages/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('languages');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};
engine.nav = {
    init: function()
    {
        //engine.require('content');
        // console.log('engine.nav.init() OK');

        $(document).on('click', '.b-nav-delete', function(){
            engine.nav.delete($(this).data('id'));
        });
        $(document).on('click', '.b-nav-item-delete', function(){
            engine.nav.deleteItem($(this).data('id'));
        });

        $('#data_code').change(function(){
            this.value = engine.content.translit( this.value, 'uk');
        });

        $('#selItems').change(function(){

            if(this.value == '') return ;

            var item_id = this.value,
                nav_id = $(this).data('nav'),
                is_selected = false;

            $(selected_items).each(function(i,e){
                if(e.id == item_id){
                    is_selected = true;
                    return;
                }
            });

            if(is_selected){
                engine.alert('Цей пункт вже вибраний!');

                return ;
            }

            engine.request.post({
                url: 'nav/addItem',
                data: {
                    item_id : item_id,
                    nav_id  : nav_id
                },
                success: function(res)
                {
                    if(res.s){
                        engine.nav.renderItems(res.items);
                    }
                }
            });
        });

        if(typeof selected_items != 'undefined'){

            setTimeout(function(){
                engine.nav.renderItems(selected_items);
            }, 100);

        }

    },
    delete: function(id)
    {
        engine.confirm
        (
            t.nav.delete_question,
            function()
            {
                engine.request.get('./nav/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('nav');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    deleteItem: function(id)
    {
        engine.confirm
        (
            t.nav.delete_item_question,
            function()
            {
                engine.request.get('./nav/deleteItem/' + id, function(d){
                    if(d > 0){
                        $("#nav-item-"+id).remove();
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    renderItems: function(items)
    {
        if(items.length == 0) return ;
        var tmpl = _.template($('#nItems').html());
        $("#navItems").html(tmpl({items: items}));

        $("#tblItems tbody").sortable({
            handle: ".sort",
            update: function()
            {
                engine.nav.setPositions();
            }
        });


        engine.nav.setPositions();
    },
    setPositions: function()
    {
        var inp = $('#pos'), pos = [];
        $("#tblItems tbody tr").each(function(){
            var id = $(this).attr('id'); id = id.replace('nav-item-', ''); id= parseInt(id);
            pos.push(id);
        });

        inp.val(pos.join('x'));
    }
};
engine.plugins = {
    init: function()
    {
        //engine.require('installer');

        // console.log('Init plugins');

        $(document).on('click', '.b-plugin-pub', function(){
            engine.plugins.pub($(this).data('id'));
        });

        $(document).on('click', '.b-plugin-hide', function(){
            engine.plugins.hide($(this).data('id'));
        });

        $(document).on('click', '.b-plugin-install', function(){
            engine.plugins.install($(this).data('id'));
        });

        $(document).on('click', '.b-plugin-uninstall', function(){
            engine.plugins.uninstall($(this).data('id'));
        });
        $(document).on('click', '.b-plugin-edit', function(){
            engine.plugins.edit($(this).data('id'));
        });
        $(document).on('click', '.install-archive', function(){
            engine.plugins.install(null, 'archive');
        });
    },
    pub : function(id)
    {
        engine.confirm
        (
            t.plugins.pub_question,
            function()
            {
                engine.request.post({
                    url: './plugins/pub',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('plugins');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    hide : function(id)
    {
        engine.confirm
        (
            t.plugins.hide_question,
            function()
            {
                engine.request.post({
                    url: './plugins/hide',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('plugins');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    install: function(plugin)
    {
        engine.request.post({
            url: './plugins/install',
            data: {c: plugin},
            success: function(d)
            {
                var bi = t.plugins.button_install;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#pluginsInstall').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.plugins.install_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });
                $('#components').select2();
                engine.validateAjaxForm('#pluginsInstall', function(d){
                    if(d.s){
                        engine.refreshDataTable('plugins');
                        dialog.dialog('close').dialog('destroy').remove();
                        if(typeof d.m != 'undefined' && d.m != ''){
                            engine.alert(d.m);
                        }

                    }
                });
            }
        })
    },
    uninstall: function(id)
    {
        engine.confirm
        (
            t.plugins.uninstall_question,
            function()
            {
                engine.request.post({
                    url: './plugins/uninstall',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('plugins');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    edit: function(id)
    {
        engine.request.post({
            url: './plugins/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.plugins.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#components').select2();

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('plugins');
                        dialog.dialog('close').dialog('destroy').remove();
                    }
                });
            }
        })
    }
};

engine.modules = {
    init: function()
    {
        // console.log('Init modules');

        $(document).on('click', '.b-module-install', function(){
            engine.modules.install($(this).data('id'));
        });

        $(document).on('click', '.b-module-uninstall', function(){
            engine.modules.uninstall($(this).data('id'));
        });
        $(document).on('click', '.b-module-edit', function(){
            engine.modules.edit($(this).data('id'));
        });
    },
    install: function(module)
    {
        engine.request.post({
            url: './modules/install',
            data: {c: module},
            success: function(d)
            {
                if(d.s){
                    engine.refreshDataTable('modules');
                    dialog.dialog('close').dialog('destroy').remove();
                    if(typeof d.m != 'undefined' && d.m != ''){
                        engine.alert(d.m);
                    }

                }
            }
        })
    },
    uninstall: function(id)
    {
        engine.confirm
        (
            t.modules.uninstall_question,
            function()
            {
                engine.request.post({
                    url: './modules/uninstall',
                    data: {id: id},
                    success: function(d)
                    {
                        if(d > 0){
                            engine.refreshDataTable('modules');
                        }
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    edit: function(id)
    {
        engine.request.post({
            url: './modules/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.modules.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                $('#components').select2();

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('modules');
                        dialog.dialog('close').dialog('destroy').remove();
                    }
                });
            }
        })
    }
};
/**
 * Created by wg on 08.02.16.
 */
engine.themes = {
    init: function()
    {
        // console.log('engine.themes.init() -> OK');
        $(document).on('click', '.b-themes-activate', function(){
            var theme = $(this).data('theme');
            engine.themes.activate(theme);
        });
    },
    activate: function(theme)
    {
        var dw = engine.confirm
        (
            t.themes.activate_confirm,
            function()
            {
                engine.request.get('./themes/activate/' + theme, function(d){
                    if(d > 0){
                        dw.dialog('close').dialog('destroy').remove();
                        location.reload(true);
                    }
                }, 'html');
            }
        );
    }
};
engine.translations = {
    init: function()
    {
        // console.log('Init translations');
        $(document).on('click', '.b-translations-create', function(){
            engine.translations.create();
        });
        $(document).on('click', '.b-translations-edit', function(){
            engine.translations.edit($(this).data('id'));
        });
        $(document).on('click', '.b-translations-delete', function(){
            engine.translations.delete($(this).data('id'));
        });
    },
    create: function()
    {
        engine.request.get('./translations/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                $('#form').submit();
            };

            var dialog = engine.dialog({
                content: d,
                title: t.translations.create_title,
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: buttons
            });

            engine.validateAjaxForm('#form', function(d){
                if(d.s){
                    engine.refreshDataTable('translations');
                    dialog.dialog('close');
                    dialog.dialog('destroy').remove()
                } else {
                    engine.showFormErrors('#form', d.i);
                }
            });
        });
    },
    edit: function(id)
    {
        engine.request.post({
            url: './translations/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};
                buttons[bi] =  function(){
                    $('#form').submit();
                };
                var dialog = engine.dialog({
                    content: d,
                    title: t.translations.edit_title,
                    autoOpen: true,
                    width: 750,
                    modal: true,
                    buttons: buttons
                });

                engine.validateAjaxForm('#form', function(d){
                    if(d.s){
                        engine.refreshDataTable('translations');
                        dialog.dialog('close');
                        dialog.dialog('destroy').remove()
                    }
                });
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.translations.delete_question,
            function()
            {
                engine.request.get('./translations/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('translations');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};
/**
 * Created by wg on 29.02.16.
 */
engine.trash = {
    init: function()
    {
        $(document).on('click', '.b-trash-remove', function(){
            var id = $(this).data('id');
            engine.confirm(t.trash.remove_question, function(){engine.trash.remove(id);});
        });

        $(document).on('click', '.b-trash-restore', function(){
            var id = $(this).data('id');
            engine.confirm(t.trash.restore_question, function(){engine.trash.restore(id);});
        });
    },
    remove: function (id) {
        engine.request.get('trash/remove/' + id, function (d) {
            engine.refreshDataTable('content');
            engine.closeDialog();
        });
    },
    restore: function (id) {
        engine.request.get('trash/restore/' + id, function (d) {
            engine.refreshDataTable('content');
            engine.closeDialog();
        });
    }
};
engine.settings = {
    init: function()
    {
        $('#tabs_settings').tabs().addClass( "ui-tabs-vertical" );
        //$( "#tabs_settings li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
    }
};

engine.mailTemplates = {
    init: function()
    {
        $(document).on('click', '.b-mailTemplates-create', function(){
            engine.mailTemplates.create();
        });
        $(document).on('click', '.b-mailTemplates-edit', function(){
            engine.mailTemplates.edit($(this).data('id'));
        });
        $(document).on('click', '.b-mailTemplates-delete', function(){
            engine.mailTemplates.delete($(this).data('id'));
        });
    },
    before: function()
    {
        engine.validateAjaxForm('#form', function(d){
            if(d.s){
                engine.refreshDataTable('mailTemplates');
                engine.closeDialog();
            } else {
                engine.showFormErrors('#form', d.i);
            }
        });

        $('#switchLanguages').find('button').click(function(){
            $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
            var code = $(this).data('code');
            $('.switch-lang:not(.lang-'+code+')').hide();
            $('.switch-lang.lang-' + code).show();
        });

        $('#form .ckeditor').each(function(){
            var name = $(this).attr('name');
            //// console.log(name);
            CKEDITOR.replace(name);
        });


    },
    create: function()
    {
        var $this = this;
        engine.request.get('./mailTemplates/create', function(d)
        {
            var bi = t.common.button_save;
            var buttons = {};

            buttons[bi] =  function(){
                engine.ckUpdate();
                setTimeout(function(){
                    $('#form').submit();
                },300);
            };

            var dialog = engine.dialog({
                content: d,
                title: t.mailTemplates.create_title,
                autoOpen: true,
                width: 900,
                modal: true,
                closeOnEscape: false,
                buttons: buttons
            });

            $this.before();
        });
    },
    edit: function(id)
    {
        var $this = this;
        engine.request.post({
            url: './mailTemplates/edit/' + id,
            data: {id: id},
            success: function(d)
            {
                var bi = t.common.button_save;
                var buttons = {};

                buttons[bi] =  function(){
                    engine.ckUpdate();
                    setTimeout(function(){
                        $('#form').submit();
                    },300);
                };

                var dialog = engine.dialog({
                    content: d,
                    title: t.mailTemplates.edit_title,
                    autoOpen: true,
                    width: 900,
                    closeOnEscape: false,
                    modal: true,
                    buttons: buttons
                });

                $this.before();
            }
        })
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.mailTemplates.delete_question,
            function()
            {
                engine.request.get('./mailTemplates/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('mailTemplates');
                    }
                });
                engine.closeDialog();
            }
        );
    }
};

$(document).ready(function(){
    engine.admins.init();
    engine.components.init();
    engine.chunks.init();
    engine.content.init();
    engine.contentImages.init();
    engine.contentImagesSizes.init();
    engine.contentTypes.init();
    engine.features.init();
    engine.guides.init();
    engine.languages.init();
    engine.nav.init();
    engine.plugins.init();
    engine.modules.init();
    engine.themes.init();
    engine.translations.init();
    engine.mailTemplates.init();
    engine.trash.init();
    engine.settings.init();
});

function responsive_filemanager_callback(field_id){
    var inp = $('#' + field_id);
    var v = inp.val();
    v = v.replace('https://', '');
    v = v.replace('http://', '');
    v = v.replace(location.hostname, '');
    inp.val(v);
    engine.closeDialog();
}
