$(document).ready(function(){
    if($('#productsSimilar').length == 0) return;

    var categories_id = $('#content_id').val();

    var getSelected = function()
    {
        engine.request.get('module/run/productsSimilar/getSelected/' + categories_id, function(res){
            var cnt = $('#s_p_similar_list');
            var tmpl = _.template($('#p_similar_tpl').html());
            var d = tmpl({items: res.items});
            cnt.html(d);
        });
    };
    getSelected();
    $(document).on('click', '.b-sp-similar-sel-f', function(){
       engine.request.get('module/run/productsSimilar/getFeatures/'+categories_id, function(res){
          var pw = engine.dialog({
             title: 'Виберіть властивості',
             content: res,
              width: 500,
              buttons: {
                  'Зберегти': function()
                  {
                      $('#productsSimilarForm').submit();
                  }
              }
          });

           engine.validateAjaxForm('#productsSimilarForm', function(d){

               if(d.s){
                   getSelected();

                   pw.dialog('destroy').remove();
               }
           });

           $('.s-similar-features').select2();
       });
    });

    $(document).on('click', '.b-similar-delete-feat', function(){
       var id = $(this).data('id');
        var di = engine.confirm('Дійсно видалити властивість?', function(){
           engine.request.get('module/run/productsSimilar/delete/' + id, function(res){
                if(res > 0){
                    getSelected();
                    di.dialog('destroy').remove();
                }
            });
        });
    });
});