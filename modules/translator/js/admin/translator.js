engine.translator = {
    init: function()
    {
        $(document).on('click', '.auto-translate-language', function(e)
        {
            engine.request.post({
               url: 'module/run/translator/index',
                data: {},
               success: function(d)
               {
                   var bi = 'Вперед';
                   var buttons = {};

                   buttons[bi] =  function(){
                       //$('#guidesForm').submit();
                   };

                   var dialog = engine.dialog({
                       content: d,
                       title: 'Автопереклад контенту',
                       autoOpen: true,
                       width: 750,
                       modal: true,
                       buttons: buttons
                   });
               }
            });
        });
    },
    translateContent: function(from)
    {
        var ab = $("#switchLanguages").find('.btn.btn-primary'), to = ab.data('code');

        if(from == to) return;



        var nf = $('.info-name.lang-' + from), nt = $('.info-name.lang-' + to);

        this.translate(nf.val(), from, to, function(res){nt.val(res).trigger('keyup'); });

        var ntf = $('.info-title.lang-' + from), ntt = $('.info-title.lang-' + to);
        if(ntf.val() != ''){
            this.translate(ntf.val(), from, to, function(res){ntt.val(res); });
        }

        var nhf = $('.info-h1.lang-' + from), nht = $('.info-h1.lang-' + to);
        if(nhf.val() != ''){
            this.translate(nhf.val(), from, to, function(res){nht.val(res); });
        }

        var nkf = $('.info-keywords.lang-' + from), nkt = $('.info-keywords.lang-' + to);
        if(nkf.val() != ''){
            this.translate(nkf.val(), from, to, function(res){nkt.val(res); });
        }

        var ndf = $('.info-description.lang-' + from), ndt = $('.info-description.lang-' + to);

        if(ndf.html() != ''){
            this.translate(ndf.html(), from, to, function(res){ndt.html(res); });
        }

        var nif = $('.info-intro.lang-' + from);

        if(nif.length && nif.html() != ''){
            this.translate(nif.html(), from, to, function(res){
                CKEDITOR.instances['content_intro_'+ to +'_content'].insertHtml( res );
            });
        }

        var ncf = $('.info-content.lang-' + from);
        if(ncf.html() != ''){
            this.translate(ncf.html(), from, to, function(res){
                CKEDITOR.instances['content_info_'+ to +'_content'].insertHtml( res );
            });
        }

    },
    translate: function(text, from, to, callback)
    {
        engine.request.post({
            url: 'module/run/translator/ajaxTranslate',
            data:{
                text : text,
                from : from,
                to   : to
            },
            success: callback
        });
    }
};

$(document).ready(function(){
   engine.translator.init();
});