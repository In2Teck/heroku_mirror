#= require jquery
#= require jquery_ujs
#= require jquery.mobile
#= require_self
#= require hammer
#= require jquery.hammer

$ ->
  $("#receta a.menu").live 'click', (e)->
    e.preventDefault()
    target = $(this).data('target')
    $('.activo').removeClass 'activo'
    $("div.#{target}").addClass 'activo' 

  $('.compartir').live 'click', (e)->
    e.preventDefault()
    $("#facebookHolder").append "<div id=\"fb-root\"></div>"
    $("#facebookHolder").append "<fb:like-box href=\"http://www.facebook.com/forexagone\" width=\"300\" show_faces=\"true\" stream=\"false\" header=\"false\"></fb:like-box>"
    jQuery.getScript "http://connect.facebook.net/en_US/all.js#xfbml=1", ->
      FB.init
        status: true
        cookie: true
        xfbml: true
  $('.compartir').live 'click', (e)->
    e.preventDefault()
    script = document.createElement("script")
    script.async = true
    script.id = "twitter-wjs"
    script.src = "//platform.twitter.com/widgets.js"
    document.body.appendChild script
