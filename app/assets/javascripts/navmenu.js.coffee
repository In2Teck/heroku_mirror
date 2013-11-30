$ ->
  $win = $(window)
  $win.on 'scrollstop', ->
    $("section.panel > nav").each (idx, el) ->
      top = { top: $win.scrollTop() + 120 }
      if Modernizr.csstransitions then $(el).css(top) else $(el).stop().animate(top)

  $(".video").on 'click', "img.video-embed", ->
    $this = $(this).wrap "<span/>"
    $div = $this.closest('span').addClass('video-embed flex-video widescreen').width($this.width()).height($this.height())
    $this.remove()
    $div.flowplayer "http://philly.2013.s3.amazonaws.com/videos/flowplayer.commercial-3.2.7.swf",
      key: "#$d16d9235d59aedf3b90"
      clip: $this.data("video")
      autoPlay: true
      autoBuffering: true
            
  $(".necesitasayuda").on 'click', (e)->
    e.preventDefault()
    $menu = $("menu.ayuda")
    if $menu.is(":visible")
      $menu.hide()
    else
      $menu.show()

  # badges
  (->
    $mini = $(".badge-seccion-nueva-mini")
    $badge = $(".badge-seccion-nueva")
    $big = $(".badge-seccion-nueva-big")

    $cont = $("<div>").css 'position', 'relative'

    # menu
    $("header:first > nav").find("> a.new").prepend $cont.clone().append($mini.clone().css
      position: 'absolute'
      top: 2
      right: 2
    )

    # básicos
    # $("#basicos").prepend $cont.clone().append($big.clone().css
    #   position: 'absolute'
    #   top: -50
    #   right: 40
    # )
    # $("#mundophiladelphia > nav").find("> a:eq(3)").prepend $cont.clone().append($badge.clone().css
    #   position: 'absolute'
    #   top: -10
    #   right: -10
    # )
  )()
