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

$(document).ready(function(){
   engine.trash.init();
});
