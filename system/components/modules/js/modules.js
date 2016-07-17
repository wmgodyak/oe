var $modulesTabs = $( "#modules_tabs" );
engine.modules = {
    init: function()
    {
        $modulesTabs.tabs({
            beforeLoad: function( event, ui ) {
                ui.jqXHR.fail(function() {
                    ui.panel.html(
                        "Couldn't load this tab. We'll try to fix this as soon as possible. ");
                });
            }
        });

        $(document).on('click', '.b-modules-install', function(){
            var id=$(this).data('id');
            engine.modules.install(id);
        });
        $(document).on('click', '.b-modules-uninstall', function(){
            var id=$(this).data('id');
            engine.modules.uninstall(id);
        });
        $(document).on('click', '.b-modules-enable', function(){
            var id=$(this).data('id');
            engine.modules.enable(id);
        });
        $(document).on('click', '.b-modules-disable', function(){
            var id=$(this).data('id');
            engine.modules.disable(id);
        });
        $(document).on('click', '.b-modules-edit', function(){
            engine.modules.edit($(this).data('id'));
        });
        $(document).on('click', '.b-modules-delete', function(){
            engine.modules.delete($(this).data('id'));
        });
    },
    reload: function(){
        var i = $modulesTabs.tabs("option","selected");
        $modulesTabs.tabs('load',i);
    },
    install: function(module)
    {
        engine.request.post({
            url: 'modules/install',
            data: {
                module: module
            },
            success: function(res)
            {
                if(res.s){
                    engine.modules.reload();
                }
            }
        });
    },
    uninstall: function(module)
    {
        engine.request.post({
            url: 'modules/uninstall',
            data: {
                module: module
            },
            success: function(res)
            {
                if(res.s){
                    engine.modules.reload();
                }
            }
        });
    },
    enable: function(module)
    {
        engine.request.post({
            url: 'modules/enable',
            data: {
                module: module
            },
            success: function(res)
            {
                if(res.s){
                    engine.modules.reload();
                }
            }
        });
    },
    disable: function(module)
    {
        engine.request.post({
            url: 'modules/disable',
            data: {
                module: module
            },
            success: function(res)
            {
                if(res.s){
                    engine.modules.reload();
                }
            }
        });
    },
    edit: function(module)
    {
        engine.request.post({
            url: 'modules/edit',
            data: {
                module: module
            },
            success: function(res)
            {
                if(res.s){
                    engine.modules.reload();
                }
            }
        });
    }
};

$(document).ready(function(){
    engine.modules.init();
});