/**
 * Created by wg on 08.02.16.
 */
engine.themes = {
    init: function()
    {
        console.log('engine.themes.init() -> OK');
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

$(document).ready(function(){
   engine.themes.init();
});