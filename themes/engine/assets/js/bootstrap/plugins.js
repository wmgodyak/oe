engine.plugins = {
    init: function()
    {
        //engine.require('installer');

        console.log('Init plugins');

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

$(document).ready(function(){
   engine.plugins.init();
});