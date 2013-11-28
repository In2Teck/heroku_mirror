//= require external
//= require jquery
//= require jquery_ujs
//= require jquery.validate
//= require_self
jQuery.validator.addMethod("alphanumeric", function(value, element) {
	return this.optional(element) || /^\w+$/i.test(value);
}, "El campo no pueden contener ningun caracter especial");

$(function(){
  $('#chat_philly').validate({
    rules: {
      'firstName': { required: true, alphanumeric:true, maxlength: 32 },
      'lastName': { required: true, alphanumeric:true, maxlength: 32 },
      'email': { required: true, email: true },
      'phoneNumber': 'number',
      'extension': 'number'													
  	},
    messages: {
      'firstName': { required: 'Debe ingresar el nombre', alphanumeric:'El campo no pueden contener ningun caracter especial', maxlength: 'Ingresa maximo 32 caracteres'},
      'lastName': { required: 'Debe ingresar el apellido', alphanumeric:'El campo no pueden contener ningun caracter especial', maxlength: 'Ingresa maximo 32 caracteres'},
      'email': { required: 'Debe ingresar un correo electrónico', email: 'Debe ingresar el correo electrónico con el formato correcto. Por ejemplo: u@localhost.com' },
      'phoneNumber': 'Debe ingresar un número',
      'extension': 'Debe ingresar un número'
    }
	
  });
});
$(function(){
  $('#call_philly').validate({
    rules: {
      'firstName': { required: true, maxlength: 32 },
      'lastName': { required: true, maxlength: 32 },
      'emailaddress': { required: true, email: true },
      'telephone': 'number',
      'extension': 'number'													
  	},
    messages: {
      'firstName': { required: 'Debe ingresar el nombre',  maxlength: 'Ingresa maximo 32 caracteres'},
      'lastName': { required: 'Debe ingresar el apellido', maxlength: 'Ingresa maximo 32 caracteres'},
      'emailaddress': { required: 'Debe ingresar un correo electrónico', email: 'Debe ingresar el correo electrónico con el formato correcto. Por ejemplo: u@localhost.com' },
      'telephone': 'Debe ingresar un número',
      'extension': 'Debe ingresar un número'
    }
	
  });
});

