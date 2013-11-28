$ ->
  regex = ///
    \b(\d[\s\d\/.]*?) # word boundary, encuentra numeros y opcionalmente expresiones numericas 1/2, 2, 2.5
    \s+ # espacio en blanco
    (
      ((?:tz|cd|cdit)as?|kg|gr|ml| # tza, cda, cdita, kg, g, ml
       piezas?|pizcas?|rebanadas?|ramas?|latas?|dientes?|hojas?| # palabras aceptadas
       paquetes?|litros?|rajas?|tiras?|sobres?|barras?|ralladura|
       tallos?) # es martes?
      \.?\s+(?:de|en)? # espacio y conjuncion, no capturados
    |) # o nada, ejemplo, 3 medallones, deja este grupo vacio
    \b\s*(.+?)\s*$ # letras, el ingrediente del que se habla
  ///im
  $container = $('<div>').addClass('parsed_ingredients').insertAfter('#recipe_ingredientes')
  parse = (lines) ->
    $ingredient_parsed = $('<table/>').append($('<tr><th>Cantidad</th><th>Unidad</th><th>Ingrediente</th></tr>'))
    for line in lines.split('\n')
      line.replace regex, ($1, $2, $3, $4, $5) ->
        $4 ||= ""
        $tr = $('<tr>')
        .append $("<td>#{$2}</td><td>#{$4}</td><td>#{$5}</td>")
        $ingredient_parsed.append $tr
    $container.empty().append $ingredient_parsed

  parse $('#recipe_ingredientes').val()
  $('#recipe_ingredientes').keyup ->
    $this = $(this)
    delay ->
      parse $this.val()
    , 500