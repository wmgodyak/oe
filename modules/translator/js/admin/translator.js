engine.translator = {
    init: function()
    {
        $(document).on('click', '.auto-translate-language', function(e)
        {
            var id = $(this).data('id');
            engine.request.post({
               url: 'module/run/translator/index/'+id,
               data: {},
               success: function(d)
               {
                   var bi = 'Вперед';
                   var buttons = {};

                   buttons[bi] =  function(){
                       $('#translate').submit();
                   };

                   var dialog = engine.dialog({
                       content: d,
                       title: 'Автопереклад контенту',
                       autoOpen: true,
                       width: 750,
                       modal: true,
                       buttons: buttons
                   });

                   $('#translate')
                       .ajaxForm({
                           success: function(d)
                           {
                               $(d.t).each(function(i,e){
                                   translateTable(e.table, e.start, e.total, e.col, e.from_lang, e.to_lang);
                               });
                           },
                           dataType: 'json'
                       });

                   function successTranslation(lang)
                   {
                       $('#translate-box').hide();
                       //engine.languages.autoGenerateAlias(lang);
                   }

                   function translateTable(table, start, total, col, from_lang,to_lang)
                   {
                       var cnt = $('#t-' + table);
                       if(total == 0 || start >= total) {
                           cnt.hide();

                           if($('.table-to-translate:visible').length == 0){
                               successTranslation(from_lang);

                               return false;
                           }
                           return false;
                       }

                       //cnt.find('.process').html('(<span class="s">'+ start +'</span> : <span class="t">'+ total +'</span>)');

                       var percent =  100 / total, done = Math.round( start * percent ) ;
                       $("#progress-"+table).find('div').css('width', done + '%').html('('+ start +'/'+ total +')');

                       if(start < total){
                           engine.request.post({
                               url: 'module/run/translator/translateContent',
                               data: {
                                   table: table,
                                   start: start,
                                   total: total,
                                   col  : col,
                                   from_lang: from_lang,
                                   to_lang  : to_lang
                               },
                               success: function(d){
                                   setTimeout(function(){
                                       translateTable(d.table, d.start, d.total, d.col, d.from_lang, d.to_lang);
                                   }, 500);
                               },
                               dataType: 'json'
                           });
                           //setTimeout(function(){
                           //    start++;
                           //    translateTable(table, start, total, col, from_lang, to_lang);
                           //}, 100);
                       }
                       return false;
                   }
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