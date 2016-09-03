var Wishlist = {
    init: function()
    {
        var wLink = $('#wishlistLink');

        $(document).on('click', '.wishlist-add', function(e){
            e.preventDefault();

            var $this = $(this), products_id = $this.data('id'), variants_id = 0,
                formID = 'wl_' + products_id + '_' + variants_id,
                hasVariants = $this.data('has-variants');

            if($this.hasClass('hearth-like__link--liked')) {
                Wishlist.delete(products_id, variants_id, function(res){
                    $this.removeClass('hearth-like__link--liked');
                });
                return;
            }

            if(hasVariants == 1){
                variants_id = $('#variants_'+products_id).find('option:selected').val();
            }

           Wishlist.add(products_id, variants_id, function(res){
               if(res.s == 0 && res.a == 'login'){
                   var d = App.dialog({
                       title: 'Додавання в список бажань',
                       content: _.template($('#wishlistCreateTpl').html())({
                           products_id: products_id,
                           variants_id:variants_id,
                           formID:formID,
                           token : TOKEN
                       }),
                       buttons: {
                           'Зберегти' : function(){
                               $('#wishlist'+formID).submit();
                           }
                       }
                   });
                   App.validateAjaxForm('#wishlist' + formID, function (res) {
                       if(res.s){
                           d.dialog('close');
                           $this.addClass('hearth-like__link--liked');
                           wLink.addClass('active');
                           $.notify('Товар додано в список бажань. Ви можете переглянути список в своєму профілі');
                       }
                   });
                   return;
               }
               //alert('Process to add to wish list');
               $this.addClass('hearth-like__link--liked');
               wLink.addClass('active');
               $.notify("Товар додано в список бажань.\n Ви можете переглянути список в своєму профілі");
           });
        });

        $(document).on('click', '.wishlist-delete-item', function(e){
            var id = $(this).data('id');
            Wishlist.delete(id, function(){
                location.reload(true);
            });
        });
    },
    add: function(products_id, variants_id, onSuccess)
    {
        App.request.post(
            {
                url  : 'route/wishlist/add',
                data : {
                    products_id : products_id,
                    variants_id : variants_id
                },
                success  : onSuccess,
                dataType : 'json'
            }
        );
    },
    delete: function(id, onSuccess)
    {
        App.request.post(
            {
                url  : 'route/wishlist/delete',
                data : {
                    id : id
                },
                success  : onSuccess,
                dataType : 'json'
            }
        );
    }
};

$(document).ready(function(){
   Wishlist.init();
});