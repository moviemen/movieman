###!
# ContentHover jQuery plugin v0.1
# http://www.backslash.gr/demos/contenthover-jquery-plugin/
#
# Copyright 2011 by Nikos Tsaganos
# http://www.backslash.gr/
###

(($) ->
  methods = 
    init: (options) ->
      defaults = 
        data_selector: '.contenthover'
        width: 0
        height: 0
        overlay_width: 0
        overlay_height: 0
        overlay_x_position: 'center'
        overlay_y_position: 'bottom'
        overlay_background: ''
        overlay_opacity: 1
        effect: 'fade'
        fade_speed: 400
        slide_speed: 400
        slide_direction: 'bottom'
        zindex: 2
        wrapper_class: 'ch_wrapper'
        normal_class: 'ch_normal'
        hover_class: 'ch_hover'
        onshow: ->
        onhide: ->
      settings = $.extend({}, defaults, options)
      @each ->
        $this = $(this)
        w = if $this.width() then $this.width() else settings.width
        h = if $this.height() then $this.height() else settings.height
        overlay_w = if settings.overlay_width then settings.overlay_width else w
        overlay_h = if settings.overlay_height then settings.overlay_height else h
        $data = $this.next(settings.data_selector)
        if $data.length
          $data.hide()
          $ch_wrapper = $('<div>').addClass('ch_element').addClass(settings.wrapper_class).css(
            'width': w
            'height': h
            'position': 'relative'
            'overflow': 'hidden').insertAfter($this)
          $ch_normal = $('<div>').addClass(settings.normal_class).css(
            'width': w
            'height': h
            'position': 'absolute'
            'z-index': settings.zindex).appendTo($ch_wrapper)
          $this.clone().appendTo $ch_normal
          $this.hide()
          $ch_hover = $('<div>').addClass(settings.hover_class).css(
            'width': overlay_w
            'height': overlay_h
            'position': 'absolute'
            'z-index': settings.zindex - 1).appendTo($ch_wrapper)
          $data.clone().show().appendTo $ch_hover
          ch_hover_css = {}
          if settings.overlay_background
            ch_hover_css.background = settings.overlay_background
          if settings.overlay_opacity < 1
            ch_hover_css.opacity = settings.overlay_opacity
          if settings.overlay_x_position == 'left'
            ch_hover_css.left = 0
          else if settings.overlay_x_position == 'right'
            ch_hover_css.left = w - overlay_w + 'px'
          else
            ch_hover_css.left = w / 2 - (overlay_w / 2) + 'px'
          if settings.overlay_y_position == 'top'
            ch_hover_css.top = 0
          else if settings.overlay_y_position == 'bottom'
            ch_hover_css.top = h - overlay_h + 'px'
          else
            ch_hover_css.top = h / 2 - (overlay_h / 2) + 'px'
          $ch_hover.css ch_hover_css
          # slide effect
          if settings.effect == 'slide'
            initial_css = {}
            if settings.slide_direction == 'top'
              initial_css = top: '-' + overlay_h + 'px'
            if settings.slide_direction == 'bottom'
              initial_css = top: h + 'px'
            if settings.slide_direction == 'left'
              initial_css = left: '-' + overlay_w + 'px'
            if settings.slide_direction == 'right'
              initial_css = left: w + 'px'
            $ch_hover.css('z-index', settings.zindex + 1).css initial_css
            $ch_wrapper.hover (->
              $ch_hover.stop(true, true).animate {
                'top': ch_hover_css.top
                'left': ch_hover_css.left
              }, settings.slide_speed, settings.onshow()
              return
            ), ->
              $ch_hover.stop(true, true).animate initial_css, settings.slide_speed, settings.onhide()
              return
            # fade effect
          else if settings.effect == 'fade'
            $ch_hover.css('z-index', settings.zindex + 1).hide()
            $ch_wrapper.hover (->
              $ch_hover.stop(true, true).fadeIn settings.fade_speed, settings.onshow()
              return
            ), ->
              $ch_hover.stop(true, true).fadeOut settings.fade_speed, settings.onhide()
              return
            # just show/hide
          else
            $ch_hover.css('z-index', settings.zindex + 1).hide()
            $ch_wrapper.hover (->
              $ch_hover.show 0, settings.onshow()
              return
            ), ->
              $ch_hover.hide 0, settings.onhide()
              return
        return
    stop: ->
      @each ->
        $this = $(this)
        $data = $this.next('.ch_element')
        $this.show()
        $data.remove()
        $this.unbind '.contenthover'
        return
    destroy: ->
      @each ->
        $(this).show()
        $('.ch_element').remove()
        $(window).unbind '.contenthover'
        return

  $.fn.contenthover = (method) ->
    if methods[method]
      return methods[method].apply(this, Array::slice.call(arguments, 1))
    else if typeof method == 'object' or !method
      return methods.init.apply(this, arguments)
    else
      $.error 'Method ' + method + ' does not exist in contentHover plugin.'
    return

  return
) jQuery
