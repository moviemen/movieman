###
# jQuery appear plugin
#
# Copyright (c) 2012 Andrey Sidorov
# licensed under MIT license.
#
# https://github.com/morr/jquery.appear/
#
# Version: 0.3.6
###

(($) ->
  selectors = []
  check_binded = false
  check_lock = false
  defaults = 
    interval: 250
    force_process: false
  $window = $(window)
  $prior_appeared = []
  # "appeared" custom filter

  appeared = (selector) ->
    $(selector).filter ->
      $(this).is ':appeared'

  process = ->
    check_lock = false
    index = 0
    selectorsLength = selectors.length
    while index < selectorsLength
      $appeared = appeared(selectors[index])
      $appeared.trigger 'appear', [ $appeared ]
      if $prior_appeared[index]
        $disappeared = $prior_appeared[index].not($appeared)
        $disappeared.trigger 'disappear', [ $disappeared ]
      $prior_appeared[index] = $appeared
      index++
    return

  add_selector = (selector) ->
    selectors.push selector
    $prior_appeared.push()
    return

  $.expr[':'].appeared = (element) ->
    $element = $(element)
    if !$element.is(':visible')
      return false
    window_left = $window.scrollLeft()
    window_top = $window.scrollTop()
    offset = $element.offset()
    left = offset.left
    top = offset.top
    if top + $element.height() >= window_top and top - ($element.data('appear-top-offset') or 0) <= window_top + $window.height() and left + $element.width() >= window_left and left - ($element.data('appear-left-offset') or 0) <= window_left + $window.width()
      true
    else
      false

  $.fn.extend appear: (options) ->
    opts = $.extend({}, defaults, options or {})
    selector = @selector or this
    if !check_binded

      on_check = ->
        if check_lock
          return
        check_lock = true
        setTimeout process, opts.interval
        return

      $(window).scroll(on_check).resize on_check
      check_binded = true
    if opts.force_process
      setTimeout process, opts.interval
    add_selector selector
    $ selector
  $.extend force_appear: ->
    if check_binded
      process()
      return true
    false
  return
) do ->
  if typeof module != 'undefined'
    # Node
    require 'jquery'
  else
    jQuery
