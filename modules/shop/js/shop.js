var Shop = {
    init: function()
    {
        var searchForm = $('#searchForm'), searchFormAction = searchForm.attr('action'), currentCat = 0;
        var ls = $('#shopLiveSearch');
        $(document).on('change', '#search_cat', function(){
            var cat = $(this).find('option:selected').data('href');
            currentCat = $(this).find('option:selected').val();
            var action = cat == '' ? searchFormAction : cat;

            searchForm.attr('action', action);
            var v = ls.val(); v+= ' ';
            ls.val(v);
            ls.focus();
        });

        ls.ajaxSearch({
            serviceUrl: 'route/shop/ajaxSearch',
            ajaxSettings: {
                beforeSend: function(xhr, settings)
                {
                    settings.url += '&cat='+currentCat;
                }
            },
            onSelect: function (item) {
                ls.val(item.data.name);
                //searchForm.submit();
                self.location.href=item.data.url;
            },
            paramName: 'q',
            transformResult: function(response) {
                return {
                    suggestions: $.map(response.items, function(item) {
                        var tpl = '<div class="ac-item"><div class="c"><div class="cc"><div class="t"><a href="">'+item.name+'</a></div><div class="p">'+item.price+'</div></div></div><div class="sb-sl"><img src="'+item.img.path+'thumbs/'+item.img.image+'"></div></div>';
                        return { value: tpl, data: item };
                    })
                };
            },
            minChars:2,
            dataType: 'json'
        });
    }
};

$(document).ready(function(){
   Shop.init();
});