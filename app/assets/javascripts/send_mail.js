$(document).ready(function(){
	preloader();
	//updatereport();
});
function preloader(){
    $(".panel-heading").click(function(){
        console.log("CLicked"+this);
        $(this).siblings().toggle();
    });
    $("#sortable").sortable();
    $('.broadcast').click(function(){
        var id=$(this).attr('id').substr(9);
        var bid=".broadcast-bar"+id;
        console.log(id);
        $(".broadcast-bar").css("width","25%");
        $.ajax({
            type: "GET",
            dataType: "html",
            url: "http://"+window.location.host+"/send_mail/broadcast/"+id,
        })
        .done(function( msg ) {
            $(bid).css("width","100%");
            //updatereport();
            //alert( "Broadcasted");
        });
    });
}
function updatereport(){

	console.log("Generating Report..");
  $.ajax({
    	type: "GET",
        complete:preloader(),
    	url: "http://"+window.location.host+"/send_mail/reportcart/",
    	dataType: "html"
    })
    .done(function( msg ) {
    	$('.reportcard').html(msg);
    });
    preloader();
}
function upload_file(){

  console.log("Uploading..");
  $.ajax({
    	type: "GET",
        complete:preloader(),
    	url: "http://"+window.location.host+"/send_mail/upload",
    	dataType: "html"
    })
    .done(function( msg ) {
    	$('.up-file_report').html(msg);
    });
    preloader();
}
function up_file_report(x){
  var id=$(x).attr('id').substr(4);
  var t2=".to"+id+" input";
  var f2=".from"+id+" input";
  var t=$(t2).val();
  var f=$(f2).val();  
  console.log("Generating Report.."+t+f);
  $('.up-file_report').html("Generating Report<br><img height='50px' width='50px' src='http://"+window.location.host+"/assets/loading.gif'"+"/>");
  $.ajax({
    	type: "GET",
        complete:preloader(),
    	url: "http://"+window.location.host+"/send_mail/update_active_accounts?id="+id+"&to="+t+"&from="+f,
    	dataType: "html"
    })
    .done(function( msg ) {
    	$('.up-file_report').html(msg);
    });
    preloader();
}
function check_file_report(x){
  var id=$(x).attr('id').substr(5); 
  $('.up-file_report').html("Generating Report<br><img height='50px' width='50px' src='http://"+window.location.host+"/assets/loading.gif'"+"/>");
  $.ajax({
        type: "GET",
        complete:preloader(),
        url: "http://"+window.location.host+"/send_mail/edit?id="+id,
        dataType: "html"
    })
    .done(function( msg ) {
        $('.up-file_report').html("Verification Done..");
    });
    preloader();
}