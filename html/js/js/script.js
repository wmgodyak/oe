$(document).ready(function() {
    $(".categ").hover(
    	function () { $(this).addClass("active") },   //on mouse over
    	function () { $(this).removeClass("active") } //on mouse out
    );
});