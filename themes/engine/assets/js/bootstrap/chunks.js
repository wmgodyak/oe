/**
 * Created by wg on 08.02.16.
 */
engine.chunks = {
    init: function()
    {
        console.log('engine.chunks.init() -> OK');
        $(document).on('click', '.b-chunks-delete', function(){
            var id = $(this).data('id');
            engine.chunks.delete(id);
        });

        this.initBuilder();
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

$(document).ready(function(){
   engine.chunks.init();
});