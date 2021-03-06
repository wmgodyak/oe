var App = {
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
            debug: false,
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
                        if(typeof d.m != 'undefined'){
                            d.e = typeof d.e == 'undefined' ? null : d.e;
                            //engine.notify(d.m, d.t, 'success');
                            //alert(d.m);
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
                        //if(! d.s ){
                        //    showError(form, d.i)
                        //} else {
                        //
                        //    if(typeof d.m != 'undefined'){
                        //        d.e = typeof d.e == 'undefined' ? null : d.e;
                        //        //engine.notify(d.m, d.t, 'success');
                        //        //alert(d.m);
                        //    }
                        //
                        //    if(typeof onSuccess == 'string'){
                        //        try {
                        //            onSuccess += '(d)';
                        //            var fn = new Function('d', onSuccess);
                        //            fn(d);
                        //        } catch (err) {
                        //            console.info(onSuccess + ' is undefined.');
                        //        }
                        //    } else if(typeof onSuccess != 'undefined'){
                        //        onSuccess(d);
                        //    }
                        //}
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
            return $.ajax({
                url      : url,
                //data     : data,
                success  : success,
                dataType : dataType,
                type     : 'get',
                beforeSend: function(request)
                {
                    request.setRequestHeader("X-Accept-Language", $('html').data('lang') );
                    request.setRequestHeader("X-CSRF-Token", $('meta[name=csrf-token]').attr("content") );
                }
            })
        },
        post: function(data)
        {
            if(typeof data['data'] == 'undefined') {
                data['data'] = {};
            }
            data['data']['token'] = $('meta[name=csrf-token]').attr("content");
            data['type']       = 'post';
            data['beforeSend'] = function(request)
            {
                request.setRequestHeader("X-CSRF-Token", $('meta[name=csrf-token]').attr("content") );
                request.setRequestHeader("X-Accept-Language", $('html').data('lang') );
            };
            return $.ajax(data)
        }
    },
    dialog: function(args)
    {
        //if(typeof $.dialog == 'undefined'){
        //    alert('Include jQueryUI dialog');
        //    return;
        //}
        if(typeof args.close == 'undefined'){
            args.close = function( event, ui ) { $(this).dialog('destroy').remove(); };
        }
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
    alert: function(msg, success)
    {
        return App.dialog({
            content: msg,
            title: 'Information',
            autoOpen: true,
            width: 500,
            modal: true,
            buttons:  [
                {
                    text    : "Ok",
                    "class" : 'btn-success',
                    click   : success
                }
            ]
        });
    }
};

$.ajaxSetup({
    headers: {
        'X-Accept-Language' : $('html').data('lang'),
        'X-CSRF-Token'      : $('meta[name="csrf-token"]').attr('content')
    }
});