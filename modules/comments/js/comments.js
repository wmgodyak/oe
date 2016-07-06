App.comments = {
    init: function()
    {
        App.validateAjaxForm('#commentsForm', function (d) {
            App.alert(d.m, 'success');
            $('#commentsForm').resetForm();
        });

        $(document).on('click', '.comment-like', function(){
            var id = $(this).data('id'), $this = $(this);
            App.request.get
            (
                'route/comments/like/' + id,
                function(r){
                    if(r.s) $this.text(r.t);
                },
                'json'
            );
        });

        $(document).on('click', '.comment-dislike', function(){
            var id = $(this).data('id'), $this = $(this);
            App.request.get
            (
                'route/comments/dislike/' + id,
                function(r){
                    if(r.s) $this.text(r.t);
                },
                'json'
            );
        });
        $(document).on('click', '.comment-reply', function(){
            var id = $(this).data('id');
            $("#cParent").val(id);

            $('html, body').animate({
                scrollTop: $("#commentsForm").offset().top
            }, 1000);
            $('#cMessage').focus();
        });

        $(document).on('click', '.b-comments-subscribe', function(e){

            e.preventDefault();

            var id= $(this).data('id'), $this = $(this), t = $this.data('us');
            if(typeof id == 'undefined') {
                return false;
            }

            App.request.get('route/comments/subscribe/' + id, function(d){
                if(d>0){
                    $this.text(t).removeClass('b-comments-subscribe').addClass('b-comments-un-subscribe');
                }
            });
        });

        $(document).on('click', '.b-comments-un-subscribe', function(e){

            e.preventDefault();

            var id= $(this).data('id'), $this = $(this), t = $this.data('s');
            if(typeof id == 'undefined') return false;

            App.request.get('route/comments/unSubscribe/' + id, function(d){
                if(d > 0){
                    $this.text(t).removeClass('b-comments-un-subscribe').addClass('b-comments-subscribe');
                }
            });
        });
    }
};
$(document).ready(function(){
   App.comments.init();
});