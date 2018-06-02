$(document).ready(function (){
});
$("#login").click(function (){
   $("#myModal").modal('show');
});
$("#validar").click(function (){
    var x = $("#user").val();
    var y = $("#pass").val();
    $.post("main",{"user":x,"pass":y,"op":1}, function(data){
      alert(data);  

       /*if(data>0){
           $(location).attr('href', 'http://localhost:9191/v2018/');
       }else{           
           $(location).attr('href', 'http://localhost:9191/v2018/home');
       }*/
    })
   $("#myModal").modal('hide');
});