var Shop = {
    init: function()
    {
        var searchForm = $('#searchForm'), searchFormAction = searchForm.attr('action');
        $(document).on('change', '#search_cat', function(){
            var cat = $(this).find('option:selected').data('href');
            var action = cat == '' ? searchFormAction : cat;
            searchForm.attr('action', action);
        });
    }
};

$(document).ready(function(){
   Shop.init();
});