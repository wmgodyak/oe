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
            var boxes = $('.boxes'), htmlpage = $('.htmlpage');
            //$(".htmlpage, .htmlpage .column, .boxes .box").sortable({connectWith: ".column"});//, handle: ".b-move"
            //
            //$( ".boxes > .box").draggable({
            //    connectToSortable: ".htmlpage .column",
            //    revert: "invalid", // when not dropped, the item will revert back to its initial position
            //    containment: "document",
            //    cursor: "move",
            //    stop: function(){
            //        $( ".htmlpage .box").draggable({
            //            connectToSortable: ".boxes",
            //            revert: "invalid", // when not dropped, the item will revert back to its initial position
            //            containment: "document",
            //            cursor: "move",
            //            stop: function(){
            //
            //            }
            //        });
            //    }
            //});

            //$(".htmlpage, .htmlpage .column,.boxes").sortable({connectWith: ".column"});//, handle: ".b-move"
            //
            //$(".boxes .box").draggable({
            //    connectToSortable: ".htmlpage .column, .boxes",
            //    drag: function (e, t)
            //    {
            //        //t.helper.width(100 + '%');
            //    },
            //    stop: function (e, t)
            //    {
            //        //$('.ui-sortable-placeholder').each(function(){
            //        //    $(this).remove();
            //        //})
            //    }
            //});

            $(".htmlpage, .htmlpage .column,.boxes").sortable({connectWith: ".column"});//, handle: ".b-move"

            $(".boxes .box").draggable({
                connectToSortable: ".htmlpage .column, .boxes",
                drag: function (e, t)
                {
                    //t.helper.width(100 + '%');
                },
                stop: function (e, t)
                {
                    t.helper.css({
                        width: '',
                        height: '',
                        position: '',
                        top: '',
                        left: ''
                    });
                }
            });


        }


        $(document).on('change', '#bu_select_grid', function(e){
            var tpl = getTemplate(this.value);
            $builder.append(tpl);
            initDragabble();
            $(this).find('option:first').attr('selected', true);
        });

        $builder.bind('DOMNodeInserted DOMNodeRemoved', function(event) {
            var html = this.innerHTML;
            $('#data_settings_form').html(html);
        });

        initDragabble();

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