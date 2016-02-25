/**
 * Created by wg on 08.02.16.
 */
engine.contentTypes = {
    init: function()
    {
        console.log('engine.contentTypes.init() -> OK');
        $(document).on('click', '.b-contentTypes-delete', function(){
            var id = $(this).data('id');
            engine.contentTypes.delete(id);
        });

        this.initBuilder();
    },
    initBuilder: function()
    {
        console.log('engine.contentTypes.initBuilder()');

        var $builder = $('#builder'), bSubmit = $('.b-form-save');
        $builder.find('.box').each(function(){
            var id = $(this).attr('id');
            console.log(id);
            if(typeof id != 'undefined') {
                $('#configComponents').find('#'+id).remove();
            }
        });
        function initDragabble()
        {
            $(".htmlpage, .htmlpage .column").sortable({connectWith: ".column", handle: ".b-move"});//

            $(".boxes .box").draggable({
                connectToSortable: ".htmlpage .column",
                //revert:true,
                handle: ".b-move",
                drag: function (e, t)
                {
                    t.helper.width(100 + '%');
                },
                stop: function (e, t)
                {
                    $('.ui-sortable-placeholder').each(function(){
                        $(this).remove();
                    })
                }
            });
        }


        $(document).on('change', '#bu_select_grid', function(e){
            var tpl = getTemplate(this.value);
            $builder.append(tpl);
            initDragabble();
            $(this).find('option:first').attr('selected', true);
        });

        $(document).on('click', '.b-row-remove', function(e){
            removeRow(this);
        });

        $(document).on('click', '.b-box-remove', function(e){
            removeBox(this);
        });

        $(document).on('click', '.b-field-remove', function(e){
            removeField(this);
        });

        $(document).on('click', '.b-field-edit', function(e){
            editField(this);
        });

        $builder.bind('DOMNodeInserted DOMNodeRemoved', function(event) {
            var html = this.innerHTML;
            $('#data_settings_form').html(html);
        });


        initDragabble();

        function editField(el)
        {
            function makeSource(data){
                data = $.extend({
                    title: '',
                    type: 'text',
                    name: '',
                    id:   '',
                    placeholder: '',
                    required: '',
                }, data);
                var tpl = _.template(document.getElementById('sourceTplText').innerHTML);
                return tpl(data);
            }
            var id = $(el).parent('li').attr('id'),
                group = $('#' + id + '_group'),
                previewName = $(el).parent('li').find('.name'),
                source =''
                ;

            var tmpl = _.template(document.getElementById('editFieldTpl').innerHTML);
                var inp = group.find('.form-control');

                var data = {
                    title: group.find('.control-label').html(),
                    type: inp.attr('type') || 'textarea',
                    name: inp.attr('name'),
                    id  : inp.attr('name'),//.replace('[', '_').replace(']', '_'),
                    placeholder: inp.attr('placeholder'),
                    required: inp.attr('required'),
                    source :makeSource(data)
                }
                ;

            var result = tmpl({data: data, ts: new Date().getTime()});

            var pw = engine.dialog({
                content:result,
                title: 'Редагування поля',
                autoOpen: true,
                width: 750,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        previewName.text(data.title);
                        pw.dialog('close').remove();
                        group.replaceWith(source);
                        $builder.trigger('DOMNodeRemoved');
                    }
                }
            });


            $('.do-kp').on('change keyup',function(){

                data = {
                    title: $("#t_title").val(),
                    type: $("#t_type").find('option:selected').val(),
                    name: $("#t_name").val(),
                    placeholder: $("#t_placeholder").val(),
                    required:  $("#t_required").is(':checked')
                };

                source = makeSource(data);
                $('#htmlOut').html(source);
            });

            $('.do-kp:first').trigger('change');
        }

        function getTemplate(size)
        {
            var out = '';
            switch (size) {
                case '12':
                    out = '<div class="row clearfix"><div class="col-md-12 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '6x6':
                    out = '<div class="row clearfix"><div class="col-md-6 column ui-sortable"></div><div class="col-md-6 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '4x4x4':
                    out = '<div class="row clearfix"><div class="col-md-4 column ui-sortable"></div><div class="col-md-4 column ui-sortable"></div><div class="col-md-4 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '3x3x3x3':
                    out = '<div class="row clearfix"><div class="col-md-3 column ui-sortable"></div><div class="col-md-3 column ui-sortable"></div><div class="col-md-3 column ui-sortable"></div><div class="col-md-3 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '8x4':
                    out = '<div class="row clearfix"><div class="col-md-8 column ui-sortable"></div><div class="col-md-4 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '4x8':
                    out = '<div class="row clearfix"><div class="col-md-4 column ui-sortable"></div><div class="col-md-8 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '9x3':
                    out = '<div class="row clearfix"><div class="col-md-9 column ui-sortable"></div><div class="col-md-3 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                case '3x9':
                    out = '<div class="row clearfix"><div class="col-md-3 column ui-sortable"></div><div class="col-md-9 column ui-sortable"></div><a class="b-row-remove" href="" onclick="return false"><i class="fa fa-remove"></i></a><a class="b-move" href="" onclick="return false"><i class="fa fa-arrows"></i></a></div>';
                    break;
                default:

                    break;
            }

            return out;
        }

        function removeRow(el)
        {
            var d = engine.confirm('Дійсно видалити рядок?', function(){
                $(el).parent().remove();
                $builder.trigger('DOMNodeRemoved');
                d.dialog('close');
            })
        }
        function removeBox(el)
        {
            var d = engine.confirm('Дійсно видалити блок?', function(){
                $(el).parents('.box').remove();
                $builder.trigger('DOMNodeRemoved');
                d.dialog('close');
            })
        }

        function removeField(el)
        {
            var d = engine.confirm('Дійсно видалити поле?', function(){
                $(el).parent().remove();
                d.dialog('close');
            })
        }
