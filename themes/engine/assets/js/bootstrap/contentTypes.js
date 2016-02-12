/**
 * Created by wg on 08.02.16.
 */
engine.contentTypes = {
    init: function()
    {
        console.log('engine.contentTypes.init() -> OK');
        $(document).on('click', '.b-contentTypes-delete', function(){
            var id = $(this).data('id');
            engine.contentTypes.delete(id);
        });

    },
    onCreateSuccess: function(d)
    {
        //location.href = "./contentTypes";
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
    }
};

$(document).ready(function(){
   engine.contentTypes.init();
});