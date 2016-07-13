var Order = {
    init: function(){
        var $blockCart = $('#blockCart');
        var tmplCart = _.template($('#tplCart').html());

        Order.cart.getTotal(function(res){
            $blockCart.html(tmplCart({
                total: res.total,
                amount: res.amount
            }));
        });

        $(document).on('change', '.product-variant', function(){
             var product_id = $(this).data('id'),
                 opt = $(this).find('option:selected'),
                 variant_id = opt.data('id'),
                 price = opt.data('price');

            $("#p-price-"+product_id).text(price);

        });

        $('.product-variant').each(function(){
            $(this).trigger('change');
        });

        $(document).on('click', '.to-cart', function(e){
            e.preventDefault();

            var $this = $(this), products_id = $this.data('id'), variants_id = 0, hasVariants = $this.data('has-variants');

            if($this.hasClass('in')) {
                self.location.href=$('.cart__link:first').attr('href');
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

            Order.cart.add(products_id, variants_id, 1, function(res){
                if(res == 1) {
                    $this.addClass('in');
                    Order.cart.getTotal(function(res){
                        $blockCart.html(tmplCart({
                            total: res.total,
                            amount: res.amount
                        }));
                    });
                    // refresh block
                }
            });
        });
    },
    cart : {
        /**
         *
         * @param products_id
         * @param variants_id
         * @param quantity
         * @param onSuccess
         */
        add: function(products_id, variants_id, quantity, onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/add',
                    data:{
                        products_id : products_id,
                        variants_id : variants_id,
                        quantity    : quantity
                    },
                    success: onSuccess
                }
            );
        },
        update: function(id, qtt, onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/update',
                    data:{
                        id : id,
                        qtt : qtt
                    },
                    success: onSuccess
                }
            );
        },
        delete: function(id, onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/delete',
                    data:{
                        id : id
                    },
                    success: onSuccess
                }
            );
        },
        getTotal: function(onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/getTotal',
                    success: onSuccess,
                    dataType: 'json'
                }
            );
        }
    }
};

$(document).ready(function(){
   Order.init();
});