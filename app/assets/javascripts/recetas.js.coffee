# = require external
# = require jquery
# = require jquery_ujs
# = require jquery.isotope
# = require jquery.scrollstop
# = require flowplayer-3.2.6.min
# = require foundation
# = require log
# = require waypoints
# = require navmenu
# = require_self
# = require prueba

$ ->
  ajax = {}
  filtrosAplicar = ->
    ajax.abort()  if ajax.readyState and ajax.readyState isnt 4
    unless $(".recetas-sinresultados").length
      $("<span/>",
        href: window.location
        class: "recetas-sinresultados"
      ).text("Sin resultados").on("click", (e) ->
        e.preventDefault()
        $("html").scrollTop 0
      ).appendTo $("#recetas_cont")
    $(".recetas-sinresultados").hide()
    ajax = $.ajax(
      url: "/recetas"
      data: $filter_form.serialize()
      success: (ajax) ->
        $(".receta, .videotutorial", $container).remove()
        $(".videotutorial", ajax).prependTo $container
        $(".pagination").empty().append $(".pagination", ajax).contents()
        $(".pagination").waypoint pagination_waypoint,
          offset: "100%"
          triggerOnce: true

        $(".receta", ajax).appendTo $container
        $(".recetas-sinresultados").show()  unless $(".receta", ajax).length
    )

  $filter_form = $("<form/>").append($("<input>",
    class: "filtro"
    name: "filtro"
  )).append($("<input>",
    class: "tiempo"
    name: "tiempo"
    value: 0
  ))
  
  pagination_waypoint = (e, d) ->
    $(".pagination").waypoint "remove"
    return  unless $(".pagination .next").length
    return if $(this).data('once')

    $(this).data('once', true)
    $.ajax
      url: $(".pagination .next a").attr("href")
      success: (ajax) ->
        $r = $(".receta", ajax).appendTo($container)
        $pag = $(".pagination", ajax)
        setTimeout (->
          $(".pagination").empty().data('once', false).append $(".pagination", ajax).contents()
          if $pag.length
            $(".pagination").waypoint pagination_waypoint,
              offset: "100%"
              triggerOnce: true
        ), 700

  a = 0
  $("#recetas_cont").css "minHeight", window.innerHeight
  $(".filtro").on "click", (e) ->
    e.preventDefault()
    return  if $(this).is(".actual")
    $filter_form.find(".filtro").val $(this).data("filtro")
    $("html").scrollTop 0
    $(".filtro").removeClass "actual"
    $(this).addClass "actual"
    filtrosAplicar.call $(this)

  $container = $("#recetas_cont")
  $(".pagination").waypoint pagination_waypoint,
    offset: "100%"
    triggerOnce: true

  $(".filtro-tiempo :radio").on "change", (e) ->
    $(".filtro-tiempo:not(:eq(" + $(this).closest(".filtro-tiempo").index(".filtro-tiempo") + ")) :radio[value='" + $(this).val() + "']").attr "checked", !!$(this).attr("checked")
    $filter_form.find(".tiempo").val $(this).val()
    $("html").scrollTop 0
    filtrosAplicar.call $(this)

  $(".licuar, .calentar, .rellenar").find("a").on "click", (e) ->
    e.preventDefault()
    video_id = (if $(this).closest("li").is(".licuar") then "tutorial-licuar.mov" else "tutorial-calentar.mov")
    $imagen = $(".imagen")
    $div = $(".video-overlay").empty()
    unless $div.length
      $div = $("<div/>",
        class: "video-overlay video-embed"
      ).css(
        position: "absolute"
        top: $imagen.offset().top
        left: $imagen.offset().left
        width: $imagen.width()
        height: $imagen.height()
        background: "rgba(255,255,255,0.5)"
      ).appendTo("body")
    $div.flowplayer "https://phillymx.s3.amazonaws.com/videos/flowplayer.commercial-3.2.7.swf",
      key: "#$d16d9235d59aedf3b90"
      clip: "https://phillymx.s3.amazonaws.com/videos/" + video_id
      autoPlay: true
      autoBuffering: true

  $("#buscar").submit (e) ->
    $this = $(this)
    if $this.find(".busqueda").val() is ""
      $this.find(".mensaje").show "fast"
      return false
    $.ajax
      url: $this.attr("action")
      data: $this.serialize()
      success: (ajax) ->
        $("#mensaje").hide "fast"

  $(".aprende").click ->
    if $(".videotutorial").length > 0
      $("#videos-small").hide "fast"
    else
      $("#videos-small").show "fast"

  $(".mejora, .impresiona, .licuar, .calentar, .rellenar").click ->
    $("#videos-small").hide "fast"

  $(".video-float").click (e) ->
    e.preventDefault()
    a = $(this).attr("class").match(/(\w*)-vid/)
    return  unless a
    $(".filtro." + a[1]).trigger "click"

  $("a").click ->
    datos = $(this).data("filtro")
    url = document.location.href
    if datos is "grupo-cuaresma"
      $(".cuaresma-liston").css "display", "block"
    else
      $(".cuaresma-liston").css "display", "none"
