$(document).ready(function(){
    App.request.get('route/adminPanel/index', function(d){
        $(d).prependTo('body');
    });

    $(document).on("click",'.admin-panel-enable-editing', function(){
       App.request.get('route/adminPanel/enableEditing', function(d){
          location.reload(true);
       });
    });

    $(document).on("click",'.admin-panel-disable-editing', function(){
       App.request.get('route/adminPanel/disableEditing', function(d){
          location.reload(true);
       });
    });

    $(document).on("click",'.admin-panel-logout', function(){
       App.request.get('/engine/admin/logout', function(d){
          location.reload(true);
       });
    });

    if(typeof CKEDITOR != 'undefined'){

        CKEDITOR.disableAutoInline = true;

        $('.ce').each(function(){
            var $this =$(this),  col = $this.data('id'), id=$this.attr('id');
            if( typeof id == 'undefined'){
                id= 'ce_' + col;
                $this.attr('id', id);
            }

            $this.attr('contenteditable', true);

            CKEDITOR.inline( id, {
                customConfig: '/vendor/ckeditor/config_inline.js'
            } );
        });

    }
});
