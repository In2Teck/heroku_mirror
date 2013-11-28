//= require external
//= require jquery
//= require jquery_ujs
//= require jquery.validate
//= require jquery.fancybox-1.3.4
//= require_self 
var url = document.location.href;
var hash = document.location.hash;
if(url==="http://www.philadelphia.com.mx/"||hash==="#home"){
  $('.flechas').hide('fast');
}
else{
  $(document).ready(function(){    
    $('.flechas').show('fast');  
  });    
}
$('nav>a').click(function(){
  $('.flechas').show('fast');
});
$('#logo a').click(function(){
  $('.flechas').hide('fast');
});
$('.scrolls').click(function(event){
    event.preventDefault();
		var anchor = $(window).height();
		$('body, html').stop().animate({
			scrollTop: '+='+anchor
		}, 1500);	
		
});

$('.scrolls').click(function(event){
    event.preventDefault();
		var anchor = $(window).height();
		$('body, html').stop().animate({
			scrollTop: '+='+anchor
		}, 1500);	
		
});
// jQuery.validator.addMethod("alphanumeric", function(value, element) {
//   return this.optional(element) || /^\w+$/i.test(value);
// }, "El campo no pueden contener ningun caracter especial");
// $(function(){
//   $('#boletin').validate({
//     rules: {
//       'suscripcion_nombre': { required: true, alphanumeric:true },
//       'suscripcion_apellido': { required: true, alphanumeric:true },
//       'suscripcion_email': { required: true, email: true },
//       'suscripcion_codigo': { required: true, number: true, minlength: 5, maxlength: 5 },
//       'suscripcion_terminos': 'required'                         
//     },
//     messages: {
//       'suscripcion_nombre': { required: 'Debe ingresar el nombre', alphanumeric:'El campo no pueden contener ningun caracter especial'},
//       'suscripcion_apellido': { required: 'Debe ingresar el apellido', alphanumeric:'El campo no pueden contener ningun caracter especial'},
//       'suscripcion_email': { required: 'Debe ingresar un correo electrónico', email: 'Debe ingresar el correo electrónico con el formato correcto. Por ejemplo: u@localhost.com' },
//       'suscripcion_codigo': { required: 'Debe ingresar su código postal', number: 'El campo codigo solo debe de contener numeros', minlength: 'El campo solo debe contener 5 caracteres', maxlength: 'El campo solo debe contener 5 caracteres'},
//       'suscripcion_terminos': 'Acepte los términos y condiciones'
//     }
  
//   });
// });
$("a.grouped_elements").fancybox({
  'titleShow' : true,
  'titlePosition' : 'inside',
  'transitionIn' : 'elastic',
  'transitionOut' : 'elastic',
  'overlayShow' : false,
  'hideOnContentClick' : 'true',
});


