jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.sidebar-nav').affix();

  redraw_scrolling_div = ->
    new_width  = $('.medias').width() + 50
    new_height = $('html').height()   * 0.8
    $('.medias > .tab-content').css 'width',  new_width
    $('.medias > .tab-content').css 'height', new_height

  # onload
  redraw_scrolling_div()
  $('.medias > .tab-content').scrollTop(0)

  # onresize
  $(window).resize ->
    redraw_scrolling_div()

