engine.nav = {
    init: function()
    {
        engine.require('content');
        console.log('engine.nav.init() OK');

        $(document).on('click', '.b-nav-delete', function(){
            engine.nav.delete($(this).data('id'));
        });
        $(document).on('click', '.b-nav-item-delete', function(){
            engine.nav.deleteItem($(this).data('id'));
        });

        $('#data_code').change(function(){
            this.value = engine.content.translit( this.value, 'uk');
        });

        $('#selItems').change(function(){

            if(this.value == '') return ;

            var item_id = this.value,
                nav_id = $(this).data('nav'),
                is_selected = false;

            $(selected_items).each(function(i,e){
                if(e.id == item_id){
                    is_selected = true;
                    return;
                }
            });

            if(is_selected){
                engine.alert('Цей пункт вже вибраний!');

                return ;
            }

            engine.request.post({
               url: 'nav/addItem',
                data: {
                    item_id : item_id,
                    nav_id  : nav_id
                },
                success: function(res)
                {
                    if(res.s){
                        engine.nav.renderItems(res.items);
                    }
                }
            });
        });


        engine.nav.renderItems(selected_items);

    },
    delete: function(id)
    {
        engine.confirm
        (
            t.nav.delete_question,
            function()
            {
                engine.request.get('./nav/delete/' + id, function(d){
                    if(d > 0){
                        engine.refreshDataTable('nav');
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    deleteItem: function(id)
    {
        engine.confirm
        (
            t.nav.delete_item_question,
            function()
            {
                engine.request.get('./nav/deleteItem/' + id, function(d){
                    if(d > 0){
                        $("#nav-item-"+id).remove();
                    }
                });
                $(this).dialog('close').dialog('destroy').remove();
            }
        );
    },
    renderItems: function(items)
    {
        if(items.length == 0) return ;
        var tmpl = _.template($('#nItems').html());
        $("#navItems").html(tmpl({items: items}));

        $("#tblItems tbody").sortable({
            handle: ".sort",
            update: function()
            {
                engine.nav.setPositions();
            }
        });


        engine.nav.setPositions();
    },
    setPositions: function()
    {
        var inp = $('#pos'), pos = [];
        $("#tblItems tbody tr").each(function(){
            var id = $(this).attr('id'); id = id.replace('nav-item-', ''); id= parseInt(id);
            pos.push(id);
        });

        inp.val(pos.join('x'));
    }
};

$(document).ready(function(){
   engine.nav.init();
});