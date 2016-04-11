var App = {
    init: function()
    {
        //this.require('plugins');

        console.log("App.init()");
    },
    require: function(src, path)
    {
        path = typeof path == 'undefined' ? '/themes/default/assets/js/' : path;
        var sc = document.createElement('script');
        sc.type = 'text/javascript';
        //sc.async = true;
        sc.src = path + src + '.js';
        var s = document.getElementById('appScr');
        s.parentNode.insertBefore(sc, s);
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
                alert('Post data is undefined');
            }
            data['data']['token'] = TOKEN;
            data['type']       = 'post';
            data['beforeSend'] = function(request)
            {
                //request.setRequestHeader("app-languages-id", LANG_ID);
            };
            return $.ajax(data)
        }
    }
};

App.account = {
    init: function(){
        App.validateAjaxForm('#accountLogin', function () {
            self.location.href = $('#accountLogin').data('href');
        });
        App.validateAjaxForm('#accountRegister', function () {
            self.location.href = $('#accountRegister').data('href');
        });
        App.validateAjaxForm('#accountProfile', function () {
            App.alert('Дані оновлено.', 'success', $("#accountProfile .response"));
        });
        App.validateAjaxForm('#accountUpdatePassword', function () {
            App.alert('Дані оновлено.', 'success', $("#accountUpdatePassword .response"));
        });
        App.validateAjaxForm('#accountFp', function (d) {
            App.alert(d.m, 'success', $("#accountFp .response"));
            setTimeout(function(){
                self.location.href="/";
            }, 3000);
        });
        App.validateAjaxForm('#accountNewPsw', function (d) {
            App.alert(d.m, 'success', $("#accountNewPsw .response"));
            setTimeout(function(){
                self.location.href = $('#accountNewPsw').data('href');
            }, 3000);
        });
    },
    login: function(){},
    register: function(){}
};

App.alert = function(msg, status, target)
{
    var tmpl = _.template('<div class="alert alert-<%- status %>"><%- msg %></div>');
    var data = {
        msg: msg,
        status: status
    };
    var d = tmpl(data);

    target = typeof target == 'undefined' ? $('.response') : target;

    target.html(d);
};


App.comments = {
    init: function()
    {
        App.validateAjaxForm('#commentsCreate', function (d) {
            App.alert(d.m, 'success');
        });

        $(document).on('click', '.comment-reply', function(){
            var id = $(this).data('parent');
            $("#commentsParentId").val(id);

            $('html, body').animate({
                scrollTop: $("#commentsCreate").offset().top
            }, 1000);
        });

        $(document).on('click', '.b-comments-subscribe', function(e){

            e.preventDefault();

            var id= $(this).data('id'), $this = $(this), t = $this.data('us');
            if(typeof id == 'undefined') {
                return false;
            }

            App.request.get('ajax/Comments/subscribe/' + id, function(d){
                if(d>0){
                    $this.text(t).removeClass('b-comments-subscribe').addClass('b-comments-un-subscribe');
                }
            });
        });

        $(document).on('click', '.b-comments-un-subscribe', function(e){

            e.preventDefault();

            var id= $(this).data('id'), $this = $(this), t = $this.data('s');
            if(typeof id == 'undefined') return false;

            App.request.get('route/Comments/unSubscribe/' + id, function(d){
                if(d > 0){
                    $this.text(t).removeClass('b-comments-un-subscribe').addClass('b-comments-subscribe');
                }
            });
        });
    }
};

App.feedback = function(){
    $('#data_phone').mask('+38(099)999-99-99');
    App.validateAjaxForm('#feedback', function (d) {
        App.alert(d.m);
        setTimeout(function(){
            //location.reload(true);
        }, 3000);
        $('#feedback').resetForm();
        $('#bSubmit').button('complete');
    },function(){
        $('#bSubmit').button('loading');
    });
};
App.callback = function(){
    $('#data_c_phone').mask('+38(099)999-99-99');
    App.validateAjaxForm('#callback', function (d) {
        App.alert(d.m);
        setTimeout(function(){
            //location.reload(true);
        }, 3000);
        $('#callback').resetForm();
        $('#bSubmit').button('complete');
    },function(){
        $('#bSubmit').button('loading');
    });
};
$(document).ready(function(){
    App.init();
    App.account.init();
    App.comments.init();
    App.feedback();
    App.callback();
});