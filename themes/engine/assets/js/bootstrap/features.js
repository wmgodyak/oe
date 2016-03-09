/**
 * Created by wg on 08.02.16.
 */
engine.features = {
    init: function()
    {
        console.log('engine.features.init() -> OK');
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
    }

};

$(document).ready(function(){
   engine.features.init();
});