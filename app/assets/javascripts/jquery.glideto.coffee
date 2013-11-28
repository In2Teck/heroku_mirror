#  Project: jQuery glideTo
#  Description: Allows local scrolling defining different x and y axis
#  Author: Jeduan Cornejo
#  License: MIT

# the semi-colon before function invocation is a safety net against concatenated
# scripts and/or other plugins which may not be closed properly.
``
(($, window, document) ->
  scrollableElement = (elements...) ->
    for el in elements
      $scrollElement = $(el)
      if $scrollElement.scrollTop() > 0
        return el
      else
        $scrollElement.scrollTop 1
        isScrollable = $scrollElement.scrollTop() > 0
        $scrollElement.scrollTop 0
        return el  if isScrollable
    []
  filterPath = (string) ->
    string = "" + string
    string.replace(/^\//, "").replace(/(index|default).[a-zA-Z]{3,4}$/, "").replace /\/$/, ""

  # Create the defaults once
  pluginName = 'glideTo'

  defaults =
    scrollVertical: scrollableElement('html', 'body')
    easing: 'easeInOutQuad'
    duration: 1000
    sectionSelector: 'section'
    screenSelector: 'article'

  class GlideTo
    constructor: (@element, options) ->
      @options = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName
      @scrollVertical = $(@options.scrollVertical)
      @scrollHorizontal = @element

      @init()

    glideUpTo: (position, callback = ->) ->
      scrollVertical = @scrollVertical
      scrollHorizontal = @scrollHorizontal
      @scrollVertical.stop().animate
        scrollTop: position
      , @options.duration, @options.easing, ->
        callback.call()
        scrollVertical.scrollTop(position)
        scrollHorizontal.scrollTop(0)

    glideLeftTo: (position, $target, callback = ->) ->
      @scrollHorizontal.stop().animate
        scrollLeft: "+=" + position
      , @options.duration, @options.easing, callback
      $section = if $target.is(@options.sectionSelector) then $target else $target.closest(@options.sectionSelector)
      $('body').trigger('glideto:leftmove', $section)

    glideTo: (target) ->
      $target = $(target)
      window.location = "/#{target}" unless $(target).size()
      offset = $target.position()
      offset.left = $target.offsetParent().position().left unless $target.offsetParent().is(@scrollHorizontal)

      if offset.left is 0
        @glideUpTo offset.top, ->
          location.hash = target
          $('body').trigger 'glideto:end'
      else
        $('body').trigger 'glideto:willmoveleft'

        if offset.top is 0 and @scrollVertical.scrollTop() is 0
          @glideLeftTo offset.left, $target, ->
            location.hash = target
            $('body').trigger('glideto:end')


        else
          delayLeft = (if (@scrollVertical.scrollTop() is 0) then 0 else 100)
          that = this

          @glideUpTo 0, ->
            setTimeout (->
              that.glideLeftTo offset.left, $target, ->
                setTimeout (->
                  if offset.top > 0
                    that.glideUpTo offset.top, ->
                      location.hash = target
                      $('body').trigger 'glideto:end'
                  else
                    location.hash = target
                    $('body').trigger 'glideto:end'
                ), 100
            ), delayLeft

    init: ->
      @locationPath = filterPath(location.pathname)

  $.fn.glideTo = (options) ->
    if !$('body').data("plugin_#{pluginName}")
      $('body').data("plugin_#{pluginName}", new GlideTo(this, options))

  $.fn.glide = ->
    @each ->
      $(this).click (event) ->
        event.preventDefault()
        glide = $('body').data("plugin_#{pluginName}")
        thisPath = filterPath(@pathname) or glide.locationPath

        if glide.locationPath is thisPath and (location.hostname is @hostname or not @hostname) and @hash.replace(/#/, "")
          if @hash
            window._gaq and window._gaq.push ['_trackPageview', "/#{@hash}"]
            glide.glideTo(@hash)
            
)(jQuery, window, document)




