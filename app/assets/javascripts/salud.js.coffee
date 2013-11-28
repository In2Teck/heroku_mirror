$ ->
  $('.calculadora form').on 'submit', (e) ->
    e.preventDefault()
    $aside = $(this).closest('aside')
    $resultado = $aside.find('div.hidden')

    # IMC
    if $aside.is(".calculadora-imc")
      peso = $aside.find("input[name='peso']").val()
      estatura = $aside.find("input[name='estatura']").val()
      imc = peso / (estatura*estatura)

      if imc < 18.5
        mensaje = "Tu peso es bajo. Es muy importante que en cada comida incluyas por lo menos un alimento de cada grupo del Plato del Bien Comer. Además no olvides desayunar y consumir algo ligero entre comidas para que te mantengas con energía todo el día."
        termometro = 1
      else if imc < 24.9
        mensaje = "¡Felicidades! Tu peso está dentro de un rango saludable"
        termometro = 2
      else if imc < 29.9
        mensaje = "De acuerdo a tu índice de masa corporal presentas sobrepeso, lo que incrementa el riesgo de que padezcas alguna enfermedad como infartos, diabetes, hipertensión y algunos tipos de cáncer. Por ello es importante que consuma una alimentación saludable, incluyendo muchas verduras y frutas. Además es recomendable que realices actividad física de manera constante. Consulta a un especialista.";
        termometro = 3
      else
        mensaje = "De acuerdo a tu índice de masa corporal presentas obesidad, lo que incrementa de manera importante el riesgo de que padezcas alguna enfermedad como infartos, diabetes, hipertensión y algunos tipos de cáncer. Por ello debes consumir una alimentación saludable, incluyendo muchas verduras y frutas. Además puede ser recomendable que realices actividad física de manera constante. Consulta a un especialista.";
        termometro = 4

      $resultado.find(".img-hold").empty().append($(".termometro-#{termometro}", $resultado).clone().show().removeClass('hidden'))

    # Calorías
    else if $aside.is(".calculadora-calorias")
      hombre = $aside.find("input[name='sexo']:checked").val() == 'h' ? true : false
      edad = $aside.find("input[name='edad']").val()*1
      peso = $aside.find("input[name='peso']").val()*1
      actividad = $aside.find("input[name='actividad']:checked").val()*1
      errors = []

      val = 0
      if 20 < edad < 60
        if hombre
          val = (15.3 * peso) + 679
        else
          val = (14.7 * peso) + 496
      else if 61 < 90
        if hombre
          val = (13.5 * peso) + 487
        else
          val = (13.1 * peso) + 596

      switch actividad
        when 2
          val *= 1.1
        when 3
          val *= 1.3
        when 4
          val *= 1.4
        else
          errors.push 'Favor de introducir tu nivel de actividad'

      mensaje = "Tu cantidad de calorías recomendada es #{Math.round val}"

    # Peso
    else if $aside.is(".calculadora-adecuado")
      estatura = $aside.find("input[name='estatura']").val()*1
      adecuado_bajo = Math.round(estatura * estatura * 18.5)
      adecuado_alto = Math.round(estatura * estatura * 24.9)
      mensaje = "De acuerdo a tu estatura, tu rango de peso saludable es entre #{adecuado_bajo} y #{adecuado_alto} kg"

    $resultado.show().find(".msj").text(mensaje) if mensaje

  $('.calculadora form').on 'ajax:success', (event, data, status, xhr) ->
    msj = data and data.msj or 'no pudimos calcular tus datos'
    $form.find("img").attr "src", $form.find('img').attr('src').replace(/([^/]*)\.[^.]*$/, "termometro-#{data.termometro}.jpg") if data.termometro
    $form.find('.msj').text(msj).end().slideDown()
