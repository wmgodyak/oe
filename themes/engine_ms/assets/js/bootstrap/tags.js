engine.tags = {
    init : function()
    {
        //var tags =$(".tags-input"), id=tags.data('category'), lang_id = tags.data('lang');
//        tags.on('itemRemoved', function(event) {
////            console.log('item removed : '+event.item, id);
//            $.ajax({
//                type: "POST",
//                url:'plugins/tags/remove',
//                data: {
//                    name: event.item,
//                    id: id,
//                    lang_id: lang_id
//                },
//                dataType: 'html'
//            });
//
//            return true;
//        });
    }
};

$(document).ready(function(){engine.tags.init();});