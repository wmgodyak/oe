engine.components = {
    init: function()
    {
        //engine.require('installer');

        console.log('Init components');

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
                $(this).dialog('close').dialog('destroy').remove();
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
                $(this).dialog('close').dialog('destroy').remove();
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
                        dialog.dialog('close').dialog('destroy').remove();
                    }
                });
            }
        })
    },
};

$(document).ready(function(){
   engine.components.init();
});