$ ->
  $win = $(window)
  waypoint_opts =
    offset: 200
    # continous: false
  $as = $('.container > header nav a')

  findSectionFromHash = ->
    hash = window.location.hash
    return $('section.home') unless hash
    $el = $("#{hash}")
    return if $el.is('section') then $el else $el.closest('section')

  $currentSection = findSectionFromHash()
  $currentArticle = null

  $('#main').glideTo()

  $("a[href*=#]").glide()

  changeSection = ->
    $currentSection.css("maxHeight", 99999)
    $currentSection.css("minHeight", window.innerHeight)
    $currentSection.find("img.lazy").lazyload()
    $currentSection.find('article').waypoint (event, direction) ->
      active = $(this).data('nav') or event.target.id
      if direction is 'up'
        active = $(this).prev().data('nav') or $(this).prev().attr('id')
      flecha = $(this).closest('section').find('nav .flecha')
      nav = $currentSection.find('nav a').removeClass('active')
        .filter("a[href=##{active}]").addClass('active').append(flecha)
      if direction is 'up' and $(this).prev().data('nav') is 'none'
        flecha.appendTo($(this).closest('section').find('nav'))
    , waypoint_opts
    $as.removeClass('active')
    theId = $currentSection.attr('id') or $currentSection.children('article:first').attr('id')
    $as.filter("a[href='/##{theId}'], a[href=##{theId}]").addClass('active')

  changeSection()

  $('body').on 'glideto:leftmove', (event, section) ->
    $currentSection = $(section)
    changeSection()

  $('body').on 'glideto:end', (event, section) ->
    $("section.panel").not($currentSection).css('maxHeight', 816)
  .trigger 'glideto:end' if $("section.panel").size() > 1

  $('body').on 'glideto:willmoveleft', ->
    $currentSection.find('article').waypoint 'remove'

  $("img.lazy").show()
  .each ->
    $this = $(this);
    $this.css
      height: $this.attr("height")
      width: $this.attr("width")
  
  $("img.video-embed.youtube").on 'click', ->
    $this = $(this)
    youtube_id = $this.data("video")
    $this.wrap('<span>')
    $span = $this.closest('span').empty()
    $("<iframe/>").width(640).height(360).attr("src", "//youtube.com/embed/#{youtube_id}?hl=es&fs=1&autoplay=1&rel=0&wmode=transparent&showinfo=0").appendTo($span)

  $("img.video-embed:not(.youtube)").on 'click', ->
    $this = $(this).wrap "<span/>"
    $div = $this.closest('span').addClass('video-embed flex-video widescreen').width($this.width()).height($this.height())
    $this.remove()
    $div.flowplayer "http://philly.2013.s3.amazonaws.com/videos/flowplayer.commercial-3.2.7.swf",
      key: "#$d16d9235d59aedf3b90"
      clip: $this.data("video")
      autoPlay: true
      autoBuffering: true

  $(".vid_img.youtube").click (e) ->
    e.preventDefault()
    reveal_id = $(this).data("reveal-id") or "reveal-video-global"
    titulo = $(this).data("video-titulo")
    $("##{reveal_id} h1").text(titulo)
    video = $(this).data("video-url")
    $("<iframe/>").width(640).height(360).attr("src", "//youtube.com/embed/#{video}?hl=es&fs=1&autoplay=1&rel=0&wmode=transparent&showinfo=0").appendTo("##{reveal_id} .video")
    $("##{reveal_id}.reveal-modal").unbind('reveal:close').bind 'reveal:close', ->
        $('.video.flex-video.widescreen').empty()

  $(".tips_vid_img, .vid_img:not(.youtube)").click (e) ->
    e.preventDefault()
    reveal_id = $(this).data("reveal-id") or "reveal-video-global"
    titulo = $(this).data("video-titulo")
    $("##{reveal_id} h1").text(titulo)
    video = $(this).data("video-url") 
    $("##{reveal_id} .video").width(640).height(220).flowplayer "http://philly.2013.s3.amazonaws.com/videos/flowplayer.commercial-3.2.7.swf",
      key: "#$d16d9235d59aedf3b90"
      clip: "http://philly.2013.s3.amazonaws.com/videos/#{video}"
      autoPlay: true
      autoBuffering: true
    $("##{reveal_id}.reveal-modal").unbind('reveal:close').bind 'reveal:close', ->
        $('.video.flex-video.widescreen').empty()

  $(".conoce_vid_img").click (e) ->
    e.preventDefault()
    titulo = $(this).data("video-titulo")
    $('#conoce-video h1').text(titulo)
    video = $(this).data("video-url") 
    $("#conoce-video .video").width(640).height(220).flowplayer "http://philly.2013.s3.amazonaws.com/videos/flowplayer.commercial-3.2.7.swf",
      key: "#$d16d9235d59aedf3b90"
      clip: "http://philly.2013.s3.amazonaws.com/videos/#{video}"
      autoPlay: true
      autoBuffering: true
  $('#conoce-video').bind 'reveal:close', ->
      $('.video.flex-video.widescreen').empty()

  $(".food-logo").click (e) ->
    e.preventDefault()    
    $this = $(this)    
    return true if $this.hasClass("selected")
    $this.closest('.logos').find('.food-logo').removeClass('selected')
    $this.addClass('selected')
    $this.closest(".logo-element").find(".fs-contenido").removeClass("food-active")
    $this.closest(".logo-element").find(".fs-contenido:first").addClass("food-active").clone().appendTo($this.closest("article").find(".content-contenedor").show("slow").empty())    
    if $this.closest(".logo-element").find(".food-active").next(".fs-contenido").size()
      $this.closest("article").find(".content-contenedor .flecha-next").show()
    else $('.flecha-next').hide()
  
  $(".flecha-next").live 'click', (e) ->
    $this = $(this)
    $this.closest('article').find('.logos .food-active').removeClass("food-active").next().addClass("food-active").clone().appendTo($this.closest("article").find(".content-contenedor").show("slow").empty())    
    $(".flecha-prev").show()
  
  $(".flecha-prev").live 'click', (e) ->
    $this = $(this)
    $this.closest('article').find('.logos .food-active').removeClass("food-active").prev().addClass("food-active").clone().appendTo($this.closest("article").find(".content-contenedor").show("slow").empty())
    $(".flecha-next").show()

  $('.manual-icon').click (e) ->
    e.preventDefault()
    $this = $(this)  
    $this.closest('.menu-manual').find('.active').removeClass('active')
    $this.find('img').addClass('active')
    id = '#'+ $this.data('id')
    $('.manual-contenido').find('.activo').hide('fast').removeClass('activo')
    $('.manual-contenido').find(id).show('fast').addClass('activo')

  $('.tips-icon').click (e) ->
    e.preventDefault()
    $this = $(this)  
    $this.closest('.tips-content').find('.active').removeClass('active')
    $this.addClass('active')
    id = '#'+ $this.data('id')
    $('.tips-cocina-content').find('.activo').hide('fast').removeClass('activo')
    $('.tips-cocina-content').find(id).show('fast').addClass('activo')

  $('.equivalencias-boton').click (e) ->
    e.preventDefault()
    $this = $(this)
    id = '#'+$this.data('id')
    $('.equiv-content').find('.activo').slideUp('fast').removeClass('activo')
    $('.equiv-content').find(id).slideDown('fast').addClass('activo') 

  $('.flecha').click ->
    $('.equiv-content').find('.activo').slideUp('fast').removeClass('activo')  

  $('.videos-vermas').click ->
    $('.videos-content').fadeToggle()

  $('#suscripcion_email').on 'focusin focusout', (e) ->
    $input = $(this)
    $label = $input.closest('p').find 'label'

    unless $input.data('size')
      $input.data 'size',
        width: $input.width()
        padding: parseInt($input.css('padding-left'), 10)

    size = $input.data('size')

    switch e.type
      when 'focusin'
        $input.css('padding-left', 5).width size.width + size.padding-5
        $label.hide()
      when 'focusout'
        unless $input.val().length
          $label.show()
          $input.css('padding-left', size.padding).width size.width
  .trigger 'focusin'

  (->
    $superior = $("#home .superior")
    $superior.find(".orbit").orbit
      animation: 'fade'
      advanceSpeed: 500000
      animationSpeed: 1000
      directionalNav: true
      captions: false
      bullets: false
      pauseOnHover: false
    $orbit_timer = $superior.find(".orbit-wrapper").find(".timer").hide()
    $orbit_nav = $superior.find(".orbit-wrapper").find(".slider-nav")
    $orbit_nav.find('.left, .right').on 'click', (e) ->
      setTimeout ->
        $orbit_timer.find('.pause').trigger 'click'
      , 100
  )()

  $('#home_slider').css
    position: 'relative'
  .each (e) ->
    $slider = $(this)
    total = $slider.find('img').size()
    $nav = $("<nav>").appendTo($slider)
      .css
        top: 190
        textAlign: 'center'
        width: '100%'

    $ "<a>",
      class: 'boton'
      href: '#'
    .data('banner', i)
    .on 'click', (e) ->
      e.preventDefault()
      $slider.find("img").hide()
      $slider.find("img:eq(#{$(this).data 'banner'})").show()
      $nav.find('a.activo').removeClass 'activo'
      $(this).addClass 'activo'
    .appendTo $nav for i in [0...total]

    rnd = Math.floor Math.random()*total
    $slider.find("img").hide()
    $slider.find("img:eq(#{rnd})").show()
    $nav.find("a:eq(#{rnd})").addClass 'activo'