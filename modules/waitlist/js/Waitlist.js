$(document).ready(function(){

    $(document).on('click', '.to-wait-list', function(e) {
        e.preventDefault();

        var $this = $(this), products_id = $this.data('id'),  formID = 'ocf_' + products_id, variants_id = 0,
            hasVariants = $this.data('has-variants');

        if($this.hasClass('in')) {
            self.location.href=$('.cart__link:first').attr('href');
            return;
        }

        if(hasVariants == 1){
            variants_id = $('#variants_'+products_id).find('option:selected').val();
        }

        var tpl = _.template
        (
            $('#waitListTpl').html())({
                products_id: products_id,
                variants_id: variants_id,
                formID:      formID,
                token :      TOKEN
            }
        );

        var d = App.dialog({
            title: 'Повідомте мене про появу',
            content: tpl,
            width: 450,
            buttons: {
                'Надіслати' : function(){
                    $('#waitList'+formID).submit();
                }
            }
        });

        App.validateAjaxForm('#waitList'+formID, function (res) {
            if(res.s){
                d.dialog('close');
                App.alert('Дякуємо. Ми повідомимо вас, як тільки товар появиться на складі.')
            }
        });
    });
});