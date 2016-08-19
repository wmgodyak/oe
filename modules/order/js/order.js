var Order = {
    init: function(){
        var $blockCart = $('#blockCart');
        var tmplCart = _.template($('#tplCart').html());

        function refreshBlock(res)
        {
            $blockCart.html(tmplCart({
                total: res.total,
                amount: res.amount
            }));
        }

        Order.cart.getTotal(function(res){
            refreshBlock(res);
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

            var $this = $(this), products_id = $this.data('id'), variants_id = 0,
                hasVariants = $this.data('has-variants'),
                t_in = $this.data('in'),
                t_bye = $this.data('bye')
                ;

            if($this.hasClass('in')) {
                self.location.href=$('.cart__link:first').attr('href');
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

            Order.cart.add(products_id, variants_id, 1, function(res){
                $this.addClass('in active').text(t_in);
                App.alert('Товар додано в кошик');
                refreshBlock(res);
            });
        });

        function cartForm(items)
        {
            items = $.map(items, function(value, index) {
                return [value];
            });

            //console.log(items);
            var $cartItems = $("#cartItems");
            $cartItems.html( _.template($('#cartTemplate').html())({items: items}));

            $(document).on('click', '.cart-delete-item', function(){
                var id = $(this).data('id');
                Order.cart.delete(id, function(res){
                    refreshBlock(res.total);
                    cartForm(res.items);
                });
            });

        }

        if(typeof cItems != 'undefined'){
            cartForm(cItems);
        }

        $(document).on('change', '.cart-item-quantity', function(){
            var id = $(this).data('id'), quantity = this.value;

            Order.cart.update(id,quantity, function(res){
                refreshBlock(res.total);
                cartForm(res.items);
            });
        });

        /**
         * Order
         */

        var deliveryTpl = _.template('<tr>\
        <td><label for="">Область</label></td>\
        <td>\
        <div class="select">\
        </div>\
        </td>\
        </tr>');

        $('#user_phone').mask('+38(999)99-99-999');
        $("#order_delivery_id").change(function(){
            var id = $(this).find('option:selected').val();



            // trigger to extended options
            // область
            App.request.post({
                url: 'route/delivery/onSelect',
                data: {delivery_id: id},
                success: function(d)
                {

                }
            });
            // payment
            App.request.post({
                url: 'route/delivery/getPayment',
                data: {delivery_id: id},
                success: function(d)
                {
                    var out = '';
                    $(d.payment).each(function(i,e){
                        out += '<option value="'+ e.id +'">'+ e.name +'</option>'
                    });
                    $('#order_payment_id').html(out);
                }
            });
        }).trigger('change');

        App.validateAjaxForm('#checkout', function (res) {
            if(res.s){
                var u = typeof res.redirect == 'undefined' ? '/' : res.redirect;
                self.location.href = u;
            }
        });

        $(document).on('click', '.buy-one-click', function(){
            var $this = $(this), products_id = $this.data('id'),  formID = 'ocf_' + products_id, variants_id = 0,
                hasVariants = $this.data('has-variants');

            if($this.hasClass('in')) {
                self.location.href=$('.cart__link:first').attr('href');
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

            var tpl = _.template
            (
                $('#oneClickTpl').html())({
                    products_id: products_id,
                    variants_id:variants_id,
                    formID:formID,
                    token : TOKEN
                }
            );

            var ocd = App.dialog({
                title: 'Замовлення в один клік',
                content: tpl,
                buttons: {
                    'Замовити' : function(){
                        $("#oneClick"+formID).submit();
                    }
                }
            });

            App.validateAjaxForm('#oneClick' + formID, function (res) {
                if(res.s){
                   ocd.dialog('close');
                    App.dialog({
                        title: 'Інформація',
                        content: '<p>Вітаємо. Ваше замовлення прийнято. Очікуйте дзвінка менеджера</p>',
                        buttons: {
                            'Ок' : function(){
                                var url = typeof res.redirect == 'undefined' ? '/' : res.redirect;
                                self.location.href = url;
                            }
                        }
                    });
                }
            });

            $('.phone-mask').mask('+38(999)99-99-999');
        });
    },
    oneClick: function(products_id, variants_id, phone, name, onSuccess)
    {
        App.request.post(
            {
                url  : 'route/order/oneClick',
                data : {
                    products_id : products_id,
                    variants_id : variants_id,
                    phone       : phone,
                    name        : name
                },
                success  : onSuccess,
                dataType : 'json'
            }
        );
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
                    success: onSuccess,
                    dataType: 'json'
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
                        quantity : qtt
                    },
                    success: onSuccess,
                    dataType: 'json'
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
                    success: onSuccess,
                    dataType: 'json'
                }
            );
        },
        getTotal: function(onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/total',
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