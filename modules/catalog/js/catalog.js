$(document).ready(function(){
    $(document).on('click', '.shop-display-mode', function(){
        var mode = $(this).data('mode');
        App.request.post({
            url: 'catalog/setDisplayMode',
            data: {
                mode: mode
            },
            success: function()
            {
                location.reload(true);
            }
        });
    });
});