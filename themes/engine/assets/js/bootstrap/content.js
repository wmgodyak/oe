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

        this.features.init();
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
    },
    features: {
        init: function()
        {
            $(document).on('click', '.b-ct-features-add', function(){
               var content_id = $('#contentFeaturesFs').data('id');
               var parent_id  = $(this).data('parent');

                engine.content.features.add(content_id, parent_id);
            });

            $(document).on('click', '.b-cf-add-val', function(){
               var parent_id  = $(this).data('parent');

                engine.content.features.addValue(parent_id);
            });

            $(document).on('click', '.cf-file-browse', function(){
               var target = $(this).data('target');
                engine.content.features.fileBrowse(target);
            });

            $('.cf-feature-select').select2();
        },
        add: function(content_id, parent_id)
        {
            engine.request.post({
                url: 'contentFeatures/create',
                data: {
                    content_id : content_id,
                    parent_id  : parent_id
                },
                success: function(res){
                    var pw = engine.dialog({
                        content: res,
                        title: 'Створення властивості',
                        autoOpen: true,
                        width: 750,
                        modal: true,
                        buttons: {
                            "Зберегти": function(){
                                $('#formContentFeatures').submit();
                            }
                        }
                    });
                    engine.validateAjaxForm('#formContentFeatures', function(res){
                        if(res.s > 0){
                            pw.dialog('close').remove();
                            if(res.f != null){
                                $("#content_features_" + parent_id).append(res.f);
                            }
                        }
                    });

                    $('.cf-feature-select').select2();

                    $('#data_type')
                        .change(function(){
                            if(this.value == 'select'){
                                $('.fg-show-filter, .fg-multiple').show();
                            } else {
                                $('.fg-show-filter, .fg-multiple').hide();
                            }
                        })
                        .trigger('change');

                    var inp = $('.f-info-name:first'), lang = inp.data('lang'), code = $('#f_data_code');
                    var ce = code.val() == '';
                    inp.keyup(function(){
                        var text = this.value;

                        if(ce) {
                            text = engine.content.translit(text, lang);
                            text = text.replace(/-/g, '_');
                            code.val(text);
                        }
                    });
                }
            });
        },
        addValue: function(parent_id)
        {
            engine.request.post({
                url: 'contentFeatures/createValue',
                data: {
                    parent_id  : parent_id
                },
                success: function(res){
                    var pw = engine.dialog({
                        content: res,
                        title: 'Створення значеня',
                        autoOpen: true,
                        width: 600,
                        modal: true,
                        buttons: {
                            "Зберегти": function(){
                                $('#formContentFeaturesValues').submit();
                            }
                        }
                    });

                    engine.validateAjaxForm('#formContentFeaturesValues', function(res){
                        if(res.s > 0){
                            if(res.v){
                                var opt = "<option selected value='"+ res.v.value +"'>"+ res.v.name +"</option>";
                                $('#content_features_' + parent_id).append(opt).select2();
                            }
                            pw.dialog('close').remove();
                        }
                    });
                }
            });
        },
        fileBrowse: function(targetID)
        {
            var frame = '<iframe width="100%" height="570" src="/vendor/filemanager/dialog.php?type=1&field_id='+targetID+'&token='+TOKEN+'" frameborder="0" style="overflow: scroll; overflow-x: hidden; overflow-y: scroll; "></iframe>';
            engine.dialog({
                    content: frame,
                    title: 'Файловий менеджер',
                    autoOpen: true,
                    width: 880,
                    modal: true,
                    buttons: {}
                });
        }
    }
};
function responsive_filemanager_callback(field_id){
    var inp = $('#' + field_id);
    var v = inp.val();
    v = v.replace('https://', '');
    v = v.replace('http://', '');
    v = v.replace(location.hostname, '');
    inp.val(v);
    engine.closeDialog();
}
$(document).ready(function(){
    engine.content.init();
});
