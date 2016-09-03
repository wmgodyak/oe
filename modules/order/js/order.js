var Order = {
    init: function(){
        var $blockCart = $('#blockCart');
        var tmplCart = _.template($('#tplCart').html());

        function refreshBlock()
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/total',
                    success: function(res){
                        $blockCart.html(tmplCart({
                            total: res.total,
                            amount: res.amount
                        }));
                    },
                    dataType: 'json'
                }
            );
        }

        refreshBlock();

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
                t_in = $this.data('in')
                //t_bye = $this.data('bye')
                ;

            if($this.hasClass('m_cart-indicator__in')) {
                self.location.href=$('.cart__link:first').attr('href');
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

            Order.cart.products.add(products_id, variants_id, 1, function(res){
                $this.addClass('m_cart-indicator__in');
                if(! $this.hasClass('m_cart-indicator')){
                    $this.text(t_in);
                }
                //App.alert('Товар додано в кошик');
                $.notify('Товар додано в кошик', 'success');
                refreshBlock(res);
            });
        });

        function cartForm(products, kits)
        {
            if(typeof products != 'undefined' && products != null){

                products = $.map(products, function(value, index) {
                    return [value];
                });

            }

            if(typeof kits != 'undefined' && kits != null){

                kits = $.map(kits, function(value, index) {
                    return [value];
                });

            }
            var $cartItems = $("#cartItems");
            $cartItems.html( _.template($('#cartTemplate').html())({
                items: products,
                kits: kits,
                bonus_rate: window.bonus_rate
            }));

            $(document).on('click', '.cart-delete-item', function(){
                var id = $(this).data('id');
                Order.cart.products.delete(id, function(res){
                    refreshBlock(res.total);
                    cartForm(res.products, res.kits);
                });
            });
            $(document).on('click', '.b-cart-kits-delete', function(){
                var id = $(this).data('id');
                Order.cart.kits.delete(id, function(res){
                    refreshBlock(res.total);
                    cartForm(res.products, res.kits);
                });
            });

        }

        cartForm(window.cItems, window.cKits);

        $(document).on('change', '.cart-item-quantity', function(){
            var id = $(this).data('id'), quantity = this.value;

            Order.cart.products.update(id, quantity, function(res){
                refreshBlock();
                cartForm(res.products, res.kits);
            });
        });

        $('#user_phone').mask('+38(999)99-99-999');

        function onDeliveryChange()
        {
            var region_id = $("#delivery_region_id").find('option:selected').val(),
                city_id   = $("#delivery_city_id").find('option:selected').val();

            // clear previos select
            //console.log('remove prev meta');

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

            if($this.hasClass('m_cart-indicator__in')) {
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

        $(document).on('click', '.to-cart-kit', function(e){
            e.preventDefault();

            var $this = $(this), kits_id = $this.data('id'),
                t_in = $this.data('in')
                ;

            if($this.hasClass('m_cart-indicator__in')) {
                self.location.href=$('.cart__link:first').attr('href');
                return;
            }

            Order.cart.kits.add(kits_id, function(res){
                $this.addClass('m_cart-indicator__in').text(t_in);
                App.alert('Комплект додано в кошик');
                refreshBlock();
            });
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
        total: function(onSuccess)
        {
            App.request.post(
                {
                    url: 'route/order/ajaxCart/total',
                    success: onSuccess,
                    dataType: 'json'
                }
            );
        },
        products: {
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
                        url: 'route/order/ajaxCart/add/products',
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
                        url: 'route/order/ajaxCart/update/products',
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
                        url: 'route/order/ajaxCart/delete/products',
                        data:{
                            id : id
                        },
                        success: onSuccess,
                        dataType: 'json'
                    }
                );
            }
        },
        kits : {
            /**
             * @param kits_id
             * @param onSuccess
             */
            add: function(kits_id, onSuccess)
            {
                App.request.post(
                    {
                        url: 'route/order/ajaxCart/add/kits',
                        data:{
                            kits_id : kits_id
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
                        url: 'route/order/ajaxCart/update/kits',
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
                        url: 'route/order/ajaxCart/delete/kits',
                        data:{
                            id : id
                        },
                        success: onSuccess,
                        dataType: 'json'
                    }
                );
            }
        }
    }
};

$(document).ready(function(){
   Order.init();
});