/*


 function editField(el)
 {
 var field = $(el).parent('li'), id = field.attr('id'), sourceID = id + '_group',
 ts = new Date().getTime(),
 data = {title: '', type: '', name: '', placeholder: '', required: ''}
 ;

 var a = field.find('span.box-name');
 data.title = a.text();
 data.required = typeof data.required == 'undefined' ? '' : 'checked';

 var c = $('<form id="fieldEditForm'+ts+'" class="form-horizontal">\
 <div class="form-group">\
 <label class="col-sm-3 control-label">Назва:</label>\
 <div class="col-sm-9">\
 <input type="text" class="form-control" id="fieldName'+ts+'" required name="title" value="'+data.title+'">\
 </div>\
 </div>\
 <div class="form-group">\
 <label class="col-sm-3 control-label">Тип:</label>\
 <div class="col-sm-9">\
 <input type="text" class="form-control" required name="type" value="'+data.type+'">\
 </div>\
 </div>\
 <div class="form-group">\
 <label class="col-sm-3 control-label">Код:</label>\
 <div class="col-sm-9">\
 <input type="text" class="form-control" required name="name" value="'+data.name+'">\
 </div>\
 </div>\
 <div class="form-group">\
 <label class="col-sm-3 control-label">Плейсхолдер:</label>\
 <div class="col-sm-9">\
 <input type="text" class="form-control" name="placeholder" value="'+data.placeholder+'">\
 </div>\
 </div>\
 <div class="form-group">\
 <div class="col-sm-8 col-sm-offset-4">\
 <div class="checkbox">\
 <input type="checkbox" '+data.required+' name="required"> Обов\'язкове\
 </div>\
 </div>\
 </div>\
 </form>');

 var pw = engine.dialog({
 content: c,
 title: 'Налаштування поля',
 autoOpen: true,
 width: 600,
 modal: true,
 buttons: {
 "Зберегти": function(){
 var n = $('#fieldName'+ts).val();
 //var data = $('#fieldEditForm'+ts).serializeArray();
 field.find('span.name').text(n);
 pw.dialog('close').remove();
 }
 }
 });

 }

 $(document).on('click', '.b-box-edit', function(e){
 editBox(this);
 });


 $(document).on('click', '.b-field-add', function(e){
 addField(this);
 });
        function addField(el)
        {
            var formFields = $(el).parents('fieldset:eq(0)').find('.form-fields'),
                ts = new Date().getTime();
            console.log(formFields.html());
            var c = $('<form id="fieldEditForm'+ts+'" class="form-horizontal">\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Назва:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" id="fieldName'+ts+'" required name="title">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Тип:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" required name="type">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Код:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" required name="name">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Плейсхолдер:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" name="placeholder">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <div class="col-sm-8 col-sm-offset-4">\
                                    <div class="checkbox">\
                                    <input type="checkbox" name="required"> Обов\'язкове\
                                    </div>\
                                </div>\
                            </div>\
                </form>');

            var pw = engine.dialog({
                content:c,
                title: 'Додати поле',
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        var n = $('#fieldName'+ts).val();
                        var data = $('#fieldEditForm'+ts).serialize();
                        formFields.append('<li class="field">\
                            <span class="name">'+n+'</span>\
                            <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>\
                            <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>\
                            <input type="hidden" class="field-settings" value="'+data+'">\
                            </li>');
                        pw.dialog('close').remove();
                    }
                }
            });

        }
        function editField(el)
        {
            var field = $(el).parents('.field:eq(0)'), s = field.find('.field-settings').val(),
                settings = {title: '', type: '', name: '', placeholder: '', required: ''}, ts = new Date().getTime();
            if(s != ''){
                var pairs = s.split('&');
                for(var i in pairs){
                    var split = pairs[i].split('=');
                    settings[decodeURIComponent(split[0])] = decodeURIComponent(split[1]);
                }
            }

            settings.required = typeof settings.required == 'undefined' ? '' : 'checked';

            var c = $('<form id="fieldEditForm'+ts+'" class="form-horizontal">\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Назва:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" id="fieldName'+ts+'" required name="title" value="'+settings.title+'">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Тип:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" required name="type" value="'+settings.type+'">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Код:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" required name="name" value="'+settings.name+'">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <label class="col-sm-3 control-label">Плейсхолдер:</label>\
                                <div class="col-sm-9">\
                                    <input type="text" class="form-control" name="placeholder" value="'+settings.placeholder+'">\
                                </div>\
                            </div>\
                            <div class="form-group">\
                                <div class="col-sm-8 col-sm-offset-4">\
                                    <div class="checkbox">\
                                    <input type="checkbox" '+settings.required+' name="required"> Обов\'язкове\
                                    </div>\
                                </div>\
                            </div>\
                </form>');

            var pw = engine.dialog({
                content:c,
                title: 'Налаштування поля',
                autoOpen: true,
                width: 600,
                modal: true,
                buttons: {
                    "Зберегти": function(){
                        var n = $('#fieldName'+ts).val();
                        var data = $('#fieldEditForm'+ts).serialize();

                        field.find('span.name').text(n);
                        field.find('.field-settings').val(data);
                        pw.dialog('close').remove();
                    }
                }
            });

        }

        function removeField(el)
        {
            var d = engine.confirm('Дійсно видалити поле?', function(){
                $(el).parent().remove();
                d.dialog('close');
            })
        }*/

    },
    onCreateSuccess: function(d)
    {
        location.href = "./contentTypes";
    },
    delete: function(id)
    {
        engine.confirm
        (
            t.contentTypes.delete_confirm,
            function()
            {
                engine.request.get('./contentTypes/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('contentTypes');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    }
};

$(document).ready(function(){
   engine.contentTypes.init();
});