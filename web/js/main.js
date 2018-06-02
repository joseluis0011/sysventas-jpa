$(document).ready(function (){

});
/*
$("#rol").click(function (){
    alert("rol");
    $.get("menu",{"op":1},function (url) {
        $(location).attr('href',url);
    });
});
*/
$("#updateDatos").click(function (){
    var idpersona = $("#updid").text();
    $("#updateModal").modal('show');
    $.post("hc", {"opc":6, "idpersona": idpersona},function(data){
       var x = JSON.parse(data);       
       $("#updnom").val(x.nombres);
       $("#updape").val(x.apellidos);
       $("#updcla").val(x.clave);         
    });        
});
$("#updateUser").click(function (){
    var idper = $("#updid").text();
    var nombres = $("#updnom").val();
    var apellidos = $("#updape").val();
    var clave = $("#updcla").val();  
    
    $.post("hc",{"opc":7, "idpersona":idper,"nombres":nombres,"apellidos":apellidos,"clave":clave}, function (data) {
        if (data > 0) {
            $(location).attr('href', 'http://localhost:8084/v2018/home.jsp');
        }
    })
            
})