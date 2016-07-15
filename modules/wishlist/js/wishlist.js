var Wishlist = {
    init: function()
    {
        var wLink = $('#wishlistLink');

        $(document).on('click', '.wishlist-add', function(e){
            e.preventDefault();

            var $this = $(this), products_id = $this.data('id'), variants_id = 0,
                hasVariants = $this.data('has-variants');

            if($this.hasClass('hearth-like__link--liked')) {
                Wishlist.delete(products_id, variants_id, function(res){
                    $this.removeClass('hearth-like__link--liked');
                });
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

           Wishlist.add(products_id, variants_id, function(res){
               $this.addClass('hearth-like__link--liked');
               wLink.addClass('active');
           });
        });
    },
    add: function(products_id, variants_id, onSuccess)
    {
        App.request.post(
            {
                url  : 'route/wishlist/add',
                data : {
                    products_id : products_id,
                    variants_id : variants_id
                },
                success  : onSuccess,
                dataType : 'json'
            }
        );
    },
    delete: function(products_id, variants_id, onSuccess)
    {
        App.request.post(
            {
                url  : 'route/wishlist/delete',
                data : {
                    products_id : products_id,
                    variants_id : variants_id
                },
                success  : onSuccess,
                dataType : 'json'
            }
        );
    }
};

$(document).ready(function(){
   Wishlist.init();
});