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

        $('#user_phone').mask('+38(999)99-99-999');

        function onDeliveryChange()
        {
            var region_id = $("#delivery_region_id").find('option:selected').val(),
                city_id   = $("#delivery_city_id").find('option:selected').val();

            // clear previos select
            console.log('remove prev meta');

            $('#delivery_region_id_row').remove();
            $('#delivery_city_id_row').remove();
            $('#delivery_department_id_row').remove();

            var delivery_id = $("#order_delivery_id").find('option:selected').val();

            var stpl = _.template(
                '<tr id="<%- id%>_row">\
                    <td><label for="<%- id%>"><%- label %></label></td>\
                    <td>\
                        <div class="select">\
                            <select name="<%-name%>" id="<%- id%>"><%=items%></select>\
                        </div>\
                    </td>\
                </tr>'
            );

            // trigger to extended options
            App.request.post({
                url: 'route/delivery/onSelect',
                data: {
                    delivery_id : delivery_id,
                    region_id   : region_id,
                    city_id     : city_id
                },
                dataType:'json',
                success: function(d)
                {
                    var out = '';

                    $(d.areas).each(function(c, e){
                        var opt = '<option>--виберіть--</option>';
                        $(e.items).each(function(k, item){
                            opt += '<option '+ (item.id == region_id ? 'selected' : '') +' value="'+ item.id +'">'+ item.name +'</option>';
                        });
                        out += stpl({name: e.name, id: e.id, label: e.label, items: opt});
                    });

                    $(d.city).each(function(c, e){
                        var opt = '<option>--виберіть--</option>';
                        $(e.items).each(function(k, item){
                            opt += '<option '+ (item.id == city_id ? 'selected' : '') +'  value="'+ item.id +'">'+ item.name +'</option>';
                        });
                        out += stpl({name: e.name, id: e.id, label: e.label, items: opt});
                    });

                    $(d.warehouses).each(function(c, e){
                        var opt = '<option>--виберіть--</option>';
                        $(e.items).each(function(k, item){
                            opt += '<option value="'+ item.id +'">'+ item.name +'</option>';
                        });
                        out += stpl({name: e.name, id: e.id, label: e.label, items: opt});
                    });

                    $(out).insertAfter('#deliveryRow');
                }
            });
        }

        $("#order_delivery_id").change(function(){

            onDeliveryChange();

            var delivery_id = $("#order_delivery_id").find('option:selected').val();
            // payment
            App.request.post({
                url: 'route/delivery/getPayment',
                data: {delivery_id: delivery_id},
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

        $(document).on('change', '#delivery_region_id', function(){onDeliveryChange();});
        $(document).on('change', '#delivery_city_id', function(){onDeliveryChange();});

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