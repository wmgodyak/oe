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

        $(document).on('click', '.shop-display-mode', function(){
            var mode = $(this).data('mode');
            App.request.post({
               url: 'route/shop/setDisplayMode',
                data: {
                    mode: mode
                },
                success: function()
                {
                    location.reload(true);
                }
            });
        });

        $(document).on('submit', '#searchForm', function(){
            //alert(ls.val());
            App.request.get('route/shop/saveSearchQuery/' + ls.val())
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
                        var tpl = '<div class="ac-item"><div class="c"><div class="cc"><div class="t"><a href="">'+item.name+'</a></div><div class="p">'+item.price+' '+item.symbol+'</div></div></div><div class="sb-sl"><img src="'+item.img.path+'thumbs/'+item.img.image+'"></div></div>';
                        return { value: tpl, data: item };
                    })
                };
            },
            minChars:2,
            dataType: 'json'
        });

        $(document).on('click', '.to-comparison', function(e){

            var $this = $(this);

            if($this.hasClass('in')) {
                return true;
            }

            var id = $this.data('id'), cat_id = $this.data('cat');
            if(cat_id == '') {
                alert('Empty categories id');
                return false;
            }
            App.request.post({
                url: 'route/shop/comparison/add',
                data: {
                    categories_id : cat_id,
                    products_id   : id
                },
                success: function(res){
                    if(res){
                        $.notify('Товар додано в порівняння', 'success');
                        $this.addClass('in');
                        $this.text($this.data('in'));
                    }
                }
            });

            e.preventDefault();
        });

        $(document).on('click', '.b-comparison-del', function(e){
            var id = $(this).data('id');
            App.request.post({
                url: 'route/shop/comparison/delete',
                data: {
                    id: id
                },
                success: function(res){
                    location.reload(true);
                }
            });
        });

        $(document).on('change', '.sf-chb', function(){
            var id= $(this).attr('id');
            id = id.replace('f_', '');

            var url = $('a#fa-' + id).attr('href');
            if(typeof url == 'undefined') return false;
            //console.log('change', id, url);
            self.location.href=url;
        });
    },
    viewed: function(id)
    {
        var v = [];
        var a = $.cookie('viewed');
        if(typeof a != 'undefined') {
            v = a.split(',')
        }

        if(jQuery.inArray(id, v) == -1){
            v.push(id);
        }

        $.cookie('viewed', v.join());
    }
};

$(document).ready(function(){
   Shop.init();
});