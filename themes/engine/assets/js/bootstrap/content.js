/**
 * Created by wg on 29.02.16.
 */
engine.content = {
    init: function () {
        console.log('engine.content.init()');

        var infoName = $(".info-name");
            infoName.charCount({"counterText": "Залишилось:", "allowed": 200, "warning": 25});


        $(".info-url").charCount({"counterText": "Залишилось:", "allowed": 160, "warning": 25});
        $(".info-title,.into-h1,.info-keywords,.info-description")
            .charCount({"counterText": "Залишилось:", "allowed": 255, "warning": 50});

        infoName.each(function(i,e){
            var inp = $('.info-url:eq('+i+')'), title = $('.info-title:eq('+i+')'), lang = $(this).data('lang');
            var te = title.val() == '';
            $(this).keyup(function(){
               var text = this.value;

                if(te) {
                    title.val(text);
                }

                var url = engine.content.translit(text, lang);
                inp.val(url);
            });
        });

        $('#switchLanguages').find('button').click(function(){
            $(this).addClass('btn-primary').siblings().removeClass('btn-primary');
            var code = $(this).data('code');
            $('.switch-lang:not(.lang-'+code+')').hide();
            $('.switch-lang.lang-' + code).show();
        });

    },
    delete: function (id, callback) {
        engine.request.get('content/delete/' + id, function (d) {
            if (d.s) {
                engine.refreshDataTable('content');
                engine.closeDialog();

                if(typeof callback != 'undefined'){
                    callback(d);
                }

            } else {
                engine.alert(d.m);
            }
        }, 'json')
    },
    pub: function (id) {
        engine.request.get('content/pub/' + id, function (d) {
            engine.refreshDataTable('content');
        });
    },
    hide: function (id) {
        engine.request.get('content/hide/' + id, function (d) {
            engine.refreshDataTable('content');
        });
    },
    translit: function (text, lang) {
        function trim(s) {
            s = s.replace(/^-/, '');
            return s.replace(/-$/, '');
        }


        var space = '-';
        text = text.toLowerCase();

        var transl = {};

        switch (lang){
            case 'uk':
                transl = {
                    'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'e', 'ж': 'zh',
                    'з': 'z', 'и': 'y', 'й': 'j', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'і' : 'i',
                    'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h',
                    'ц': 'c', 'ч': 'ch', 'ш': 'sh', 'щ': 'sh', 'ъ': space, 'ы': 'y', 'ь': space, 'э': 'e', 'ю': 'yu', 'я': 'ya',
                    ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
                    '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
                    '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
                    ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
                    '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
                    '?': space, '<': space, '>': space, '№': space
                };
                break;
            case 'ru':
                transl = {
                    'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'e', 'ж': 'zh',
                    'з': 'z', 'и': 'i', 'й': 'j', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n',
                    'о': 'o', 'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h',
                    'ц': 'c', 'ч': 'ch', 'ш': 'sh', 'щ': 'sh', 'ъ': space, 'ы': 'y', 'ь': space, 'э': 'e', 'ю': 'yu', 'я': 'ya',
                    ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
                    '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
                    '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
                    ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
                    '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
                    '?': space, '<': space, '>': space, '№': space
                };
                break;
            default:
                transl = {
                    ' ': space, '_': space, '`': space, '~': space, '!': space, '@': space,
                    '#': space, '$': space, '%': space, '^': space, '&': space, '*': space,
                    '(': space, ')': space, '-': space, '\=': space, '+': space, '[': space,
                    ']': space, '\\': space, '|': space, '/': space, '.': space, ',': space,
                    '{': space, '}': space, '\'': space, '"': space, ';': space, ':': space,
                    '?': space, '<': space, '>': space, '№': space
                };
                break;
        }

        var result = '', c = '';

        for (var i = 0; i < text.length; i++) {
            if (transl[text[i]] != undefined) {
                if (c != transl[text[i]] || c != space) {
                    result += transl[text[i]];
                    c = transl[text[i]];
                }
            }
            else {
                result += text[i];
                c = text[i];
            }
        }

        return trim(result);
    }
};


$(document).ready(function(){
    engine.content.init();
});
