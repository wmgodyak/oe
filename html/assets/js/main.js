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
        //this.formValid();
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
            console.log('first');
        } else if ( $(window).width() >= 750 ) {
            optionsGoodsSliderMult5 = createOptions(3, false, true, false, false);
            console.log('second');
        } else {
            optionsGoodsSliderMult5 = createOptions(1, false, true, false, false);
            console.log('thirth');
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
        if ( $(window).width() > 1170 ) {
            $('.goods-nav__item').hover(function () {
                $(this).children('.sub-menu').toggleClass('active')
            })
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
    /*formValid: function () {
        $('.form').validate({
            rules: {
                name: "required",
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true
                }
            },
            messages: {
                name: "Будь-ласка введіть своє ім'я",
                email: {
                    required: "Поле e-mail є обов’язковим",
                    email: "Your email address must be in the format of name@domain.com"
                },
                password: {
                    required: "Поле Пароль є обов’язковим"
                }
            }
        });
    }*/
};

$(document).ready(function() {
    App.init();
});