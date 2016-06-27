engine.widgets = {
    init: function()
    {
        $(document).on('click','.b-widgets-area-settings', function(){
            var id = $(this).data('id');
            engine.widgets.area.settings(id);
        });
    },
    area: {
    }
};
$(document).ready(function(){
   engine.widgets.init();
});