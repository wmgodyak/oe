var App = {
    init: function () {
        this.formStyle();
        this.showPhone();
        this.slider();
        this.starRating();
        this.like();
        this.filterToggle();
        this.productTabs();
        this.cartItemCounter();
        this.cartDelateItem();
        this.mask();
        this.sidebar();
        this.formValid();
        this.menu();
    },
    formStyle: function () {
        var $searchSelect = $('.search-form select, .jq-select');

        if( $searchSelect.length ) {
            $searchSelect.styler();
        }
    },
    showPhone: function () {
        $('.show-phone').on('click', function (e) {
            e.preventDefault();

            $(this).siblings('.hidden').show();

            $(this).hide();
        });
    },
    slider: function () {
        var $bannerSlider = $('.m_banner-slider');
        var $goodsSliderMult5 = $('.goods-multiple-slider--5');
        var $goodsSliderMult4 = $('.goods-multiple-slider--4');
        var $productSLider1 = $('.product-slider1');
        var $productSLider2 = $('.product-slider2');

        var createOptions = function (items, loop, nav, dots, autoplay) {
            return {
                items: items,
                loop: loop,
                nav: nav,
                dots: dots,
                autoplay: autoplay,
                navText: ["",""]
            }
        };

        var optionsBannerSlider = createOptions(1, false, true, true, true);

        if ($bannerSlider.length) {
            $bannerSlider.owlCarousel(optionsBannerSlider);
        }

        var optionsGoodsSliderMult5 = null;

        if ( $(window).width() > 1170 ) {
            optionsGoodsSliderMult5 = createOptions(5, false, true, false, false);
        } else if ( $(window).width() >= 750 ) {
            optionsGoodsSliderMult5 = createOptions(3, false, true, false, false);
        } else {
            optionsGoodsSliderMult5 = createOptions(1, false, true, false, false);
        }

        if ($goodsSliderMult5.length) {
            $goodsSliderMult5.owlCarousel(optionsGoodsSliderMult5);
        }

        var optionsGoodsSliderMult4 = null;

        if ( $(window).width() > 1170 ) {
            optionsGoodsSliderMult4 = createOptions(4, false, true, false, false);
        } else if ( $(window).width() >= 750 ) {
            optionsGoodsSliderMult4 = createOptions(3, false, true, false, false);
        } else {
            optionsGoodsSliderMult4 = createOptions(1, false, true, false, false);
        }

        if ($goodsSliderMult4.length) {
            $goodsSliderMult4.owlCarousel(optionsGoodsSliderMult4);
        }

        //sync Slider

        var optionsSynchSlider1 = {
            items: 1,
            slideSpeed : 1000,
            nav: false,
            pagination: false,
            responsiveRefreshRate : 200
        };

        if ( $(window).width() > 750 ) {
            var optionsSynchSlider2 = {
                items : 3,
                pagination: false,
                nav: true,
                margin: 13,
                navText: ["", ""]
            };
        } else {
            var optionsSynchSlider2 = {
                items : 2,
                pagination: false,
                nav: true,
                margin: 5,
                navText: ["", ""]
            };
        }



        if ( $productSLider1.length ) {
            var sliderSynch = $productSLider1.owlCarousel( optionsSynchSlider1 );
        }

        if ( $productSLider2.length ) {
            $productSLider2.owlCarousel( optionsSynchSlider2 ).on('click', '.owl-item', function (e) {
                var $this = $(this);
                var index = $this.index();

                sliderSynch.trigger('to.owl.carousel', index);

                e.preventDefault();
            });
        }
    },
    starRating: function () {
        var $rating = $('.star-rating');

        if ($rating.length) {

            if ($rating.hasClass('read-only')) {
                ratingInit ($rating, true);
            } else {
                ratingInit ($rating, false);
            }

        }

        function ratingInit ($rating, readonly) {
            $rating.barrating({
                theme: 'css-stars',
                readonly: readonly
            });
        }
    },
    like: function () {
        $('.hearth-like__link').on('click', function (e) {
            e.preventDefault();
            $(this).toggleClass('hearth-like__link--liked');
        });
    },
    filterToggle: function () {
        var $link = $('.toggle-link');

        $link.on('click', function (e) {
            var $this = $(this);
            var $content = $this.siblings('.filter-group__content');

            $this.toggleClass('toggle-link--active');
            $content.slideToggle(350);

            e.preventDefault();
        });
    },
    productTabs: function () {
        var $container = $('.item-info-tabs');
        var $navItemLink = $container.find('.info-tabs__top ul li a');
        var $tabsList = $container.find('.info-tabs__main .tab');

        $navItemLink.on('click', function (e) {
            var $parentLi = $(this).parents('li');
            var activeIndex = $parentLi.index();

            $parentLi.siblings().removeClass('active');
            $parentLi.addClass('active');
            $tabsList.removeClass('active');
            $tabsList.eq(activeIndex).addClass('active');
            e.preventDefault();
        });
    },
    cartItemCounter: function () {
        var $addition = $('.item-counter .plus');
        var $subtraction = $('.item-counter .minus');

        $addition.on('click', function (e) {
            var $input = $(this).parents('form').find('input');
            $input.val(+$input.val() + 1);

            e.preventDefault();
        });

        $subtraction.on('click', function (e) {
            var $input = $(this).parents('form').find('input');

            if ( $input.val() > 1 ) {
                $input.val(+$input.val() - 1);
            }

            e.preventDefault();
        });
    },
    cartDelateItem: function () {
        var $closeBtn = $('.goods-list .delate-item');

        $closeBtn.on('click', function (e) {
            $(this).parents('.goods-list__row').remove();

            e.preventDefault();
        });
    },
    mask: function () {
        $counter = $('.counter-mask');

        if( $counter.length )
        {
            $counter.mask( '9?99', { placeholder: '' } );
        }
    },
    sidebar: function () {
        var $switcherLink = $('.side-menu-switcher a');
        var $sideBar = $('.sidebar-collapse');

        $switcherLink.on('click', function (e) {

            $(this).toggleClass('active');
            $sideBar.slideToggle(400);

            e.preventDefault();
        });
    },
    menu: function (){
        if($('.m_goods-nav').length == 0) return;
        if ( $(window).width() > 1170 ) {
            $('.goods-nav__item').hover(function () {
                $(this).children('.sub-menu').toggleClass('active')
            });
            var grid = document.getElementsByClassName('my-grid');
            for (var i = 0; i <= grid.length; i++){
                waterfall(grid[i]);
            }
        }else {
            $('.goods-nav__link').on('click', function () {
                if(false == $(this).siblings().is(':visible')) {
                    $('.sub-menu').slideUp(300);
                }
                $(this).next().slideToggle(300);
            });
        }
    },
    formValid: function () {
        $('.form').validate({
            rules: {
                name: "required",
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                name: "Будь-ласка введіть своє ім'я",
                email: {
                    required: "Будь-ласка введіть свою електронну пошту",
                    email: "Your email address must be in the format of name@domain.com"
                }
            }
        });
    },


    /**
     * validate form and send request via ajax
     * @param myForm
     * @param onSuccess
     * @param onBeforeSend
     * @param ajaxParams
     * @param rules
     */
    validateAjaxForm: function(myForm, onSuccess, onBeforeSend, ajaxParams, rules){

        rules = typeof rules == 'undefined' ? [] : rules;

        function showError(form, inp)
        {
            var $validator = $(form).validate(), e = [];
            $(inp).each(function(k, i){
                $validator.showErrors(i);
            });
        }

        $(myForm).validate({
            errorElement: 'span',
            rules: rules,
            debug: true,
            submitHandler: function(form) {
                var bSubmit = $('.b-submit, .b-form-save');
                var settings = {
                    dataType: 'json',
                    beforeSend: function(request)
                    {
                        //request.setRequestHeader("app-languages-id", LANG_ID);

                        bSubmit.attr('disabled', true);

                        if(typeof onBeforeSend == 'string'){
                            try {
                                onBeforeSend += '()';
                                var fn = new Function('', onBeforeSend);
                                return fn();
                            } catch (err) {
                                console.info(onBeforeSend + ' is undefined.');
                            }
                        } else if(typeof onBeforeSend != 'undefined'){
                            return onBeforeSend();
                        }
                        return true;
                    },
                    success: function(d)
                    {
                        bSubmit.removeAttr('disabled');
                        if(! d.s ){
                            showError(form, d.i)
                        } else {

                            if(typeof d.m != 'undefined'){
                                d.e = typeof d.e == 'undefined' ? null : d.e;
                                //engine.notify(d.m, d.t, 'success');
                                alert(d.m);
                            }

                            if(typeof onSuccess == 'string'){
                                try {
                                    onSuccess += '(d)';
                                    var fn = new Function('d', onSuccess);
                                    fn(d);
                                } catch (err) {
                                    console.info(onSuccess + ' is undefined.');
                                }
                            } else if(typeof onSuccess != 'undefined'){
                                onSuccess(d);
                            }
                        }
                    },
                    error: function(d)
                    {
                        alert(d.responseText);
                    }
                };

                if(typeof ajaxParams != 'undefined'){
                    settings = $.extend(settings, ajaxParams);
                }

                $(form).ajaxSubmit(settings);
            }
        });
    },

    request:  {
        /**
         * send get request
         * @param url
         * @param success
         * @param dataType
         * @returns {*}
         */
        get: function(url, success, dataType)
        {
            //var data =  {token: TOKEN};
            return $.ajax({
                url      : url,
                //data     : data,
                success  : success,
                dataType : dataType,
                type     : 'get',
                beforeSend: function(request)
                {
                    //request.setRequestHeader("app-languages-id", LANG_ID);
                }
            })
        },
        post: function(data)
        {
            if(typeof data['data'] == 'undefined') {
                data['data'] = {};
            }
            data['data']['token'] = TOKEN;
            data['type']       = 'post';
            data['beforeSend'] = function(request)
            {
                //request.setRequestHeader("app-languages-id", LANG_ID);
            };
            return $.ajax(data)
        }
    },
    dialog: function(args)
    {
        return $('<div></div>')
            .attr('id', 'modal' + Date.now())
            .html(args.content)
            .appendTo('body')
            .dialog(args)
            ;
    },
    confirm: function(msg, success)
    {
        return App.dialog({
            content: msg,
            title: 'Увага',
            autoOpen: true,
            width: 500,
            modal: true,
            buttons:  [
                {
                    text    : "Так",
                    "class" : 'btn-success',
                    click   : success
                }
            ],
            close: function() {
                console.log('dialog close ok.');
            }
        });
    },
    alert: function(msg)
    {
        return App.dialog({
            content: msg,
            title: 'Інфомація',
            autoOpen: true,
            width: 500,
            modal: true,
            buttons: {
                "Ok": function(){$(this).dialog('close');}
            }
        });
    }
};

$(document).ready(function() {
    App.init();
});